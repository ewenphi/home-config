{ self, ... }:
{
  flake.homeModules.pkgs-base =
    { ... }:
    {
      imports = [
        self.homeModules.pkgs-base-dev
        self.homeModules.pkgs-base-sys
        self.homeModules.nvf
      ];
    };
}
