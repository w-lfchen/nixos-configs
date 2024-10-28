{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.fish;
    users.wolf = {
      isNormalUser = true;
      description = "Wölfchen";
      extraGroups = [
        "networkmanager"
        "wheel"
        "adbusers"
      ];
      packages = [ ];
    };
  };
}
