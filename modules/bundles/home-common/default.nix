{ self, inputs, ... }:
{
  flake.homeModules.home-common =
    { pkgs, ... }:
    {
      imports = [
        self.homeModules.pkgs-base-sys
        self.homeModules.home-common-work
      ];

      home = {
        file = {
          status-projets-viewer-conf = {
            source =
              (inputs.nixago.lib.${pkgs.stdenv.hostPlatform.system}.make {
                output = "config.toml";
                format = "toml";
                data = {
                  projets = [
                    {
                      name = "status-projets-viewer";
                      location = "/home/ewen/projets/coding/status-projets-viewer";
                      git = true;
                    }
                    {
                      name = "home-config";
                      location = "/home/ewen/projets/coding/home-config";
                      git = true;
                    }
                    {
                      name = "filesort";
                      location = "/home/ewen/projets/coding/filesort";
                      git = true;
                    }
                    # {name = "gowiki"; location = "/home/ewen/projets/coding/gowiki"; git = true;}
                    # {name = "s6"; location = "/home/ewen/s6"; git = true;}
                    {
                      name = "wordle_yvaniak";
                      location = "/home/ewen/projets/coding/wordle_yvaniak";
                      git = true;
                    }
                    #{
                    #  name = "hugo-test";
                    #  location = "/home/ewen/projets/coding/hugo-test";
                    #  git = true;
                    #}
                    {
                      name = "docusaurus-test";
                      location = "/home/ewen/projets/coding/docusaurus-test";
                      git = true;
                    }
                    {
                      name = "templates/template-uv";
                      location = "/home/ewen/projets/coding/templates/template-uv";
                      git = true;
                    }
                    {
                      name = "mydevenvs";
                      location = "/home/ewen/projets/coding/mydevenvs";
                      git = true;
                    }
                    {
                      name = "portfolio-astro";
                      location = "/home/ewen/projets/coding/portfolio-astro";
                      git = true;
                    }
                  ];
                };
              }).configFile;
            target = "./.config/status-projets-viewer/config.toml";
          };
        };
      };
    };
}
