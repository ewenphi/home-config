{ self, ... }:
{
  flake.homeModules.security =
    { ... }:
    {
      imports = [
        self.homeModules.gpg
        self.homeModules.pass
      ];
    };
}
