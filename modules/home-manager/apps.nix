{ config, pkgs, ... }: 

{
  home.packages = with pkgs; [
    # Socials
    spotify
    telegram-desktop
    discord
    vesktop

    # Images and office
    gimp
    pdfstudioviewer
    masterpdfeditor
    obsidian

    # Security
    bitwarden-desktop
  ];
}
