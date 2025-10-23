{
  config,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    # Socials
    discord
    spotify
    telegram-desktop

    # Image and video
    gimp
    inkscape
    pdfstudioviewer
    masterpdfeditor
    stirling-pdf

    # Security
    bitwarden-desktop
  ];
}
