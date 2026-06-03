inputs @ { nixpkgs, home-manager, self, ... }:
{ username, hostname, system }:
home-manager.lib.homeManagerConfiguration {
  pkgs = import nixpkgs {
    inherit system;

    config = {
      allowUnfree = true;
    };
  };

  extraSpecialArgs = {
    inherit inputs username hostname;
  };

  modules = [
    inputs.self.homeManagerModules.default
    (../users + "/${username}")
  ];
}
