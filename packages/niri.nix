{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.niri = inputs.wrappers.wrappers.niri.wrap {
      inherit pkgs;

      extraPackages = with pkgs; [
        bibata-cursors
      ];

      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.noctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          warp-mouse-to-focus = _:{};
          focus-follows-mouse = _:{};

          keyboard = {
            xkb.layout = "nico,us,fr";
            repeat-rate = 40;
            repeat-delay = 250;
          };

          touchpad = {
            natural-scroll = _:{};
            tap = _:{};
            dwt = _:{};
            scroll-factor = 0.8;
            accel-profile = "flat";
          };

          mouse = {
            accel-speed = 0.1;
            accel-profile = "flat";
          };
        };

        cursor = {
          xcursor-theme = "Bibata-Modern-Ice";
          xcursor-size = 22;
        };

        window-rule = {
          geometry-corner-radius = 12;
          clip-to-geometry = true;
        };

        prefer-no-csd = _:{};

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = {};

          "Mod+T".spawn-sh = lib.getExe self'.packages.kitty;
          "Mod+D".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call launcher toggle";
          "Super+Alt+L".spawn-sh = "${lib.getExe self'.packages.noctalia} ipc call lockScreen toggle";


          "Mod+Q".close-window = {};


          "Mod+H".focus-column-left = {};
          "Mod+J".focus-window-down = {};
          "Mod+K".focus-window-up = {};
          "Mod+L".focus-column-right = {};

          "Mod+Left".focus-column-left = {};
          "Mod+Down".focus-window-down = {};
          "Mod+Up".focus-window-up = {};
          "Mod+Right".focus-column-right = {};


          "Mod+Ctrl+H".move-column-left = {};
          "Mod+Ctrl+J".move-window-down = {};
          "Mod+Ctrl+K".move-window-up = {};
          "Mod+Ctrl+L".move-column-right = {};

          "Mod+Ctrl+Left".move-column-left = {};
          "Mod+Ctrl+Down".move-window-down = {};
          "Mod+Ctrl+Up".move-window-up = {};
          "Mod+Ctrl+Right".move-column-right = {};


          "Mod+Shift+H".focus-monitor-left = {};
          "Mod+Shift+J".focus-monitor-down = {};
          "Mod+Shift+K".focus-monitor-up = {};
          "Mod+Shift+L".focus-monitor-right = {};

          "Mod+Shift+Left".focus-monitor-left = {};
          "Mod+Shift+Down".focus-monitor-down = {};
          "Mod+Shift+Up".focus-monitor-up = {};
          "Mod+Shift+Right".focus-monitor-right = {};


          "Mod+Ctrl+Shift+H".move-column-to-monitor-left = {};
          "Mod+Ctrl+Shift+J".move-column-to-monitor-down = {};
          "Mod+Ctrl+Shift+K".move-column-to-monitor-up = {};
          "Mod+Ctrl+Shift+L".move-column-to-monitor-right = {};

          "Mod+Ctrl+Shift+Left".move-column-to-monitor-left = {};
          "Mod+Ctrl+Shift+Down".move-column-to-monitor-down = {};
          "Mod+Ctrl+Shift+Up".move-column-to-monitor-up = {};
          "Mod+Ctrl+Shift+Right".move-column-to-monitor-right = {};


          "Mod+U".focus-workspace-down = {};
          "Mod+I".focus-workspace-up = {};

          "Mod+Page_Down".focus-workspace-down = {};
          "Mod+Page_Up".focus-workspace-up = {};


          "Mod+Ctrl+U".move-column-to-workspace-down = {};
          "Mod+Ctrl+I".move-column-to-workspace-up = {};

          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = {};
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = {};


          "Mod+Shift+U".move-workspace-down = {};
          "Mod+Shift+I".move-workspace-up = {};

          "Mod+Shift+Page_Down".move-workspace-down = {};
          "Mod+Shift+Page_Up".move-workspace-up = {};


          "Mod+Comma".consume-window-into-column = {};
          "Mod+Period".expel-window-from-column = {};

          "Mod+BracketLeft".consume-or-expel-window-left = {};
          "Mod+BracketRight".consume-or-expel-window-right = {};

          "Mod+R".switch-preset-column-width = {};
          "Mod+Shift+R".switch-preset-window-height = {};

          "Mod+F".maximize-column = {};
          "Mod+C".center-column = {};

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+Ctrl+R".reset-window-height = {};

          "Mod+Shift+F".fullscreen-window = {};
          "Mod+V".toggle-window-floating = {};
          "Mod+Shift+V".switch-focus-between-floating-and-tiling = {};

          "Print".screenshot = {};
          "Alt+Print".screenshot-window = {};
          "Ctrl+Print".screenshot-screen = {};

          "Mod+Shift+E".quit = {};
          "Ctrl+Alt+Delete".quit = {};
        };
      };
    };
  };
}
