{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "caio" ];
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
