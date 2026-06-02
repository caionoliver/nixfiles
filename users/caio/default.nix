# Home Manager configuration file.
# Check https://github.com/nix-community/home-manager/ for more information.

{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.self.homeManagerModules.default
    ./git.nix
  ];
  home.allModules.enable = true;

  # NOTE: Setup home configuration.
  home.username = "caio";
  home.homeDirectory = "/home/caio";
  home.stateVersion = "26.05"; # NOT CHANGE THIS UNTIL READ REALEASE NOTES.
  fonts.fontconfig.enable = true;
  xdg.enable = true;

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch"; # Nice reload on switch.
}
