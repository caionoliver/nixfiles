# For NixOS modules.
{ config, lib, inputs, ... }:

let
  cfg = config.nixos.allModules;
in {
  imports = [
    ./gaming.nix
    ./ssh.nix
    ./libvirt.nix
  ];

  options.nixos.allModules.enable = lib.mkEnableOption "Enable all system-wide modules";

  config = lib.mkIf cfg.enable {
    nixos.gaming.enable = lib.mkDefault true;
    nixos.ssh.enable = lib.mkDefault true;
    nixos.libvirt.enable = lib.mkDefault true;
  };
}
