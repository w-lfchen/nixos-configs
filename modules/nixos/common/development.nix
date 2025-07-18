{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sshuttle stm32cubemx ];
  unfree.allowedPackages = [ "stm32cubemx" ];
  services.postgresql = {
    enable = true;
  };
  virtualisation.docker.enable = true;
}
