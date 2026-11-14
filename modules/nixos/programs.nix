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

  unfree.allowedPackages = [
    "discord"
    "discord-unwrapped"
    "intellij-idea"
    "obsidian"
    "slack"
    # remove once zotero no longer relies on firefox 140
    "firefox-esr-140-bin-unwrapped"
  ];

  # remove once zotero no longer relies on firefox 140
  nixpkgs.config.permittedInsecurePackages = [
    "firefox-esr-140-bin-unwrapped-140.17.0esr"
  ];

  programs = {
    ausweisapp = {
      enable = true;
      openFirewall = true;
    };
    java = {
      enable = true;
      package = pkgs.jdk21;
    };
  };
}
