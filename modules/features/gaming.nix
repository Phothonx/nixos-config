{...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        protontricks.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # lutris
      # heroic
      # bottles
      # steamtinkerlaunch

      steam-run
      # dxvk
      # parsec-bin

      gamescope

      mangohud

      osu-lazer-bin
      # mindustry-wayland
      # atlauncher
      # prismlauncher

      # TODO albion
      # (pkgs.buildFHSEnv pkgs.appimageTools.defaultFhsEnvArgs // {
      #   name = "fhs-albion";
      #   targetPkgs = pkgs:
      #     with pkgs; [
      #       krb5
      #       libxau
      #       libxdmcp
      #     ];
      #   profile = ''export FHS=1'';
      #   runScript = "fish";
      # })

    ];

    # services.zerotierone.enable = true;

    # TODO substituters
    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
