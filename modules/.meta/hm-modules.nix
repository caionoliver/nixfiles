{ config, lib, ... }:

let
  modules = import ../home/default.nix;
  cfg = config.hm.allModules;
in
{
  imports = builtins.attrValues modules;

  options.hm.allModules.enable =
    lib.mkEnableOption "Enable all Home Manager modules";

  config = lib.mkIf cfg.enable {
    hm = builtins.listToAttrs (
      map (name: {
        inherit name;
        value = {
          enable = lib.mkDefault true;
        };
      })
      (builtins.attrNames modules)
    );
  };
}
