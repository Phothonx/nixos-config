{inputs, self, ...}: {
  flake.nixosModules.camlannConfiguration = {pkgs, ...}: {
    imports = [
      self.nixosModules.camlannHardware

      inputs.impermanence.nixosModules.impermanence


      self.diskoConfigurations.camlann
      inputs.disko.nixosModules.disko

      self.nixosModules.nix
      self.nixosModules.power
    ];

    boot.initrd.systemd.enable = true;
    boot.initrd.systemd.services.rollback-root = {
      description = "Rollback ZFS root to blank snapshot";
      wantedBy = [ "initrd.target" ];
      after = [ "zfs-import-zroot.service" ];
      before = [ "sysroot.mount" ];

      unitConfig.DefaultDependencies = "no";

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = ''
        zfs rollback -r zroot/root@blank
      '';
    };

    environment.persistence."/persist" = {
      hideMounts = true;

      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
      ];

      files = [
        "/etc/machine-id"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
      ];
    };

    fileSystems."/persist".neededForBoot = true;

    documentation.man.cache.enable = true;
    documentation.dev.enable = true;

    environment.systemPackages = with pkgs; [
    ];

    boot = {
      tmp.cleanOnBoot = true;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };

    networking = {
      hostName = "camlann";
      hostId = "8c262600"; # do not change
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

    # === DO NOT TOUCH ! ===
    system.stateVersion = "25.11";
  };
}
