# ❄️ nixfiles

My NixOS flake-powered configuration files.

## Overview

This repository contains my personal NixOS system configuration, managed with [Nix Flakes](https://nixos.wiki/wiki/Flakes). It uses [Home Manager](https://github.com/nix-community/home-manager) for user-level dotfiles and [nixos-hardware](https://github.com/NixOS/nixos-hardware) for hardware-specific optimizations.

## Structure

```
nixfiles/
├── hosts/
│   └── X270/          # Lenovo ThinkPad X270 host configuration
├── modules/
│   ├── nixos/         # Reusable NixOS modules
│   └── home-manager/  # Reusable Home Manager modules
├── overlays/          # Custom nixpkgs overlays
├── users/
│   └── caio/          # User-level configuration (Home Manager)
├── flake.nix          # Flake entry point (inputs & outputs)
└── flake.lock         # Pinned dependency versions
```

## Flake Inputs

| Input | Version |
|---|---|
| [nixpkgs](https://github.com/NixOS/nixpkgs) | `nixos-26.05` |
| [home-manager](https://github.com/nix-community/home-manager) | `release-26.05` |
| [nixos-hardware](https://github.com/NixOS/nixos-hardware) | `master` |

## Hosts

| Hostname | Machine | System |
|---|---|---|
| `X270` | Lenovo ThinkPad X270 | `x86_64-linux` |

## Usage

> Make sure you have [Nix](https://nixos.org/download/) installed with flakes enabled.

### Rebuild the system

```bash
sudo nixos-rebuild switch --flake .#X270
```

### Update all inputs

```bash
nix flake update
```

### Check the flake

```bash
nix flake check
```

## Enabling Flakes

If you haven't enabled flakes yet, add the following to your `/etc/nixos/configuration.nix`:

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

## License

Under [MIT](./LICENSE) License.
