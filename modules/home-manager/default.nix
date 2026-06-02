# For home-manager modules.
{ config, lib, inputs, ... }:
let
  cfg = config.home.allModules;

  apps = ./apps.nix;
in
{
  imports = [
    apps
  ];

  options.home.allModules.enable = lib.mkEnableOption "Enable all user-wide modules";

  config = lib.mkIf cfg.enable {
    home.common-apps.enable = lib.mkDefault true;
  };
}
