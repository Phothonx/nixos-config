{...}: {
  flake.nixosModules.gaming = {pkgs, ...}: {
    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        protontricks.enable = true;
        gamescopeSession.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      # lutris
      heroic
      protonup-qt
      # bottles
      # steamtinkerlaunch

      steam-run
      # dxvk
      # parsec-bin

      mangohud

      osu-lazer-bin
      # mindustry-wayland
      # atlauncher
      # prismlauncher

      (pkgs.buildFHSEnv (pkgs.appimageTools.defaultFhsEnvArgs // {
        name = "fhs-albion";
        targetPkgs = pkgs:
          (pkgs.appimageTools.defaultFhsEnvArgs.targetPkgs pkgs)
          ++ (with pkgs; [
            krb5
            libxau
            libxdmcp
          ]);

        profile = ''export FHS=1'';
        runScript = "fish";
      }))

    ];

    # services.zerotierone.enable = true;
  };
}
