{ lib, ... }:
{
  # librewolf/firefox thing
  home.activation = {
    # TODO: is there a better way to do this?
    # this creates ~/.librewolf/native-messaging-hosts/, keepassxc's browser extension needs it
    librewolf-dir-creation = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p ~/.librewolf/native-messaging-hosts/
    '';
  };

  programs = {
    imv = {
      enable = true;
      catppuccin.enable = true;
    };
    thunderbird = {
      enable = true;
      profiles."default".isDefault = true;
    };
    zathura = {
      enable = true;
      catppuccin.enable = true;
      options = {
        font = "FiraCode Nerd Font normal 10";
        selection-clipboard = "clipboard";
        statusbar-basename = true;
        statusbar-page-percent = true;
      };
    };
  };
}
