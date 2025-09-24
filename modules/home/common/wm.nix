{ config, lib, ... }:
{
  # bars and launchers
  catppuccin.tofi.enable = true;
  programs = {
    # not managing eww through home-manager
    # instead created a symlink in .config and added it to systemPackages
    # that allows reload on save, maybe change this once eww config is done
    # eww = {
    #   enable = true;
    #   package = pkgs.eww-wayland;
    #   configDir = ~/nixos-configs/eww;
    # };
    tofi = {
      enable = true;
      settings = {
        # dimensions
        height = 240;
        width = 480;
        padding-top = 20;
        padding-bottom = 20;
        padding-left = 20;
        padding-right = 20;
        num-results = 5;
        result-spacing = 10;
        # border/outline
        border-color = "#cba6f7";
        border-width = 2;
        corner-radius = 10;
        outline-width = 0;
        # font
        font = "FiraCode Nerd Font Propo";
        font-size = 14;
        # misc
        terminal = "kitty";
        text-cursor = true;
        fuzzy-match = true;
        drun-launch = true;
      };
    };
  };
  # https://github.com/philj56/tofi/issues/115#issuecomment-1950273960
  home.activation.regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tofi_cache=${config.xdg.cacheHome}/tofi-drun
    [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
  '';

  # hyprland
  catppuccin.hyprland.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      bind =
        [
          "$mainMod, return, exec, kitty"
          "$mainMod, C, killactive, "
          "$mainMod, M, exit, "
          "$mainMod, E, exec, dolphin"
          "$mainMod, V, togglefloating, "
          "$mainMod, R, exec, tofi-drun"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, J, togglesplit, # dwindle"
          "$mainMod, F, fullscreen, 0"
          "$mainMod SHIFT, Q, exec, wlogout --buttons-per-row 1"

          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          "$mainMod CTRL, left, movecurrentworkspacetomonitor, l"
          "$mainMod CTRL, right, movecurrentworkspacetomonitor, r"
        ]
        ++
        # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        (builtins.concatLists (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
              "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10
        ));
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
        "$mainMod SHIFT, mouse:272, resizewindow"
      ];
      bindl = [
        ",XF86MonBrightnessUp, exec, lightctl -d up"
        ",XF86MonBrightnessDown, exec, lightctl -d down"
        ",XF86AudioRaiseVolume, exec, volumectl -d up"
        ",XF86AudioLowerVolume, exec, volumectl -d down"
        ",XF86AudioMute, exec, volumectl -d toggle-mute"
        ",XF86AudioMicMute, exec, volumectl -d -m toggle-mute" # https://github.com/heyjuvi/avizo/issues/67
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPause, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"
      ];

      decoration = {
        blur = {
          enabled = true;
          brightness = 1;
          contrast = 1;
          new_optimizations = true;
          passes = 4;
          size = 6;
        };

        rounding = 10;

        shadow = {
          enabled = true;
          color = "rgba(1a1a1aee)";
          range = 4;
          render_power = 3;
        };
      };
      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };
      ecosystem = {
        no_donation_nag = true;
        no_update_news = true;
      };
      env = [ "XCURSOR_SIZE,24" ];
      exec = [ "playerctld daemon" ];
      general = {
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(00000000)";
        gaps_in = 5;
        gaps_out = 10;
        layout = "dwindle";
        resize_on_border = true;
      };
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
      };
      layerrule = [
        #"blur, gtk-layer-shell"
        "blur, logout_dialog"
      ];
      misc = {
        background_color = "rgb(000000)";
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        enable_anr_dialog = false;
      };
      # fixes
      windowrulev2 = [
        # don't know whether this is still needed, haven't used intellij in forever luckily
        # https://github.com/hyprwm/Hyprland/issues/3450#issuecomment-1816761575
        # -- Fix odd behaviors in IntelliJ IDEs --
        #! Fix splash screen showing in weird places and prevent annoying focus takeovers
        "center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1"
        #! Center popups/find windows
        "center,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        "noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1"
        #! Disable window flicker when autocomplete or tooltips appear
        "nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1"
        "noinitialfocus,class:^(jetbrains-.*),title:^(win.*)"
      ];
    };
  };
}
