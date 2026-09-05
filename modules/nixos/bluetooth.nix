{ config, lib, ... }:
let
  cfg = config.nm.bluetooth;
in
{
  options.nm.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth via BlueZ";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
  };
}
