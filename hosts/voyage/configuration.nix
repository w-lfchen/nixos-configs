{ pkgs, ... }:
{
  networking.hostName = "voyage";
  system.stateVersion = "24.11"; # don't change this value

  # other hardware config
  boot.initrd.availableKernelModules = [
    "nvme"
    "sdhci_pci"
    "xhci_pci"
  ];

  # host specific config

  environment.systemPackages = with pkgs; [ brightnessctl ];

  networking.shared-ethernet = {
    enable = true;
    interfaces = [ "enp3s0f0" ];
  };

  security.pam.services.swaylock = { };
}
