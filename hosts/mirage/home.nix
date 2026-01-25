{ config, modules, ... }:
{
  imports = [ modules.home.default ];

  home.stateVersion = "23.05"; # don't change this value

  # host specific config
  programs.wlogout.enable = true;
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,highres,0x0,1"
      ",highres,1920x0,1"
      #",preferred,auto,1,mirror,eDP-1"
    ];
    exec = [
      "pkill swaybg; swaybg -i ${config.xdg.userDirs.pictures}/wallpapers/mirage/wallpaper.png"
      "pkill eww; eww o bar"
    ];
  };
}
