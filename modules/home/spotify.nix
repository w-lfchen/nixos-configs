{ inputs, pkgs, ... }:
{
  # spicetify
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  unfree.allowedPackages = [ "spotify" ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
}
