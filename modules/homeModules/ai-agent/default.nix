_: {
  flake.homeModules.ai-agent =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        mcp = {
          enable = true;
          servers = {
            astro = {
              enable = true;
              url = "https://mcp.docs.astro.build/mcp";
            };
            mcp-nixos = {
              enable = true;
              command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
            };
            git = {
              enable = true;
              command = "${pkgs.mcp-server-git}/bin/mcp-server-git";
            };
            sequential-thinking = {
              enable = true;
              command = "${pkgs.mcp-server-sequential-thinking}/bin/mcp-server-sequential-thinking";
            };
          };
        };

        claude-code = {
          enable = true;
          enableMcpIntegration = true;
          skills = ./skills;
        };
      };
      home.sessionPath = [
        "$HOME/.local/bin"
      ];
    };
}
