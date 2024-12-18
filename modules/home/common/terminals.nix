_: {
  # shells and prompts
  programs = {
    fish = {
      enable = true;
      catppuccin.enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
    starship = {
      enable = true;
      catppuccin.enable = true;
      settings.add_newline = false;
    };
  };

  # terminal emulators
  programs.kitty = {
    enable = true;
    catppuccin.enable = true;
    font.name = "FiraCode Nerd Font Reg";
    settings.background_opacity = "0.4";
  };

  # terminal programs
  programs = {
    bat = {
      enable = true;
      catppuccin.enable = true;
    };
    btop = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        theme_background = true;
        update_ms = 1000;
      };
    };
    dircolors.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fd.enable = true;
    fzf = {
      enable = true;
      catppuccin.enable = true;
    };
    yazi = {
      enable = true;
      catppuccin.enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    zoxide.enable = true;
  };
}
