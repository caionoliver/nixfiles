{ config, pkgs, lib, ... }:

{

  # Home username and directory path
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  # Default release version
  home.stateVersion = "21.11";

  imports = [
    ./home/fonts.nix
    ./home/nvim.nix
    ./home/xdg.nix
    ./home/zsh.nix
  ];

  programs.home-manager.enable = true;

  # Enable nonfree packages
  nixpkgs.config.allowUnfree = true;

  programs.git = {
    enable = true;
    userName = "Caio Fernando";
    userEmail = "kylef.noliver@hotmail.com";
  };
 
  gtk = {
    enable = true;
    theme = {
      name = "Sierra-dark";
      package = pkgs.sierra-gtk-theme;
    };
    iconTheme = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };
  };

  home.packages = with pkgs; [
    appimage-run
    brightnessctl
    chromium
    discord
    dmenu
    dunst
    element-desktop
    evince
    eww
    feh
    firefox
    gimp
    gnome.gedit
    gnome.file-roller
    hacksaw
    hakuneko
    inkscape
    kitty
    lxappearance
    mpd
    mpv
    neofetch
    p7zip
    picom
    playerctl
    polybar
    rofi
    shared-mime-info
    shotgun
    spotify
    tdesktop
    unrar
    unzip
    vlc
    vscode
    xclip
    (xfce.thunar.override { thunarPlugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
      thunar-media-tags-plugin
    ]; })
    xfce.tumbler
    xsel
    xwallpaper
  ];

  systemd.user.startServices = "sd-switch";
}
