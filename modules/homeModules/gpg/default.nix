_: {
  flake.homeModules.gpg =
    {
      pkgs,
      ...
    }:
    {
      programs.gpg.enable = true;
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentry.package = pkgs.pinentry-curses;
        maxCacheTtl = 300;
      };
    };
}
