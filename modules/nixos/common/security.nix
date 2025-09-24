{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnupg1
    keepassxc
    pinentry
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gtk2;
    };
    seahorse.enable = true;
  };

  security = {
    pam.services.greetd = {
      enableGnomeKeyring = true;
      gnupg.enable = true;
    };
    polkit.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = lib.concatStringsSep " " [
            (lib.getExe pkgs.tuigreet)
            "--asterisks"
            "--greeting 'Access is restricted to authorised personnel only.'"
            "--remember"
            "--remember-user-session"
            "--time"
            "--cmd Hyprland"
          ];
          user = "greeter";
        };
      };
    };
  };

  systemd = {
    services = {
      greetd.serviceConfig = {
        Type = "idle";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        TTYReset = true;
        TTYVHangup = true;
        TTYVTDisallocate = true;
      };
    };
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
