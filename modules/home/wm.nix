{ config, lib, ... }:
{
  # bars and launchers
  catppuccin.tofi.enable = true;
  programs = {
    fuzzel = {
      enable = true;
      settings = {
        border = {
          radius = 0;
          width = 2;
          selection-radius = 0;
        };
        # can't use catppuccin.fuzzel since we want to adjust some colors
        colors = {
          background = "1e1e2eff";
          text = "cdd6f4ff";
          prompt = "bac2deff";
          placeholder = "7f849cff";
          input = "cdd6f4ff";
          match = "cba6f7ff";
          selection = "585b70ff";
          selection-text = "cdd6f4ff";
          selection-match = "cba6f7ff";
          counter = "7f849cff";
          border = "cba6f7ff";
        };
        main = {
          dpi-aware = false;
          font = "FiraCode Nerd Font Propo:size=14";
          icons-enabled = false;
          lines = 5;
          width = 40;
        };
      };
    };
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
    # not really happy with this but it's enough for now.
    # maybe use rofi or eww instead
    wlogout = {
      layout = [
        {
          action = "systemctl poweroff";
          keybind = "h";
          label = "shutdown";
          text = "";
        }
        {
          action = "systemctl reboot";
          keybind = "r";
          label = "reboot";
          text = "";
        }
        {
          action = "systemctl suspend";
          keybind = "u";
          label = "suspend";
          text = "";
        }
      ];
      style = ''
        * {
          background-image: none;
          box-shadow: none;
          font-size: 100px;
          font-family: FiraCode Nerd Font Propo;
        }

        window {
          background-color: rgba(17, 17, 27, 0.8);
        }

        button {
          background-color: #313244;
          margin: 50px;
          margin-left: 600px;
          margin-right: 600px;
          text-decoration-color: #cdd6f4;
          color: #cdd6f4;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        button:focus, button:active {
          background-color: #45475a;
        }
      '';
    };
  };
  # https://github.com/philj56/tofi/issues/115#issuecomment-1950273960
  home.activation.regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tofi_cache=${config.xdg.cacheHome}/tofi-drun
    [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
  '';
  # link eww configs into config dir
  # requires the config repo to be located at ~/nixos-configs
  xdg.configFile."eww".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-configs/config/eww";

  # niri
  # this symlinks the config shared across hosts, each host ist expected to supply their own config.kdl
  # the config.kdl may reference this file as "default.nix"
  xdg.configFile."niri/default.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-configs/config/niri/default.kdl";
}
