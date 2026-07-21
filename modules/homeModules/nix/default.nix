{ inputs, ... }: {
  flake.homeModules.nix =
    {
      pkgs,
      ...
    }:
    {
      nix = {
        registry.nixpkgs.flake = inputs.nixpkgs;
        package = pkgs.nix;
        gc.automatic = true;
      };
    };
}
