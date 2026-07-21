_: {
  flake.homeModules.git =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = [
        pkgs.gitoxide
        pkgs.lazygit
      ];

      programs = {
        git = {
          enable = true;
          ignores = [
            "*~"
            "*.swp"
          ];
          settings.user = {
            email = lib.mkDefault "ewen.philippot@etu.umontpellier.fr";
            name = lib.mkDefault "Ewen Philippot";
          };
          signing.format = "openpgp";
        };
        difftastic = {
          git.enable = true;
          enable = true;
          options = {
            color = "always";
          };
        };
      };
    };
}
