{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    gimp
    jetbrains.idea-ultimate
    librewolf
    obsidian
    signal-desktop
    slack
    thunderbird-latest
    vesktop
    vlc
    xournalpp
    zotero
  ];

  unfree.allowedPackages = [
    "discord"
    "idea-ultimate"
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
