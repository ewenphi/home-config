_: {
  flake.homeModules.pkgs-base-sys =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [
        pkgs.nh
        pkgs.nvd
        pkgs.nix-output-monitor
        pkgs.brightnessctl
        pkgs.caligula
        pkgs.cava
        pkgs.process-compose
        pkgs.wl-clipboard
        pkgs.git-subrepo
        pkgs.tree
      ];
    };
}
