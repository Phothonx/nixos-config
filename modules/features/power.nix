{
  flake.nixosModules.power = {...}: {
    services.thermald.enable = true;
    services.upower.enable = true;
    services.tuned.enable = true;
  };
}
