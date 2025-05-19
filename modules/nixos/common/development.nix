{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sshuttle ];
  services.postgresql = {
    enable = true;
  };
  virtualisation.docker.enable = true;
}
