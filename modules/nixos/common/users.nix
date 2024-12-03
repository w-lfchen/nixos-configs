{ pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.powershell;
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
