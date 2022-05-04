# This file is only for managing zsh settings, plugins, variables
# etc. Don't use for anything else.
{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    history = {
      size = 1000;
      save = 1000;
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };
    autocd = true;
    dotDir = null;
    sessionVariables = {
      EDITOR = "nvim";
    };
    shellAliases = {
      "." = "cd ~";
      ".." = "cd ..";
      ls = "ls -FaX --color=auto";
      ll = "ls -FaoX --color=auto";
      grep = "grep --color=auto";
    };
    # Plugins and enhancement
    enableCompletion = true;
    enableSyntaxHighlighting = true;

    initExtra =''
      PROMPT='%B%F{9}%m%f%b 
      %~ %B>%b '
      RPROMPT='%t'
    '';
  };
  home.packages = with pkgs; [ nix-zsh-completions ];
}
