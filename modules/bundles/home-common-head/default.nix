{ self, ... }:
{
  flake.homeModules.home-common-head =
    { ... }:
    {
      imports = [
        self.homeModules.home-common
        self.homeModules.pkgs-graphique
        self.homeModules.pkgs-custom
        self.homeModules.apps
        self.homeModules.codium
        self.homeModules.retroarch
        self.homeModules.stylix
      ];
    };
}
