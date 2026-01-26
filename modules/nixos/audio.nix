{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    playerctl
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    audio.enable = true;
    pulse.enable = true;
  };
}
