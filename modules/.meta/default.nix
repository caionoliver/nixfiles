# This file load meta-modules
# Meta-modules load all modules from modules/{home,nixos}/default.nix
{
  nixos = import ./nm-modules.nix;
  home = import ./hm-modules.nix;
}
