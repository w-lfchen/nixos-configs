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
  ];

  programs = {
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
  };
}
