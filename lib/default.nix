{ inputs, self, ... }:
let
  args = { inherit inputs self; };

  system = import ./system-profiles.nix args;
in
  system
# // new lib here
