{ modules, pkgs, ... }:
{
  imports = [
    modules.nixos.default
    modules.nixos.vpn
  ];

  networking.hostName = "mirage";
  system.stateVersion = "23.05"; # don't change this value

  # other hardware config
  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "rtsx_pci_sdmmc"
    "xhci_pci"
  ];

  # host specific config
  environment.systemPackages = with pkgs; [ brightnessctl ];

  security.pam.services.swaylock = { };

  # https://www.reddit.com/r/linux/comments/1em8biv/psa_pipewire_has_been_halving_your_battery_life/
  services.pipewire.wireplumber.extraConfig."wireplumber.profiles".main."monitor.libcamera" = "disabled";
}
