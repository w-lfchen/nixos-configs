{ paths, ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general.grace = 1;
      background = [
        {
          monitor = "";
          blur_passes = 0;
          # https://github.com/nix-community/home-manager/issues/5743
          path = "${paths.wallpapers}/mirage/wallpaper.png";
        }
      ];
      input-field = [
        {
          dots_center = true;
          fade_on_empty = false;
          fail_text = "<span font_family=\"FiraCode Nerd Font Propo\">$ATTEMPTS failed attempt(s)</span>";
          outline_thickness = 2;
          placeholder_text = "<span font_family=\"FiraCode Nerd Font Propo\" foreground=\"##cdd6f4\">password required</span>";
          position = "0, -250";
          size = "200, 40";

          check_color = "rgb(137, 180, 250)";
          fail_color = "rgb(243, 139, 168)";
          font_color = "rgb(205, 214, 244)";
          inner_color = "rgb(49, 50, 68)";
          outer_color = "rgb(203, 166, 247)";
        }
      ];
      label = [
        {
          monitor = "";
          color = "rgb(205, 214, 244)";
          font_family = "FiraCode Nerd Font Propo";
          font_size = 30;
          position = "0, -200";
          text = "cmd[update:1000] echo \"<span foreground='##cdd6f4'>$(date +%T)</span>\"";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.hyprland.settings.bind = [ "$mainMod, X, exec, hyprlock" ];
}
