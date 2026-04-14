{self, ...}: {
  flake.nixosModules.desktop = {pkgs, self', ...}: {
    imports = [
      # self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.xkb
    ];

    programs.niri = {
      enable = true;
      package = self'.packages.niri;
    };

    environment.systemPackages = with pkgs; [
      self'.packages.noctalia
      self'.packages.kitty

      pcmanfm
    ];

    security.polkit.enable = true;
  };
}
