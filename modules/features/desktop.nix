{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    ...
  }: {
    imports = [
      # self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.xkb
      self.nixosModules.xdg
    ];

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty

      pcmanfm
    ];

    security.polkit.enable = true;
  };
}
