_: {
  flake.homeModules.pass =
    {
      pkgs,
      ...
    }:
    {
      programs = {
        password-store = {
          enable = true;
          settings = {
            PASSWORD_STORE_DIR = "/home/ewen/.local/share/password-store";
          };
          package = pkgs.pass.withExtensions (
            ext: with ext; [
              pass-audit
              pass-import
              pass-update
              pass-otp
              pass-checkup
            ]
          );
        };
      };
    };
}
