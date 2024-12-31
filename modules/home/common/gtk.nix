{ pkgs, ... }:
{
  catppuccin.gtk = {
    enable = true;
    size = "compact";
    tweaks = [ "rimless" ];
  };

  gtk = {
    enable = true;
    font = {
      name = "Roboto Condensed";
      size = 10;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };
  };

  # enable dark mode in electron apps (and possibly other places too)
  # https://github.com/NixOS/nixpkgs/issues/274554#issuecomment-2211307799
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # cursors
  catppuccin.cursors.enable = false;
  home.pointerCursor = {
    gtk.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
  };
  gtk.cursorTheme = {
    name = "capitaine-cursors";
    size = 16;
  };

  # qt
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
