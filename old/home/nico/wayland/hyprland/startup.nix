{
  config,
  pkgs,
  ...
}: let
  inherit (config) wallpaper cursor;
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = with pkgs; [
      "${awww}/bin/swww-daemon"
      "${awww}/bin/swww img ${wallpaper} --transition-type none"

      "hyprctl setcursor ${cursor.name} ${builtins.toString cursor.size}"

      "${pkgs.systemd}/bin/systemctl --user start ${hyprpolkitagent}/bin/hyprpolkitagent"

      "noctalia-shell"
    ];
  };
}
