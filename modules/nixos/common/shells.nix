{ pkgs, ... }:
{
  console = {
    catppuccin.enable = true;
    keyMap = "de";
  };

  environment = {
    shells = with pkgs; [ powershell ];
    systemPackages = with pkgs; [
      fish
      kitty
      ripgrep
      ripgrep-all
      unzip
      xdg-utils
      zip
    ];
  };

  programs = {
    fish.enable = true;
    git.enable = true;
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
    extraConfig = ''
      font-size=14
      palette=custom
      palette-black=17,17,27
      palette-red=243,139,168
      palette-green=166,227,161
      palette-yellow=249,226,175
      palette-blue=137,180,250
      palette-magenta=245,194,231
      palette-cyan=148,226,213
      palette-light-grey=186,194,222
      palette-dark-grey=88,91,112
      palette-light-red=243,139,168
      palette-light-green=166,227,161
      palette-light-yellow=249,226,175
      palette-light-blue=137,180,250
      palette-light-magenta=245,194,231
      palette-light-cyan=148,226,213
      palette-white=205,214,244
      palette-foreground=205,214,244
      palette-background=30,30,46
    '';
  };
}
