{ self, ... }:
{
  flake.homeModules.apps =
    { ... }:
    {
      imports = [
        self.homeModules.ghostty
      ];
      services.nextcloud-client.enable = true;
    };
}
