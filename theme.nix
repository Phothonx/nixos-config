# https://github.com/Base24/tinted-home?tab=readme-ov-file
let
  theme = {
    base00 = "#11111b"; # ---- dark (bg)
    base01 = "#1e1e2e"; # --- (select bg)
    base02 = "#313244"; # --
    base03 = "#6c7086"; # -
    base04 = "#a6adc8"; # +
    base05 = "#cdd6f4"; # ++ (fg)
    base06 = "#cdd6f4"; # +++
    base07 = "#ffffff"; # ++++ light
    base08 = "#f38ba8"; # red
    base09 = "#fab387"; # orange
    base0A = "#f9e2af"; # yellow
    base0B = "#a6e3a1"; # green
    base0C = "#89dceb"; # cyan
    base0D = "#89b4fa"; # blue
    base0E = "#cba6f7"; # purple
    base0F = "#eba0ac"; # brown

    base10 = "#11111b"; # ----- dark
    base11 = "#000000"; # ------ dark
    base12 = "#f5c2e7"; # bright red
    base13 = "#f5e0dc"; # bright yellow
    base14 = "#94e2d5"; # bright green
    base15 = "#89dceb"; # bright cyan
    base16 = "#74c7ec"; # bright blue
    base17 = "#b4befe"; # bright purple
  };

  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in {
  flake = {
    inherit theme themeNoHash;
  };
}
