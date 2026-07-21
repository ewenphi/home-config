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

  flake.homeConfigurations.ewen = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = mkPkgs system;
    modules = [
      self.homeModules.ewenModule
    ];

  };

  flake.homeModules.ewenModule = { ... }: {

    imports = [
      self.homeModules.home-common-head
      self.homeModules.security
    ];

    programs.git.settings.user = {
      email = "ewen.philippot@etu.umontpellier.fr";
      name = "Ewen Philippot";
    };
    home = {
      username = lib.mkForce "ewen";
      homeDirectory = lib.mkForce "/home/ewen";
    };
  };
}
