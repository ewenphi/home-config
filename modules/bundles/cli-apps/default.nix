{ self, inputs, ... }:
{
  flake.homeModules.cli-apps =
    { ... }:
    {
      imports = [
        self.homeModules.eza
        self.homeModules.bat
        self.homeModules.zsh
        inputs.nix-index-database.homeModules.nix-index
      ];

      programs = {
        nix-index-database.comma.enable = true;
      };
    };
}
