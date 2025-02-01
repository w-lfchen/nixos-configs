{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    users.wolf = {
      isNormalUser = true;
      description = "Wölfchen";
      extraGroups = [
        "adbusers"
        "docker"
        "networkmanager"
        "wheel"
      ];
      packages = [ ];
    };
  };
}
