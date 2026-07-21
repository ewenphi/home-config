_: {
  flake.homeModules.zellij = _: {
    programs.zellij = {
      enable = true;
      settings.theme = "tokyo-night-storm";
      enableZshIntegration = true;
      attachExistingSession = true;
      extraConfig = "show_startup_tips false";
    };
  };
}
