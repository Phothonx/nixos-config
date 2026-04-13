{self, inputs, ...}: {
  flake.nixosModules.nix = {pkgs, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];
    programs.nix-index-database.comma.enable = true;

    programs.direnv = {
      enable = true;
      silent = false;
      loadInNixShell = true;
      direnvrcExtra = "";
      nix-direnv.enable = true;
    };

    programs.nix-ld.enable = true;

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnsupportedSystem = true;

    nix = {
      settings.experimental-features = ["nix-command" "flakes"];

      registry.self.flake = self;

      channel.enable = false;
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nix-tree
      nil
      nixd
      alejandra
      nixfmt
      nix-inspect
      manix
      nix-inspect
    ];
  };
}
