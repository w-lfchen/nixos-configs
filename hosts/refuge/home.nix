{ config, ... }:
{
  home.stateVersion = "23.05"; # don't change this value

  # host specific config
  programs.obs-studio.enable = true;

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-configs/config/niri/refuge.kdl";
}
