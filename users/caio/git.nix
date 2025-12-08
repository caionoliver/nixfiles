{ config, pkgs, ... }: 

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "caionoliver";
      user.email = "caionoliver.contato@gmail.com";
    };
    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
