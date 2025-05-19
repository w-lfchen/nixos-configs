{ pkgs, ... }:
{
  catppuccin.mako.enable = true;
  services = {
    # not really happy with this but it's enough for now, maybe use eww instead
    avizo = {
      enable = true;
      package = pkgs.avizo.overrideAttrs (
        final: prev: {
          src = pkgs.fetchFromGitHub {
            owner = "heyjuvi";
            repo = "avizo";
            rev = "5efaa22968b2cc1a3c15a304cac3f22ec2727b17";
            sha256 = "sha256-KYQPHVxjvqKt4d7BabplnrXP30FuBQ6jQ1NxzR5U7qI=";
          };
        }
      );
      settings.default = {
        background = "rgba(30, 30, 46, 1)";
        bar-bg-color = "rgba(108, 112, 134, 1)";
        bar-fg-color = "rgba(205, 214, 244, 1)";
        border-color = "rgba(203, 166, 247, 1)";
        border-radius = 10;
        border-width = 2;
        time = 0.5;
        fade-out = 0.5;
      };
    };
    gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };
    mako = {
      enable = true;
      settings = {
        border-radius = 6;
        border-size = 3;
        default-timeout = 5000;
      };
    };
  };
}
