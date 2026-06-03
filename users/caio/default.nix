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
    ./git.nix

    inputs.self.homeManagerModules.default
  ];
  home.allModules.enable = true;

  # NOTE: Setup home configuration.
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  fonts.fontconfig.enable = true;
  xdg.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "26.05"; # NOT CHANGE THIS UNTIL READ REALEASE NOTES.

  systemd.user.startServices = "sd-switch"; # Nice reload on switch.
}
