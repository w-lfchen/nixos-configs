{ modules, pkgs, ... }:
{
  imports = [
    modules.nixos.default
    modules.nixos.nvidia
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
  environment.systemPackages = with pkgs; [ davinci-resolve ];
  unfree.allowedPackages = [ "davinci-resolve" ];

  programs.coolercontrol = {
    enable = true;
    nvidiaSupport = true;
  };

  security.pam.services.swaylock = { };

  services.openssh.enable = true;
}
