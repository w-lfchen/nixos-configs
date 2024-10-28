{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gnupg1
    # TODO: are the greetd packages needed?
    greetd.greetd
    greetd.tuigreet
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
          command = ''
            ${pkgs.greetd.tuigreet}/bin/tuigreet \
            -t \
            --asterisks \
            -g "Access is restricted to authorised personnel only." \
            --cmd Hyprland
          '';
          user = "wolf";
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
