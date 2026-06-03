inputs @ { nixpkgs, self, ... }:
let
  setDefaultHostName = hostname: { lib, ... }: {
    networking.hostName = lib.mkDefault hostname;
  };
in
{ hostname, system }:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = { inherit inputs hostname; };
  modules = [
    inputs.self.nixosModules.default
    (setDefaultHostName hostname)
    (../hosts + "/${hostname}")
  ];
}
