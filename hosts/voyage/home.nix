{ modules, paths, ... }:
{
  imports = [
    modules.home.default
    modules.home.wlogout
  ];

  home.stateVersion = "24.11"; # don't change this value

  # host specific config
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,highres,0x0,1"
      ",highres,1920x0,1"
      #",preferred,auto,1,mirror,eDP-1"
    ];
    exec = [
      "pkill swaybg; swaybg -i ${paths.wallpapers}/refuge/nix-cat-crust.png"
      "pkill eww; eww o bar"
    ];
  };
}
