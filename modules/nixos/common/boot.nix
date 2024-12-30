{
  lib,
  paths,
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
        theme = lib.mkForce (
          pkgs.catppuccin-grub.overrideAttrs { patches = [ "${paths.patches}/grub-theme.patch" ]; }
        );
        useOSProber = false;
      };
    };
  };

  catppuccin.grub.enable = true;
}
