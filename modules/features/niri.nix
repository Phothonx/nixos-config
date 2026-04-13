{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, ... }: {
    packages.myNiri = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      settings = {
        # spawn-at-startup = [
        #   (lib.getExe self'.packages.myNoctalia)
        # ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          # "Mod+C".close-window = null;
          # "Mod+R".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
