{self, ...}: {
  flake.nixosModules.avalonConfiguration = {pkgs, ...}: {
    imports = [
      self.nixosModules.avalonHardware

      self.nixosModules.nix
      self.nixosModules.power
      self.nixosModules.nh
      self.nixosModules.desktop
      self.nixosModules.sops

      self.nixosModules.nico
    ];

    # TODO see corectrl
    # TODO ssh

    environment.systemPackages = with pkgs; [
      mission-planner
      # kdePackages.kdenlive
      evemu
      celluloid
      vlc
      loupe
      imv
      bitwarden-desktop
      spotify
      localsend
      teamspeak6-client
      ungoogled-chromium
      vesktop
      discord
      pavucontrol
      crosspipe
      wl-clipboard
    ];

    programs.obs-studio = {
      enable = true;
      plugins = with pkgs; [
        obs-studio-plugins.wlrobs
      ];
    };

    services.logind = {
      settings.Login = {
        HandlePowerKey = "suspend";
      };
    };

    boot = {
      # to detect mouse & keybr at startup
      initrd.availableKernelModules = ["hid_cherry"];

      tmp.cleanOnBoot = true;
      loader = {
        systemd-boot = {
          enable = true;
        };
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "avalon";
      networkmanager.enable = true;
    };

    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "Europe/Paris";

    hardware = {
      enableAllFirmware = true;

      bluetooth.enable = true;
      bluetooth.powerOnBoot = false;

      graphics.enable = true;
      graphics.enable32Bit = true;
    };

    services.udev = {
      extraRules = ''
        KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f58c", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3554", ATTRS{idProduct}=="f58a", MODE="0666", TAG+="uaccess"

        KERNEL=="hidraw*", ATTRS{idVendor}=="2109", ATTRS{idProduct}=="0817", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="2109", ATTRS{idProduct}=="2817", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="2109", ATTRS{idProduct}=="0102", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0015", MODE="0666", TAG+="uaccess"

        KERNEL=="hidraw*", ATTRS{idVendor}=="3185", ATTRS{idProduct}=="0038", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="3162", ATTRS{idProduct}=="0053", MODE="0666", TAG+="uaccess"
        KERNEL=="hidraw*", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", MODE="0666", TAG+="uaccess"
      '';
    };

    # === DO NOT TOUCH ! ===
    system.stateVersion = "23.11";
  };
}
