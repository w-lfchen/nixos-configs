{ paths, pkgs, ... }:
{
  programs.swaylock = {
    enable = true;
    catppuccin.enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      # use this instead of `builtins.toString wallpapers + "/refuge/line-crust.png"` in order to not rebuild upon whitespace change
      image = "${paths.wallpapers}/refuge/line-crust.png";
      clock = true;
      daemonize = true;
      effect-blur = "3x5";
      effect-vignette = "0.5:0.5";
      fade-in = 0.1;
      font = "FiraCode Nerd Font Mono";
      font-size = 24;
      ignore-empty-password = true;
      indicator = true;
      indicator-idle-visible = false;
      indicator-radius = 100;
      indicator-thickness = 7;
    };
  };

  wayland.windowManager.hyprland.settings.bind = [ "$mainMod, X, exec, swaylock" ];
}
