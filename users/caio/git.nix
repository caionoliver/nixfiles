{ config, inputs, pkgs, homeDir, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "caionoliver";
      user.email = "caionoliver.contato@gmail.com";
      user.signingkey = "${homeDir}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "${homeDir}/.ssh/allowed_signers";
    };

    ignores = [
      "*~"
      "*.swp"
    ];
  };
}
