{ inputs, pkgs, ... }:
{
  # wm stuff
  programs.hyprland.enable = false;
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    eww
    swaybg
    wl-clipboard
    xwayland-satellite

    inputs.scripts-flake.packages.${stdenv.hostPlatform.system}.eww-helper

    (writeShellScriptBin "screenshot" ''
      sleep $1; ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | magick - -shave 1x1 PNG:- | ${swappy}/bin/swappy -f -
    '')
  ];

  # pam needs to know about swaylock
  # make sure it does in case our compositor module doesn't take care of it
  security.pam.services.swaylock = { };

  # misc
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
}
