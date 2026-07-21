_: {
  flake.homeModules.pkgs-custom =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [
        pkgs.filesort
        pkgs.status-projets-viewer
        pkgs.flake-checker
      ];
    };
}
