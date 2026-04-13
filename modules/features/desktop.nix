{self, ...}: {
  flake.nixosModules.desktop = {pkgs, ...}: {
    imports = [
      # self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
      self.nixosModules.chromium
    ];

    environment.systemPackages = [
      pkgs.pcmanfm
    ];

    security.polkit.enable = true;

    # TODO
    # services.xserver.xkb = {
    #   layout = "nico"; # fr
    #   variant = "basic";
    #   options = "caps:escape";
    #   extraLayouts = {
    #     nico = {
    #       description = "My custom xkb layout.";
    #       languages = ["eng" "fr"];
    #       symbolsFile = ../kblayouts/symbols/nico;
    #     };
    #   };
    # };
  };
}
