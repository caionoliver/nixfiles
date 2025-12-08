# For home-manager modules.
let
  modulePaths = {
    apps = import ./apps.nix;
  };
in
{
  bundle = {
    imports = builtins.attrValues modulePaths;
  };

  modules = builtins.mapAttrs (_: import) modulePaths;
}
