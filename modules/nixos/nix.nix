{ inputs, pkgs, ... }:
{
  imports = [
    inputs.lix-module.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    nil
    nixfmt
    nix-output-monitor
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "wolf"
    ];
  };

  nixpkgs = {
    config.allowUnfree = false;
    overlays = [ inputs.eww.overlays.default ];
  };

  programs.nh.enable = true;
}
