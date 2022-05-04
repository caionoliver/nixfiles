# XDG desktop entries and MIME Apps list
{ config, pkgs, ... }:

{ 
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/jpeg" = [ "feh.desktop" ];
        "image/png" = [ "feh.desktop" ];
        "inode/directory" = [ "thunar.desktop" ];
      };
    };

    userDirs = {
      enable = true;
      desktop = "$HOME/desktop";
      documents = "$HOME/docs";
      download = "$HOME/downloads";
      music = "$HOME/media/music";
      pictures = "$HOME/media/pics";
      publicShare = "$HOME/shared";
      videos = "$HOME/media/vods";
    };
    configFile."mimeapps.list".force = true;
  };
}
