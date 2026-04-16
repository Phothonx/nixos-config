{self, ...}: {
  flake.nixosModules.firefox = {pkgs, ...}: {
    programs.firefox = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.firefox;
    };
  };
}
