# Host Declarations

## Structure

Each host declares a `configuration.nix` for system configuration and a `home.nix` for home-manager.
This is the place where differences between systems are configured:
Apart from the options they declare here, all hosts are identical.

## List of Hosts

- [`refuge`](./refuge/): A desktop PC with an AMD CPU and Nvidia RTX 30-series GPU serving two monitors.
- [`voyage`](./voyage/): A laptop with an AMD CPU with integrated graphics.
  It has no dedicated GPU.
