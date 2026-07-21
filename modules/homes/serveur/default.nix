{
  self,
  inputs,
  lib,
  ...
}:
let
  customPkgsOverlay = system: _final: _prev: {
    nix-search = inputs.nix-search.packages.${system}.default;
    filesort = inputs.filesort.packages.${system}.default;
    status-projets-viewer = inputs.status-projets-viewer.packages.${system}.default;
  };

  mkPkgs =
    system:
    import inputs.nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        (customPkgsOverlay system)
      ];
    };

  system = "x86_64-linux";
in
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations.serveur = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = mkPkgs system;
    modules = [
      self.homeModules.serveurModule
    ];

  };

  flake.homeModules.serveurModule = { ... }: {

    imports = [
      self.homeModules.home-common
    ];

    programs.git.settings.user = {
      email = "";
      name = "";
    };
    home = {
      username = lib.mkForce "serveur";
      homeDirectory = lib.mkForce "/home/serveur";
    };
  };
}
