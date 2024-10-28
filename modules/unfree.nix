# a module to handle the `nixpkgs.config.allowUnfreePredicate` closure by collecting the elements to pass it
# can be used by both home-manager and nixos configurations
{ config, lib, ... }:
let
  cfg = config.unfree.allowedPackages;
in
{
  options.unfree.allowedPackages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = ''
      List of unfree package names (according to `lib.getName`) to allow.
    '';
    example = [
      "discord"
      "spotify"
    ];
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) cfg;
  };
}
