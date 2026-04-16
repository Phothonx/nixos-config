{self, ...}: {
  flake.nixosModules.ssh = {...}: {
    imports = [
      self.nixosModules.agenix
    ];

    programs.ssh = {
      enable = true;
    };
  };
}
