{ modules, paths, ... }:
{
  imports = [
    modules.home.default
    modules.home.nvidia
    modules.home.obs
    modules.home.swaylock
  ];

  home.stateVersion = "23.05"; # don't change this value

  # host specific config
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-2,2560x1440@144,0x0,1"
      "DP-3,2560x1440@144,2560x0,1"
    ];
    exec = [
      "pkill swaybg; swaybg -o DP-3 -i ${paths.wallpapers}/refuge/nix-cat-crust.png -o DP-2 -i ${paths.wallpapers}/refuge/line-crust.png"
      "pkill eww; eww-helper launch-eww -p 0,2560"
    ];
  };
}
