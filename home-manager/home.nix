{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "caio";
  home.homeDirectory = "/home/caio";

  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    discord
  ];

  # Dotfiles management.
  home.file = {
    
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Git local confguration.
  programs.git = {
    enable = true;
    userName = "caionoliver";
    userEmail = "caionoliver.contato@gmail.com";
    ignores = [ 
      "*~"
      "*.swp"
    ];
    lfs = {
      enable = true;
      skipSmudge = true; # require "git lfs pull" every new commit
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
