{ modules, pkgs, ... }:
{
  imports = [
    modules.nixos.default
    modules.nixos.vpn
  ];

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

  # shared wired connection
  networking.firewall.interfaces."enp3s0f0".allowedUDPPorts = [
    53
    67
  ];

  security.pam.services.swaylock = { };
}
