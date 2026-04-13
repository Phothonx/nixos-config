{ self, inputs, ... }: {
  flake.nixosConfigurations.avalon = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.avalonConfiguration
    ];
  };
}
