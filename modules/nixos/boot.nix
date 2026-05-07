{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.boot.loader.grub;
in
{
  # looks for a 'WIN_BOOT' partition that may be fat-formatted and on a gpt disk and tries to boot windows from there
  options.boot.loader.grub.addWindowsEntry = lib.mkEnableOption "windows grub entry";

  config = {
    # always active
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

    # configurable using our declared options
    boot.loader.grub.extraEntries = lib.mkIf cfg.addWindowsEntry ''
      menuentry "Windows" --class os --class windows {
        insmod part_gpt
        insmod fat
        search --no-floppy --label --set root WIN-BOOT
        chainloader /efi/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
}
