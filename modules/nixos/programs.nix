{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    gimp
    (jetbrains.idea.override { jdk = jetbrains.jdk-21; })
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
