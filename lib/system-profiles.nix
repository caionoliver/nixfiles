{ inputs, self, ... }:

{
  mkNixosHost = { system, hostName, mainUser }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs self hostName mainUser; };

      modules = [
        {
          imports = [ self.metaModules.nixos ];

          networking.hostName = hostName;
          nixpkgs = {
            hostPlatform = system;
            overlays = builtins.attrValues self.overlays;
            config.allowUnfree = true;
          };
        }
        ../hosts/${hostName}
      ];
    };

  mkHomeConfig = { system, userName, homeDir ? "/home/${userName}" }:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs self userName homeDir; };

      modules = [
        {
          imports = [ self.metaModules.home ];

          nixpkgs = {
            overlays = builtins.attrValues self.overlays;
            config.allowUnfree = true;
          };
        }
        ../users/${userName}
      ];
    };
}
