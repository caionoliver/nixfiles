# home.nix
{ config, lib, inputs, ... }:

let
  cfg = config.hm.discord;
in {

  imports = [ inputs.nixcord.homeModules.nixcord ];

  options.hm.discord.enable = lib.mkEnableOption "Manage Discord configurations by Nixcord";

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      discord = {
        krisp.enable = true;
        vencord.enable = false;
        openASAR.enable = false;
        silenceNoModClientWarning = true;
      };
    };
  };
}
