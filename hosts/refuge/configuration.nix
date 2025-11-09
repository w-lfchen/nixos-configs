{ modules, ... }:
{
  imports = [
    modules.nixos.default
    modules.nixos.nvidia
    modules.nixos.shared-ethernet
  ];

  networking.hostName = "refuge";
  system.stateVersion = "23.05"; # don't change this value

  # hardware config
  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usbhid"
    "xhci_pci"
  ];

  # other host specific config
  networking.shared-ethernet = {
    enable = true;
    interfaces = [ "enp7s0" ];
  };

  programs.coolercontrol.enable = true;

  security.pam.services.swaylock = { };

  services.openssh.enable = true;
}
