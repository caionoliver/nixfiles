# Home Manager configuration file.
# Check https://github.com/nix-community/home-manager/ for more information.

{ config, inputs, lib, pkgs, userName, homeDir, ... }:

{
  imports = [
    ./git.nix
  ];

  # NOTE: Setup home configuration.
  home = {
    username = userName;
    homeDirectory = homeDir;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-39.8.10"
  ];

  home.packages = with pkgs; [
    spotify
    telegram-desktop
    gimp
    mpv
    pdfstudioviewer
    masterpdfeditor
    obsidian
    bitwarden-desktop
    qbittorrent
  ];

  fonts.fontconfig.enable = true;
  xdg.enable = true;

  programs.home-manager.enable = true;

  home.stateVersion = "26.05"; # NOT CHANGE THIS UNTIL READ RELEASE NOTES.

  systemd.user.startServices = "sd-switch"; # Nice reload on switch.
}
