{ config, lib, pkgs, ... }:
let
  cfg = config.nm.ssh;
in
{
  options.nm.ssh = {
    enable = lib.mkEnableOption "Turn on SSH support";
  };

  config = lib.mkIf cfg.enable {
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
  };
}
