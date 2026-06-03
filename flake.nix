{
  description = "My NixOS flake-powered config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {

    overlays = import ./overlays { inherit inputs; };
    nixosModules.default = import ./modules/nixos;
    homeManagerModules.default = import ./modules/home;

    nixosConfigurations = {
      X270 = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/X270/default.nix
        ];
      };
    };
    homeConfigurations = {
      "caio@X270" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./users/caio/default.nix
        ];
      };
    };
  };
}

