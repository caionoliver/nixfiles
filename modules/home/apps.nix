{ config, lib, pkgs, ... }:
let
  cfg = config.home.common-apps;
in
{
  options.home.common-apps = {
    enable = lib.mkEnableOption "Dowloading personal apps for desktop";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # Socials
      spotify
      discord
      vesktop
      # Multimedia
      gimp
      mpv
      pdfstudioviewer
      masterpdfeditor
      # Productivity
      obsidian
      # Development, Security and etc.
      bitwarden-desktop
      qbittorrent
      code
    ];
  };
}
