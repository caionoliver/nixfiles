# My Nix(OS) Configuration files [W.I.P.]

All my ".nix" files, system configuration, home-manager and overlays are here. That configs aren't (yet) powered by flakes, still is only experimental configuration while i'm learning about Nix/NixOS. I recommend (if some crazy guy want to use that configs) to organize by default:

- System-level - **system/**
``/etc/nixos/configuration.nix``

- User-level (home-manager) - **home/**
``$HOME/.config/nixpkgs/home.nix``

Home-manager files are on **home/**, and the ``default.nix`` should be renamed as ``home.nix`` to works properly.

That's why the repository is on **work in progress**.
