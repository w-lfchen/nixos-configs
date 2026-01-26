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
    sources.grub = inputs.catppuccin.packages.${pkgs.stdenv.hostPlatform.system}.buildCatppuccinPort {
      port = "grub";
      src = inputs.catppuccin-grub;
      # source: https://github.com/catppuccin/nix/blob/deb2a5a54cf9e05ddf60aeeb933f60ad2fac20e1/pkgs/grub/package.nix
      dontCatppuccinInstall = true;
      postInstall = ''
        mkdir -p $out/share/grub
        mv src $out/share/grub/themes
      '';
    };
    grub.enable = true;
  };
}
