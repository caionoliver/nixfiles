{ config, lib, ... }:
let
  cfg = config.nm.network;
in
{
  options.nm.network = {
    enable = lib.mkEnableOption "Network stack via NetworkManager";
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;

    networking.firewall = {
      enable = true;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
    };
  };
}
