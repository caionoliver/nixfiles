{ config, lib, pkgs, ... }:
let
  cfg = config.nixos.gaming;
in
{
  options.nixos.gaming = {
    enable = lib.mkEnableOption "Common configurations for gaming";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
      bottles
      heroic
      lutris
      mangohud
      protonup-qt
      hydralauncher
    ];
    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
    };

    programs.gamemode.enable = true;
  };
}
