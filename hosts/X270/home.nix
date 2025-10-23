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
    ../../modules/home-manager/default.nix
  ];

  # NOTE: Setup home configuration.
  home.username = "caio";
  home.homeDirectory = "/home/caio";
  home.stateVersion = "25.05"; # NOT CHANGE THIS UNTIL READ REALEASE NOTES.

  # NOTE: Activating XDG user dirs.
  xdg.enable = true;

  # Home Manager install and manage itself.
  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch"; # NOTE: Nice reload on switch.
}
