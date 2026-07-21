{ inputs, ... }: {
  flake.homeModules.stylix =
    {
      pkgs,
      ...
    }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];
      stylix = {
        image =
          pkgs.fetchFromGitHub {
            owner = "decaycs";
            repo = "wallpapers";
            rev = "6af325f89ce8c39bc134292f65f51349233c23c0";
            hash = "sha256-5XVkJQkYkjdSZq3ElbRHFk6xV6slm7HY7ZTCdKPDnGo=";
          }
          + "/landscapes/conv-BikeRocketHill.png";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

        cursor = {
          package = pkgs.rose-pine-cursor;
          name = "BreezeX-RosePine-Linux";
          size = 32;
        };

        autoEnable = false;
        targets = {
          btop.enable = true;
          cava.enable = true;
          eog.enable = true;
          firefox.enable = true;
          firefox.firefoxGnomeTheme.enable = true;
          fzf.enable = true;
          gedit.enable = true;
          gnome.enable = true;
          gtk = {
            enable = true;
            flatpakSupport.enable = true;
          };
          kitty.enable = true;
          kitty.variant256Colors = true;
          lazygit.enable = true;
          neovim.enable = true;
          zellij.enable = true;
        };
      };
    };
}
