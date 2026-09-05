{ config, lib, ... }:
let
  cfg = config.nm.audio;
in
{
  options.nm.audio = {
    enable = lib.mkEnableOption "Audio stack via PipeWire";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
