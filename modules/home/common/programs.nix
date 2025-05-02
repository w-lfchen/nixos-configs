{ lib, ... }:
{
  # librewolf/firefox thing
  home.activation = {
    # TODO: is there a better way to do this?
    # this creates ~/.librewolf/native-messaging-hosts/, keepassxc's browser extension needs it
    createLibrewolfDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p ~/.librewolf/native-messaging-hosts/
    '';
  };

  catppuccin = {
    imv.enable = true;
    zathura.enable = true;
  };
  programs = {
    imv.enable = true;
    # https://github.com/nix-community/home-manager/issues/6800
    # thunderbird = {
    #   enable = true;
    #   package = pkgs.thunderbird-latest;
    #   profiles."default".isDefault = true;
    # };
    zathura = {
      enable = true;
      options = {
        font = "FiraCode Nerd Font normal 10";
        selection-clipboard = "clipboard";
        statusbar-basename = true;
        statusbar-page-percent = true;
      };
    };
  };
}
