_: {
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
  hardware.nvidia.enable = true;
  networking.shared-ethernet = {
    enable = true;
    interfaces = [ "enp7s0" ];
  };

  programs.coolercontrol.enable = true;

  security.pam.services.swaylock = { };

  services.openssh.enable = true;
}
