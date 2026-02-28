{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
let
  myTexLive = pkgs.texliveFull.withPackages (ps: with ps; [ movie15 ]);
in
{
  options = {
    graphique.enable = lib.mkEnableOption "install graphic packages module";
  };

  config = lib.mkIf config.graphique.enable {
    targets.genericLinux.nixGL = {
      inherit (inputs.nixgl) packages;
      defaultWrapper = "mesa";
      installScripts = [ "mesa" ];
    };

    home.packages = [
      pkgs.bugdom

      pkgs.jellyfin-web
      pkgs.thunderbird
      pkgs.distrobox
      pkgs.caprine-bin
      pkgs.wasistlos
      pkgs.gimp
      pkgs.krita

      pkgs.kdePackages.ark
      pkgs.baobab
      pkgs.gparted
      pkgs.eog

      pkgs.rofi-pass-wayland
      pkgs.nix-search

      pkgs.mate.atril
      myTexLive
      pkgs.pdfpc

      pkgs.podman
      pkgs.nixpacks

      (config.lib.nixGL.wrap pkgs.nemo-with-extensions)
      (config.lib.nixGL.wrap pkgs.quickemu)
      (config.lib.nixGL.wrap pkgs.jetbrains-toolbox)
      (config.lib.nixGL.wrap pkgs.vlc)
      (config.lib.nixGL.wrap pkgs.libreoffice-fresh)
      (config.lib.nixGL.wrap pkgs.discord)
      (config.lib.nixGL.wrap pkgs.dolphin-emu)
      (config.lib.nixGL.wrap pkgs.firefox)
      (config.lib.nixGL.wrap pkgs.godot_4-mono)
      (config.lib.nixGL.wrap pkgs.prismlauncher)
      (config.lib.nixGL.wrap pkgs.heroic)
    ];
  };
}
