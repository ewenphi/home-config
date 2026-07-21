{ self, ... }:
{
  flake.homeModules.home-common-work =
    { ... }:
    {
      imports = [
        self.homeModules.pkgs-base-dev
        self.homeModules.cli-apps
        self.homeModules.tools
        self.homeModules.zellij
        self.homeModules.nix
      ];

      targets.genericLinux.enable = true;
      home = {
        username = "ewen";
        homeDirectory = "/home/ewen";

        stateVersion = "23.11";

        packages = [ ];

        sessionVariables = {
          EDITOR = "nvim";
        };
      };
      programs.home-manager.enable = true;
    };
}
