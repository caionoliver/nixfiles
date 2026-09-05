# /modules/nixos/power.nix
{ config, lib, pkgs, ... }:
let
  cfg = config.nm.power;
in
{
  options.nm.power = {
    enable = lib.mkEnableOption "Setup configs for TLP service";
  };

  config = lib.mkIf cfg.enable {
    powerManagement.enable = true;

    services = {
      power-profiles-daemon.enable = lib.mkForce false;

      tlp = {
        enable = true;
        pd.enable = true;
        settings = {
          CPU_SCALING_GOVERNOR_ON_AC  = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

          CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
          CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

          CPU_MIN_PERF_ON_AC  = 0;
          CPU_MAX_PERF_ON_AC  = 100;
          CPU_MIN_PERF_ON_BAT = 0;
          CPU_MAX_PERF_ON_BAT = 20;

          DISK_APM_LEVEL_ON_AC  = "254 254";
          DISK_APM_LEVEL_ON_BAT = "128 128";

          USB_AUTOSUSPEND = 1;

          START_CHARGE_THRESH_BAT0 = 40;
          STOP_CHARGE_THRESH_BAT0  = 80;
          START_CHARGE_THRESH_BAT1 = 40;
          STOP_CHARGE_THRESH_BAT1  = 80;
        };
      };
    };

    # Interface única para o logind — não misturar com os atalhos
    # lidSwitch/lidSwitchExternalPower/lidSwitchDocked de primeiro nível
    services.logind.settings.Login = {
      HandleLidSwitch             = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked       = "ignore";
      HandlePowerKey              = "suspend";
      IdleAction                  = "ignore";
    };
  };
}
