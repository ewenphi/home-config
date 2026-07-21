{ inputs, ... }: {
  config = {
    systems = [
      "x86_64-linux"
      "aarch64-linux"
      "aarch64-darwin"
    ];

  };
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];
}
