{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.astolat = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.astolatConfiguration
    ];
  };
}
