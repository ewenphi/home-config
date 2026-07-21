---
name: just-all
description: Run 'just a' to execute the full tooling pipeline (pre-commit, build, tests, docs, nix-checks) and analyze results with proposed fixes.
license: MIT
user-invocable: true
---

# Just-All Skill

## Purpose

Run your complete quality assurance pipeline with a single command and get intelligent analysis of any issues found, with actionable fix suggestions.

## What it does

1. **Runs `just a`** - Executes your full tooling pipeline:
   - `pre-commit-all` - All pre-commit hooks on all files
   - `build` - Cargo build
   - `tests` - All tests (nextest + doc tests)
   - `docs` - Documentation build
   - `build-release` - Release mode build
   - `nix-checks` - Nix flake validation (if available)

2. **Analyzes output** - Parses the output to identify:
   - Build errors (Rust compiler errors)
   - Test failures (failed test cases)
   - Clippy/lint warnings
   - Pre-commit hook failures
   - Documentation errors
   - Nix flake errors

3. **Proposes fixes** - For each issue, suggests:
   - The exact command to re-run for details
   - Likely causes
   - Potential solutions
   - File locations when available

## Usage

### Invoke the skill

Use the slash command `/just-all` in the Vibe CLI, or load via the skill tool.

The skill will:

1. Run `just a` and capture all output
2. Analyze the output for errors and warnings
3. Present a categorized summary
4. Provide fix suggestions

### Manual commands

```bash
# Run everything
just a

# Run specific parts
just build        # Just compile
just tests        # Just tests
just pre-commit   # Just pre-commit hooks
just docs         # Just documentation
just nix-checks   # Just nix validation

# With verbose output
just -v a

# See what each alias does
just --list
```

## Analysis Patterns

### Build Errors

**Patterns:** `error[EXXXX]`, `Could not compile`, `mismatched types`, `method not found`, `trait bound`

**Fixes:**

- `error[E0599]: no method named 'push' on type '&str'` → Use `.to_string()` or `String::from()` first
- `error[E0277]: trait bound not satisfied` → Add `#[derive(Debug)]` or implement the trait
- `mismatched types` → Convert types explicitly with `.parse()`, `as`, or `into()`

### Test Failures

**Patterns:** `test result: FAILED`, `FAILED`, `assertion failed`, `panicked at`, `assert_eq!`

**Fixes:**

- Run `cargo test <name> -- --nocapture --test-threads=1` for details
- Check assertion logic and expected vs actual values
- Add bounds checking for panics

### Clippy Warnings

**Patterns:** `warning: unused variable`, `warning: unnecessary`, `clippy::`

**Fixes:**

- `unused variable: x` → Prefix with `_x` or use it
- `unnecessary clone` → Remove `.clone()` or restructure
- `if let could be while let` → Change to `while let`

### Pre-commit Failures

**Patterns:** `<unknown>...Failed`, `error:`

**Common hooks:**

- black → `black .`
- isort → `isort .`
- flake8 → Check specific line/column
- taplo → `taplo format`
- rustfmt → `cargo fmt`
- clippy → `cargo clippy`

### Documentation Errors

**Patterns:** `doc test failed`, `missing documentation`, `intra-doc link`

**Fixes:**

- Add `///` doc comments
- Run `cargo test --doc <name> -- --nocapture`
- Check referenced items exist and are public

### Nix Errors

**Patterns:** `flake check failed`, `attribute not found`, `unsupported system`

**Fixes:**

- Run `nix flake check` for details
- Check flake.nix output definitions
- Add system to `supportedSystems`

## Workflow

1. Run `just a` and capture output
2. Categorize issues by type with counts
3. Extract relevant lines for each issue type
4. Suggest specific fixes based on patterns
