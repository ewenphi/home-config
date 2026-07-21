{ self, ... }: {
  perSystem = _: {
    checks = {
      ewen-home = self.homeConfigurations.ewen.activation-script;
    };
  };
}
