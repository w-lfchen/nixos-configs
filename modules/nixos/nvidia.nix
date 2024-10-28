# nixos module for nvidia on wayland
{ config, pkgs, ... }:
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

  nixpkgs.overlays = [
    (final: prev: {
      obsidian = prev.obsidian.override { commandLineArgs = "--disable-gpu-compositing"; };
      # just don't start vesktop from a terminal, very fragile but works
      # TODO: improve vesktop override
      vesktop = prev.vesktop.overrideAttrs {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "vesktop";
            desktopName = "Vesktop";
            exec = "vesktop --disable-gpu-compositing %U";
            icon = "vesktop";
            startupWMClass = "Vesktop";
            genericName = "Internet Messenger";
            keywords = [
              "discord"
              "vencord"
              "electron"
              "chat"
            ];
            categories = [
              "Network"
              "InstantMessaging"
              "Chat"
            ];
          })
        ];
      };
    })
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
}
