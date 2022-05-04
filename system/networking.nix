# Import file for networking settings
{ config, pkgs, ... }:

{
  # TODO: For enable wpa_supplicant, comment the NetworkManager
  #networking.wireless.enable = true;
  networking.networkmanager.enable = true;

  networking = {
    useDHCP = false; # useDHCP is deprecated, let explict set to false
    interfaces = {
      enp1s0f2.useDHCP = true;
      wlp2s0.useDHCP = true;
    };
    enableIPv6 = false;
  };

  # Template for firewall settings generated by `nixos-generate-config`
  # networking.firewall = {
  #   allowedTCPPorts = [ ... ];
  #   allowedUDPPorts = [ ... ];
  #   enable = false; # Firewall is enabled by default. Use this to disable
  # };

  # Template for proxy configuration generated by `nixos-generate-config`
  # networking.proxy = {
  #   default = "http://user:password@proxy:port/";
  #   noProxy = "127.0.0.1,localhost,internal.domain";
  # };
}