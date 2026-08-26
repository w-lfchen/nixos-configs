{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    gimp
    jetbrains.idea
    librewolf
    obsidian
    signal-desktop
    slack
    thunderbird-latest
    vesktop
    xournalpp
    zed-editor
    zotero
  ];

  nixpkgs.overlays = [
    (final: prev: {
      jetbrains = prev.jetbrains // {
        jdk = final.jetbrains.jdk-no-jcef-21;
      };
    })
  ];

  unfree.allowedPackages = [
    "discord"
    "idea"
    "obsidian"
    "slack"
  ];

  programs = {
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
  };
}
