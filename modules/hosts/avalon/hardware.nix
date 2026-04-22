{
  flake.nixosModules.avalonHardware = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "sdhci_pci"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    # fileSystems."/" = {
    #   device = "/dev/disk/by-uuid/81aceda9-f20b-485b-a68e-57238c032f17";
    #   fsType = "ext4";
    # };
    #
    # fileSystems."/boot" = {
    #   device = "/dev/disk/by-uuid/3B74-8D38";
    #   fsType = "vfat";
    #   options = ["fmask=0022" "dmask=0022"];
    # };
    #
    # swapDevices = [
    #   {device = "/dev/disk/by-uuid/580e2c89-2576-4a31-b283-d136456d899c";}
    # ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
