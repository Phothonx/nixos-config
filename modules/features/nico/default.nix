{self, ...}: {
  flake.nixosModules.nico = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      # self.nixosModules.impermanence
    ];

    users.mutableUsers = false;

    users.users.nico = {
      shell = pkgs.bashInteractive;
      hashedPasswordFile = config.age.secrets.psswd_nico.path;
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
    programs.fish.enable = true;
    programs.fish.package = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;

    programs.bash.interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.shell} $LOGIN_OPTION
      fi
    '';

    # environment.persistence."/persist".users.nico = {
    #   directories = [
    #     "Downloads"
    #     "Music"
    #     "Pictures"
    #     "Documents"
    #     "Videos"
    #     "nixos-config"
    #     { directory = ".ssh"; mode = "0700"; }
    #     ".local/state/wireplumber"
    #     ".local/share/direnv"
    #
    #     ".cache/mozilla"
    #     ".config/vesktop"
    #     ".local/share/Steam"
    #     ".local/share/osu"
    #     ".local/share/albiononline"
    #     ".local/share/applications"
    #     ".config/obs-studio"
    #
    #     ".local/share/zoxide"
    #     ".local/share/direnv"
    #     ".local/share/nvim"
    #     ".local/share/fish"
    #     ".config/nvim"
    #   ];
    #   files = [
    #   ];
    # };
  };
}
