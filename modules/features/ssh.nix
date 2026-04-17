{self, ...}: {
  flake.nixosModules.ssh = {...}: {
    imports = [
      self.nixosModules.agenix
    ];

    # TODO ssh
    programs.ssh = {
      enable = true;
    };
  };
}
