# nixos module for nvidia on wayland
{ config, lib, ... }:
let
  cfg = config.hardware.nvidia;
in
{
  # hardware.nvidia.enabled is read-only, add a settable option for it
  options.hardware.nvidia.enable = lib.mkEnableOption "nvidia";

  config = lib.mkIf cfg.enable {
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
  };
}
