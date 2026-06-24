{ config, lib, ... }:

let
  modules = import ../nixos/default.nix;
  cfg = config.nm.allModules;
in
{
  imports = builtins.attrValues modules;

  options.nm.allModules.enable =
    lib.mkEnableOption "Enable all NixOS modules" // { default = true; };

  config = lib.mkIf cfg.enable {
    nm = builtins.listToAttrs (
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
