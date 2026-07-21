{ inputs, ... }: {
  imports = [
    inputs.mydevenvs.flakeModule
    inputs.mydevenvs.devenv
  ];
  perSystem = _: {
    devenv.shells.default = {
      mydevenvs = {
        nix = {
          enable = true;
          flake.enable = true;
        };
        tools.just = {
          enable = true;
          pre-commit.enable = true;
          check.enable = true;
        };
      };
      enterShell = "echo hello from home-config";
    };
  };
}
