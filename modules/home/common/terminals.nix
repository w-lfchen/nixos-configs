_: {
  # shells and prompts
  catppuccin = {
    fish.enable = true;
    starship.enable = true;
  };
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
    starship = {
      enable = true;
      settings.add_newline = false;
    };
  };

  # terminal emulators
  catppuccin.kitty.enable = true;
  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Reg";
    settings.background_opacity = "0.4";
  };

  # terminal programs
  catppuccin = {
    bat.enable = true;
    btop.enable = true;
    fzf.enable = true;
    yazi.enable = true;
    zellij.enable = true;
  };
  programs = {
    bat.enable = true;
    btop = {
      enable = true;
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
    fzf.enable = true;
    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    zellij = {
      enable = true;
      settings = {
        copy_on_select = false;
        ui.pane_frames.rounded_corners = true;
      };
    };
    zoxide.enable = true;
  };
}
