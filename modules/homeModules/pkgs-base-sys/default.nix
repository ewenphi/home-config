_: {
  flake.homeModules.pkgs-base-dev =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [
        pkgs.openssh
        pkgs.neovim
        pkgs.arp-scan
        pkgs.cloc
        pkgs.stow
        pkgs.libqalculate
        pkgs.htop
        pkgs.fastfetch
        pkgs.typst
        pkgs.icdiff
        pkgs.ngrok
        pkgs.wget
        pkgs.ripgrep
        pkgs.tealdeer
        pkgs.wikiman
        pkgs.broot
        pkgs.btop
        pkgs.unzip
        pkgs.commitizen
        pkgs.devenv
        pkgs.ncdu
        pkgs.jujutsu
        pkgs.lazyjj
        pkgs.hunk
      ];
    };
}
