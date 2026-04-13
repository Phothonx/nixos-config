{self, ...}: {
  flake.nixosModules.desktop = {pkgs, self', ...}: {
    imports = [
      # self.nixosModules.gtk
      self.nixosModules.pipewire
      self.nixosModules.firefox
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
