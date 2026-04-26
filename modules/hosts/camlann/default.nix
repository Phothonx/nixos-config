{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.camlann = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.camlannConfiguration
    ];
  };
}
