{
  inputs,
  ...
}: {
  # TODO finish
  flake.nixosModules.impermanence = {...}: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    persistance.enable = true;
  };
}
