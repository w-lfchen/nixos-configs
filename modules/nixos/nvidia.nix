# nixos module for nvidia on wayland
{ config, ... }:
{
  environment.sessionVariables = {
    "NIXOS_OZONE_WL" = "1";
  };

  unfree.allowedPackages = [
    "nvidia-settings"
    "nvidia-x11"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}
