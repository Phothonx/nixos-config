{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.noctalia = inputs.wrappers.wrappers.noctalia-shell.wrap {
      inherit pkgs;

      # settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
