{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.fish = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;

      package = pkgs.fish;
      extraPackages = with pkgs; [
        zoxide
        eza
        direnv
        git
        nh
      ];
      flags = {
        "-C" = "source ${./config.fish}";
      };
    };
  };
}
