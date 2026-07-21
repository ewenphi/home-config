#!/usr/bin/env bash
# Analyze script for just-all skill
# Runs 'just a' and analyzes the output for issues
# Designed to be called by the just-all vibe skill

set -euo pipefail

# Colors for output (optional, can be disabled)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if colors are supported
if [ ! -t 1 ]; then
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    NC=''
fi

echo -e "${BLUE}=== Running Full Pipeline: just a ===${NC}"
echo ""

# Run just a and capture output + timing
start_time=$(date +%s)
output=$(just a 2>&1) || true
end_time=$(date +%s)

elapsed=$((end_time - start_time))
echo -e "${GREEN}Completed in ${elapsed}s${NC}"
echo ""

# ============================================================
# ANALYSIS
# ============================================================
echo -e "${BLUE}=== ANALYSIS RESULTS ===${NC}"
echo ""

# Initialize counters
declare -A issue_counts
issue_counts=(
    ["Build Errors"]=0
    ["Test Failures"]=0
    ["Clippy Warnings"]=0
    ["Pre-commit Failures"]=0
    ["Doc Errors"]=0
    ["Nix Errors"]=0
)

# Initialize arrays for storing details
declare -A issue_details
for key in "${!issue_counts[@]}"; do
    issue_details["$key"]=""
done

# Function to count and collect issues
count_issues() {
    local category=$1
    local pattern=$2
    local count=$(echo "$output" | grep -c "$pattern" || true)
    issue_counts["$category"]=$count
    if [ "$count" -gt 0 ]; then
        issue_details["$category"]=$(echo "$output" | grep "$pattern" | head -10)
    fi
}

# Count each type of issue
count_issues "Build Errors" "error\[E"          # Rust compiler errors
count_issues "Build Errors" "Could not compile"
count_issues "Test Failures" "test result: FAILED"
count_issues "Test Failures" "FAILED.*test "
count_issues "Test Failures" "panicked at"
count_issues "Clippy Warnings" "warning:"
count_issues "Pre-commit Failures" "Failed"     # Pre-commit failures
count_issues "Doc Errors" "doc test failed"
count_issues "Nix Errors" "flake check failed"

# Special handling for pre-commit (distinguish from other "Failed")
precommit_section=$(echo "$output" | sed -n '/pre-commit-all/,/^$/p' || true)
if [ -n "$precommit_section" ]; then
    precommit_failed=$(echo "$precommit_section" | grep -c "Failed" || true)
    if [ "$precommit_failed" -gt "${issue_counts[Pre-commit Failures]}" ]; then
        issue_counts["Pre-commit Failures"]=$precommit_failed
        issue_details["Pre-commit Failures"]=$(echo "$precommit_section" | grep "Failed")
    fi
fi

# Print summary table
printf "%-25s %s\n" "Issue Type" "Count"
printf "%-25s %s\n" "---------------------" "-----"

total_issues=0
for category in "${!issue_counts[@]}"; do
    count=${issue_counts["$category"]}
    total_issues=$((total_issues + count))
    if [ "$count" -gt 0 ]; then
        printf "${RED}%-25s %s${NC}\n" "$category" "$count"
    else
        printf "${GREEN}%-25s %s${NC}\n" "$category" "$count"
    fi
done

printf "\n${BLUE}Total Issues: %d${NC}\n" "$total_issues"
echo ""

# ============================================================
# DETAILED BREAKDOWN
# ============================================================

if [ "$total_issues" -gt 0 ]; then
    echo -e "${BLUE}=== DETAILED BREAKDOWN ===${NC}"
    echo ""
    
    # Build Errors
    if [ "${issue_counts[Build Errors]}" -gt 0 ]; then
        echo -e "${RED}--- Build Errors ---${NC}"
        echo "$output" | grep -E "error\[E[0-9]+" || true
        echo "$output" | grep "Could not compile" || true
        echo ""
        echo "Suggested fixes:"
        echo "  - For error[E0599]: Check method existence, add #[allow(dead_code)], or implement method"
        echo "  - For type errors: Use explicit type conversion (.parse(), as, into())"
        echo "  - For trait errors: Implement missing traits or add #[derive(...)]"
        echo ""
    fi

    # Test Failures
    if [ "${issue_counts[Test Failures]}" -gt 0 ]; then
        echo -e "${RED}--- Test Failures ---${NC}"
        echo "$output" | grep -E "test .*FAILED|FAILED.*test " || true
        echo "$output" | grep "panicked at" || true
        echo ""
        echo "Suggested fixes:"
        echo "  - Run: cargo test <test_name> -- --nocapture --test-threads=1"
        echo "  - Check assertion logic and expected vs actual values"
        echo "  - Add debug prints before the failing assertion"
        echo ""
    fi

    # Clippy Warnings
    if [ "${issue_counts[Clippy Warnings]}" -gt 0 ]; then
        echo -e "${YELLOW}--- Clippy Warnings ---${NC}"
        echo "$output" | grep "warning:" | head -20 || true
        echo ""
        echo "Suggested fixes:"
        echo "  - unused variable: Prefix with _ or use the variable"
        echo "  - unnecessary clone: Remove .clone() or restructure code"
        echo "  - Run 'cargo clippy' for full list of warnings"
        echo ""
    fi

    # Pre-commit Failures
    if [ "${issue_counts[Pre-commit Failures]}" -gt 0 ]; then
        echo -e "${RED}--- Pre-commit Failures ---${NC}"
        echo "$output" | grep -B 2 "Failed" | grep -v "^--$" || true
        echo ""
        echo "Suggested fixes:"
        echo "  - Run: pre-commit run --all-files"
        echo "  - Run specific hook: pre-commit run <hook_id> --all-files"
        echo "  - Common fixes:"
        echo "    * rustfmt: cargo fmt"
        echo "    * clippy: cargo clippy"
        echo "    * taplo: taplo format"
        echo ""
    fi

    # Doc Errors
    if [ "${issue_counts[Doc Errors]}" -gt 0 ]; then
        echo -e "${RED}--- Documentation Errors ---${NC}"
        echo "$output" | grep "doc test" || true
        echo ""
        echo "Suggested fixes:"
        echo "  - Add doc comments (/// or /**) to documented items"
        echo "  - Run: cargo test --doc"
        echo "  - Fix intra-doc links to point to existing items"
        echo ""
    fi

    # Nix Errors
    if [ "${issue_counts[Nix Errors]}" -gt 0 ]; then
        echo -e "${RED}--- Nix Errors ---${NC}"
        echo "$output" | grep "nix\|flake" | grep -i "error" || true
        echo ""
        echo "Suggested fixes:"
        echo "  - Run: nix flake check --no-pure-eval"
        echo "  - Check flake.nix for correct output definitions"
        echo "  - Verify supportedSystems includes your platform"
        echo ""
    fi
else
    echo -e "${GREEN}=== ALL CHECKS PASSED ===${NC}"
    echo ""
    echo "No issues detected in the pipeline!"
    echo "Your code passes all quality checks."
fi

# ============================================================
# NEXT STEPS
# ============================================================
echo -e "${BLUE}=== NEXT STEPS ===${NC}"
echo ""

if [ "${issue_counts[Build Errors]}" -gt 0 ]; then
    echo "1. Fix build errors and re-run: just build"
fi

if [ "${issue_counts[Test Failures]}" -gt 0 ]; then
    echo "2. Investigate test failures: cargo test -- --nocapture"
fi

if [ "${issue_counts[Clippy Warnings]}" -gt 0 ]; then
    echo "3. Address clippy warnings: cargo clippy"
fi

if [ "${issue_counts[Pre-commit Failures]}" -gt 0 ]; then
    echo "4. Fix pre-commit issues: pre-commit run --all-files"
fi

if [ "${issue_counts[Doc Errors]}" -gt 0 ]; then
    echo "5. Fix documentation: cargo test --doc"
fi

if [ "${issue_counts[Nix Errors]}" -gt 0 ]; then
    echo "6. Fix nix issues: nix flake check"
fi

if [ "$total_issues" -eq 0 ]; then
    echo "All checks passed! Ready to commit."
fi

echo ""
echo "To re-run the full pipeline: just a"

exit 0
