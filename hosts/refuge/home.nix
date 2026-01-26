{ config, modules, ... }:
{
  imports = [ modules.home.default ];

  home.stateVersion = "23.05"; # don't change this value

  # host specific config
  hardware.nvidia.enable = true;
  programs.obs-studio.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2,2560x1440@144,0x0,1"
      "DP-3,2560x1440@144,2560x0,1"
    ];
    exec = [
      "pkill swaybg; swaybg -o DP-3 -i ${config.xdg.userDirs.pictures}/wallpapers/refuge/nix-cat-crust.png -o DP-2 -i ${config.xdg.userDirs.pictures}/wallpapers/refuge/line-crust.png"
      "pkill eww; eww open-many left-bar right-bar"
    ];
  };
}
