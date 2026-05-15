{ config, ... }:
{
  home.stateVersion = "24.11"; # don't change this value

  # host specific config
  programs.wlogout.enable = true;

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-configs/config/niri/voyage.kdl";
}
