{ inputs, ... }: {
  flake.homeModules.pkgs-graphique =
    {
      pkgs,
      config,
      ...
    }:
    {
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
        pkgs.karere
        pkgs.gimp
        pkgs.krita

        pkgs.kdePackages.ark
        pkgs.baobab
        pkgs.gparted
        pkgs.eog

        pkgs.rofi-pass-wayland
        pkgs.nix-search

        pkgs.atril
        pkgs.texliveFull
        pkgs.pdfpc

        #customNeovim.neovim

        pkgs.podman
        pkgs.nixpacks

        pkgs.dbeaver-bin

        pkgs.transmission_4-gtk

        (config.lib.nixGL.wrap pkgs.nemo-with-extensions)
        (config.lib.nixGL.wrap pkgs.quickemu)
        (config.lib.nixGL.wrap pkgs.jetbrains-toolbox)
        (config.lib.nixGL.wrap pkgs.vlc)
        (config.lib.nixGL.wrap pkgs.libreoffice-fresh)
        (config.lib.nixGL.wrap pkgs.discord)
        (config.lib.nixGL.wrap pkgs.dolphin-emu)
        (config.lib.nixGL.wrap pkgs.firefox)
        (config.lib.nixGL.wrap pkgs.godot_4-mono)
        (config.lib.nixGL.wrap pkgs.heroic)
      ];
    };
}
