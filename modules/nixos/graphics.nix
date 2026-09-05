{ config, lib, pkgs, ... }:
let
  cfg = config.nm.graphics;
in
{
  options.nm.graphics = {
    enable = lib.mkEnableOption "GPU acceleration via Intel media driver";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        intel-media-driver
      ];
    };

    environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";
  };
}
