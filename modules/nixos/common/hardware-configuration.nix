{
  config,
  lib,
  modulesPath,
  ...
}:
{
  # contains all options the generated hardware configs set, except for `boot.initrd.availableKernelModules` which is set in the host's config.
  # the only adjusted options values are the partition uuids.
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.kernelModules = [ "kvm-amd" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos-root";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/NIXOS-BOOT";
      fsType = "vfat";
      options = [
        "dmask=0022"
        "fmask=0022"
      ];
    };
  };

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  swapDevices = [ { device = "/dev/disk/by-label/nixos-swap"; } ];
}
