# Home Manager configuration file.
# Check https://github.com/nix-community/home-manager/ for more information.

{
  config,
  inputs,
  lib,
  pkgs,
  outputs,
  ...
}:
{
  imports = [
    outputs.homeManagerModules.bundle
    ./git.nix
  ];

  # NOTE: Setup home configuration.
  home.username = "caio";
  home.homeDirectory = "/home/caio";
  home.stateVersion = "25.11"; # NOT CHANGE THIS UNTIL READ REALEASE NOTES.
  xdg.enable = true;

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch"; # Nice reload on switch.
}
