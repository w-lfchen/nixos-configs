{ pkgs, ... }:
{
  environment.systemPackges = with pkgs; [ sshuttle ];
  services.postgresql = {
    enable = true;
  };
  virtualisation.docker.enable = true;
}
