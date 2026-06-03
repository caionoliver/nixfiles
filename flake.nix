{
  description = "My NixOS flake-powered config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-discord-krisp = {
      url = "github:FlameFlag/nixpkgs/flameflag/push-vmswpuqmvzpt";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = import ./lib inputs;
  in {
    overlays = import ./overlays { inherit inputs; };
    nixosModules.default = import ./modules/nixos;
    homeManagerModules.default = import ./modules/home;

    nixosConfigurations = {
      X270 = lib.mkSystem {
        hostname = "X270";
        system = "x86_64-linux";
      };
    };

    homeConfigurations = {
      "caio@X270" = lib.mkUser {
        username = "caio";
        hostname = "X270";
        system = "x86_64-linux";
      };
    };
  };
}

