{ pkgs, scripts, ... }:
{
  # wm stuff
  programs.hyprland.enable = true;

  environment.systemPackages = with pkgs; [
    eww
    swaybg
    wl-clipboard

    scripts.eww-helper

    (writeShellScriptBin "screenshot" ''
      sleep $1; ${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | magick - -shave 1x1 PNG:- | ${swappy}/bin/swappy -f -
    '')
  ];

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
