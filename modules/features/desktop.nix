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

    services.udisks2.enable = true; # nautilus
    services.gvfs.enable = true; # nautilus
    environment.systemPackages = [
      pkgs.nautilus

      pkgs.bibata-cursors
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia
      self.packages.${pkgs.stdenv.hostPlatform.system}.kitty
    ];

    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.ubuntu
        noto-fonts-color-emoji
      ];
      fontconfig.defaultFonts = {
        emoji = ["Noto Color Emoji"];
        serif = ["Ubuntu"];
        sansSerif = ["Ubuntu Nerd Font"];
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };

    services.gnome.gnome-keyring.enable = lib.mkForce false;
    security.polkit.enable = true;
  };
}
