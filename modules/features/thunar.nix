{
  flake.nixosModules.thunar = {
    pkgs,
    ...
  }: {
    programs.xfconf.enable = true; # xfce
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images

    services.udisks2.enable = true;
    # services.gvfs.enable = true;
    environment.systemPackages = [
      pkgs.nautilus
    ];
  };
}
