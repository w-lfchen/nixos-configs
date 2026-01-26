{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
    ./audio.nix
    ./boot.nix
    ./development.nix
    ./fonts.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./nvidia.nix
    ./programs.nix
    ./security.nix
    ./shared-ethernet.nix
    ./shells.nix
    ./users.nix
    ./vpn.nix
    ./wm.nix
  ];

  # basic styling
  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  # misc sys stuff
  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };
  services.fwupd.enable = true;
  programs.ccache.enable = true;
}
