# Modules

NixOS configuration is declared in the [`nixos`](./nixos/README.md) directory.
Home-manager is configured in the [`home`](./home/README.md) directory.
For each of the two, the entire set can be importet through their respective `default.nix`.

All modules declared directly in this directory are _universal_, i.e., used by both the home-manager and NixOS modules.

## List of Universal Modules

- [`unfree`](./unfree.nix): Provides an easy interface to handle enabling unfree packages.

## Universal Declared Options

- `unfree.allowedPackages` (_list of string_):
  This option allows specific unfree programs to be allowed, since `nixpkgs.config.allowUnfree` is set to `false` by default.
  It works around the fact that `nixpkgs.config.allowUnfreePredicate` can only be declared in one place since it is a function, not a list of some sort.
