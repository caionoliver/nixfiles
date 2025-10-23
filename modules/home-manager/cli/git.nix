{ config, pkgs, ... }:

{
    programs.git = {
    enable = true;
    userName = "caionoliver";
    userEmail = "caionoliver.contato@gmail.com";
    ignores = [
      "*~"
      "*.swp"
    ];
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
