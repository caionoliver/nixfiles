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
    onlyoffice-documentserver
    onlyoffice-desktopeditors
    kdePackages.kdenlive

    # Security
    bitwarden-desktop
  ];
}
