# Modules

[`nixos`](./nixos/README.md) contains NixOS configurations, [`home`](./home/README.md) contains home-manager configs.
All modules declared directly in this directory are used by both the home-manager and NixOS modules.

## List of Universal Modules

- [`unfree`](./unfree.nix): This module declares one option: `unfree.allowedPackages`.
  This option is used in both NixOS and home-manager configs to allow specific unfree programs to be installed, since `nixpkgs.config.allowUnfree` is set to `false`.
