{
  flake.nixosModules.discord = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.vesktop
      pkgs.discord
    ];
  };
}
