# Some settings system-wide environment (timezone, locale, X11... etc).
# The session definitions it's here
{ config, pkgs, ... }:

{
  # Set the time zone
  time.timeZone = "America/Bahia";

  # Language properties and console
  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
  };

  # X11 settings
  services.xserver = {
    layout = "br";
    xkbVariant = "abnt2";
    libinput = {
      enable = true;
      touchpad = { # Touchpad configuration
        accelProfile = "flat";
        tapping = true;
        naturalScrolling = false;
        middleEmulation = false;
      };
    };
  };

  # Sound setiings
  sound.enable = true; # Enable ALSA
  hardware.pulseaudio.enable = true;

  # For GTK themes works properly and other things
  programs.dconf.enable = true;

  # For mount, trash and other funcionalities
  services.gvfs.enable = true;

  # Flatpak support
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
