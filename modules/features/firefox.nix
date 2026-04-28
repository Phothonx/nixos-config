{self, ...}: {
  flake.nixosModules.firefox = {
    pkgs,
    lib,
    ...
  }: {
    programs.firefox = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.firefox;

      # broken in wrapper for now
      policies = lib.importJSON ../../packages/firefox/policies.json;
    };
  };
}
