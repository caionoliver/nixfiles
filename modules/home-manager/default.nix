# For home-manager modules.
{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./cli/git.nix
    ./apps.nix
  ];
}
