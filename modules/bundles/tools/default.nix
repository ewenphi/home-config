{ self, ... }:
{
  flake.homeModules.tools =
    { ... }:
    {
      imports = [
        self.homeModules.direnv
        self.homeModules.git
        self.homeModules.ai-agent
      ];
    };
}
