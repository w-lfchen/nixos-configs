{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    initrd.systemd.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        backgroundColor = "#1E1E2E";
        device = "nodev";
        efiSupport = true;
        splashImage = lib.mkForce null;
        useOSProber = false;
      };
    };
  };

  catppuccin = {
    sources = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.overrideScope (
      final: prev: {
        grub = prev.grub.overrideAttrs {
          src = inputs.catppuccin-grub;
        };
      }
    );
    grub.enable = true;
  };
}
