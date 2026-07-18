# NixOS Configuration

Configures NixOS and declares [some options](#declared-options) hosts may want to set.

## List of Modules

- [`audio`](./audio.nix): Audio-related config.
- [`boot`](./boot.nix): Boot config.
- [`default`](./default.nix): Entrypoint for importing all modules and some miscellaneous config.
- [`fonts`](./fonts.nix): Font config.
- [`hardware-configuration`](./hardware-configuration.nix): Common options from the auto-generated hardware config.
  See [Partition Setup](#partition-setup) for the partition layout this module expects.
- [`locale`](./locale.nix): Locale-related config.
- [`networking`](./networking.nix): Config for networking and general communication with other devices, e.g., through adb.
- [`nix`](./nix.nix): Nix/Lix-related config.
- [`nvidia`](./nvidia.nix): A module that, if enabled, sets options for nvidia GPUs.
- [`programs`](./programs.nix): Miscellaneous programs.
- [`security`](./security.nix): Security, keyring, and login config.
- [`shared-ethernet`](./shared-ethernet.nix): Module for ethernet connection sharing.
- [`shells`](./shells.nix): Config for TTYs, shells, and CLI programs.
- [`users`](./users.nix): Configures users.
- [`vpn`](./vpn.nix): Module for a TUDa VPN network manager profile.
- [`wm`](./wm.nix): WM/Compositor-related config.

## Declared Options

See the option declarations for more information and the implementation.

- `boot.loader.grub.addWindowsEntry` (_boolean_):
  If enabled, adds a Grub entry to boot Windows from a partition with the label `WIN_BOOT`.
- `hardware.nvidia.enable` (_boolean_):
  Whether to set config options for nvidia support.
- `networking.shared-ethernet.enable` (_boolean_):
  Whether to enable shared ethernet profile generation.
  See [the module](./shared-ethernet.nix) for more details.
- `networking.shared-ethernet.interfaces` (_list of string_):
  Which interfaces to generate ethernet forwarding for.

## Partition Setup

Every partition is accessed through labels.
The following labels are referenced (in alphabetical order):
- `NIXOS-BOOT`: This is the FAT32 boot partition where Grub is installed.
- `nixos-root`: BTRFS root partition for NixOs.
- `nixos-swap`: A swap partition.
- `WIN_BOOT` (_optional_): Windows boot partition that is referenced iff `boot.loader.grub.addWindowsEntry` is enabled.
