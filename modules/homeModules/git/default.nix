_: {
  flake.homeModules.git =
    {
      pkgs,
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
            email = "ewen.philippot@etu.umontpellier.fr";
            name = "Ewen Philippot";
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
