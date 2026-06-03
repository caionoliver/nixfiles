# For home-manager modules.
{ config, lib, ... }:

let
  cfg = config.home.allModules;
in {
  imports = [
    ./apps.nix
  ];

  options.home.allModules.enable = lib.mkEnableOption "Enable all user-wide modules";

  config = lib.mkIf cfg.enable {
    home.common-apps.enable = lib.mkDefault true;
  };
}
