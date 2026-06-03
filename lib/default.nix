inputs @ {
  nixpkgs,
  home-manager,
  ...
}:

{
  mkSystem = import ./mkSystem.nix inputs;
  mkUser = import ./mkUser.nix inputs;
}
