_: {
  flake.homeModules.retroarch =
    {
      pkgs,
      ...
    }:
    {
      home.packages = [
        (pkgs.retroarch.withCores (_cores: [
          pkgs.libretro.flycast
          pkgs.libretro.pcsx2
          pkgs.libretro.dolphin
        ]))
      ];
    };
}
