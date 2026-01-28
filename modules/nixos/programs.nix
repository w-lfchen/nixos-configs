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
    zotero
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
