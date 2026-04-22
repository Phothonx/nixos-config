{
  inputs,
  ...
}: {
  # nuke my root :)
  flake.nixosModules.impermanence = {pkgs, ...}: {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];

    environment.persistence."/persist" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/var/lib/NetworkManager"
      ];
      files = [
        "/etc/machine-id"
      ];
    };

  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.packages = with pkgs; [
    btrfs-progs
    coreutils
    findutils
    gnused
  ];
  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback Btrfs root subvolume";
    wantedBy = [ "initrd.target" ];
    after = [ "systemd-cryptsetup@cryptroot.service" ];
    before = [ "sysroot.mount" ];
    unitConfig.DefaultDependencies = "no";

    serviceConfig.Type = "oneshot";

    script = ''
      mkdir -p /btrfs_tmp
      mount -o subvolid=5 /dev/mapper/cryptroot /btrfs_tmp

      if [ -e /btrfs_tmp/root ]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
      }

      if [ -d /btrfs_tmp/old_roots ]; then
        for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
          delete_subvolume_recursively "$i"
        done
      fi

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };

  fileSystems."/persist".neededForBoot = true;
  fileSystems."/home".neededForBoot = true;

  };
}
