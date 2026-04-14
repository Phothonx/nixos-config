{self, ...}: {
  flake.nixosModules.nico = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.sops
    ];

    users.mutableUsers = false;
    sops.secrets."user_passwords/nico" = {neededForUsers = true;};
    users.users.nico = {
      shell = pkgs.bashInteractive;
      hashedPasswordFile = config.sops.secrets."user_passwords/nico".path;
      # initialPassword = "12345";
      isNormalUser = true;
      group = "users";
      extraGroups = [
        "audio"
        "network"
        "video"
        "gamemode"
        "wheel"
        "networkmanager"
        "input"
        "dialout"
      ];
    };

    # https://wiki.nixos.org/wiki/Fish
    programs.bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.shell} $LOGIN_OPTION
      fi
    '';
  };
}
