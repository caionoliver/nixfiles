# Font managing and patching.
{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    aileron
    cozette
    dina-font
    fantasque-sans-mono
    fira-code
    font-awesome
    inconsolata
    joypixels
    liberation_ttf
    libertine
    merriweather-sans
    noto-fonts
    noto-fonts-cjk
    open-sans
    roboto
    ttf_bitstream_vera
    victor-mono
    # Override for Nerd fonts patch
    (nerdfonts.override { 
      fonts = [
        "FiraCode"
        "Noto"
        "RobotoMono"
        "Inconsolata"
        "VictorMono"
      ]; 
    })
  ];
  # Need for JoyPixels font
  nixpkgs.config.joypixels.acceptLicense = true;
}
