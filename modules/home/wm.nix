{ config, ... }:
{
  # bars and launchers
  programs.fuzzel = {
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
