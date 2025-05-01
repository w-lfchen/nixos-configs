{ inputs, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./editors.nix
    ./gtk.nix
    ./programs.nix
    ./services.nix
    ./spotify.nix
    ./swaylock.nix
    ./terminals.nix
    ./wm.nix
  ];

  # user settings
  home = {
    homeDirectory = "/home/wolf";
    username = "wolf";
  };

  # basic styling
  catppuccin = {
    flavor = "mocha";
    accent = "mauve";
  };

  # misc
  programs.home-manager.enable = true;
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
