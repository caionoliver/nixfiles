{ inputs, self, ... }:

{
  mkNixosHost = { system, hostName, mainUser }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs self hostName mainUser; };

      modules = [
        self.nixosModules.default
        ../hosts/${hostName}
        {
          nixpkgs.hostPlatform = system;
          nixpkgs.overlays = builtins.attrValues self.overlays;
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };

  mkHomeConfig = { system, userName, homeDir ? "/home/${userName}" }:
    let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = builtins.attrValues self.overlays;
      };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs self userName homeDir; };

      modules = [
        { nixpkgs.config.allowUnfree = true; }
        self.homeManagerModules.default
        ../users/${userName}
      ];
    };
}
