{
  lib,
  inputs,
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    vim
    wget

    nvd
    nix-output-monitor
    nix-tree
    alejandra
    nixfmt
    nix-index

    man-pages
    man-pages-posix
  ];

  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://noctalia.cachix.org"
      ];
      trusted-substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://noctalia.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
      trusted-users = ["root" "@wheel"];
      allowed-users = ["root" "@wheel"];
      builders-use-substitutes = true;

      connect-timeout = 10;
      stalled-download-timeout = 100;
      download-attempts = 5;
      http-connections = 50;

      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      log-lines = 50;
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      flake-registry = ""; # Disable global flake registry
    };

    gc.automatic = false;

    # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    registry.self.flake = self;
    channel.enable = false;
  };

  documentation = {
    dev.enable = true;

    man = {
      # In order to enable to mandoc man-db has to be disabled.
      man-db.enable = false;
      mandoc.enable = true;
    };
  };

  environment.sessionVariables = {
    FLAKE = "/home/nico/Dev/nix-config/";
  };

  # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";
}
