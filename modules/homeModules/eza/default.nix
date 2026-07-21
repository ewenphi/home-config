_: {
  flake.homeModules.eza = _: {
    programs.eza = {
      enable = true;
      git = true;
      colors = "always";
      icons = "always";
      enableZshIntegration = true;
    };
  };
}
