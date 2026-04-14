{self, ...}: {
  flake.nixosModules.desktop = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      # self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.thunar
      self.nixosModules.xkb
      self.nixosModules.xdg
    ];

    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${self.packages.${pkgs.stdenv.hostPlatform.system}.niri}/bin/niri-session";
        user = "nico";
      };
    };

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
    ];

    services.gnome.gnome-keyring.enable = lib.mkForce false;
    security.polkit.enable = true;
  };
}
