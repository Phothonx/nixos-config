{...}: {
  imports = [
    ./openvpn.nix
    ./gaming.nix
    ./sops.nix
    ./bluetooth.nix
    ./fish.nix
    ./greetd.nix
    ./hyprland.nix
    ./networking.nix
    ./nh.nix
    ./pipewire.nix
    # ./quietboot.nix
    ./systemd-boot.nix
    # ./tlp.nix
    ./xkb.nix
    ./steam.nix
    ./graphics.nix
    ./nix-ld.nix
    ./udev.nix
    ./power.nix
    ./utils.nix
  ];
}
