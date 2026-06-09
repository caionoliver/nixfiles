{ config, inputs, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "caionoliver";
      user.email = "caionoliver.contato@gmail.com";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.format = "ssh";
    };

    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
