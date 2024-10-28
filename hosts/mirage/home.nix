{ modules, paths, ... }:
{
  imports = [
    modules.home.default
    modules.home.hyprlock
    modules.home.wlogout
  ];

  home.stateVersion = "23.05"; # don't change this value

  # host specific config
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,highres,0x0,1"
      ",highres,1920x0,1"
      #",preferred,auto,1,mirror,eDP-1"
    ];
    exec = [
      "pkill swaybg; swaybg -i ${paths.wallpapers}/mirage/wallpaper.png"
      "pkill eww; eww-helper launch-eww"
    ];
  };
}
