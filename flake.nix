{
  description = "My NixOS flake-powered config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    lib = import ./lib { inherit inputs self; };
  in {
    overlays = import ./overlays { inherit inputs; };

    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home;

    metaModules = import ./modules/.meta;

    nixosConfigurations = {
      laptop = lib.mkNixosHost {
        system = "x86_64-linux";
        hostName = "X270";
        mainUser = "caio";
      };
    };
    homeConfigurations = {
      "caio@X270" = lib.mkHomeConfig {
        system = "x86_64-linux";
        userName = "caio";
      };
    };
  };
}
