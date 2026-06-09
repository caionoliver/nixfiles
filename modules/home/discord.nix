# home.nix
{ config, lib, inputs, ... }:

let
  cfg = config.home.discord;
in {

  imports = [ inputs.nixcord.homeModules.nixcord ];

  options.home.discord.enable = lib.mkEnableOption "Manage Discord configurations by Nixcord";

  config = lib.mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      discord = {
        krisp.enable = true;
        # openASAR.enable = true;
      };
    };
  };
}
