# My NixOS configs

> [!CAUTION]
> These are my personal configurations which I actively use and modify. Therefore, **there may be breaking changes at any point in time without prior notice**.
> I make no guarantees about the state of anything in this repo.

## Repository Structure

- [`config`](./config/) is for config files not written in Nix.
  Its contents are symlinked into the correct places through home-manager.
- [`hosts`](./hosts/README.md) declares the systems configured using this flake.
- [`modules`](./modules/) contains both NixOS and home-manager modules.
  Some modules define their own options, see the respective documentation.
