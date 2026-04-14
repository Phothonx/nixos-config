{...}: {
  flake.nixosModules.xdg = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        gnome-keyring
      ];
    };

    environment.systemPackages = with pkgs; [
      xdg-utils
      xdg-ninja
    ];
  };
}
