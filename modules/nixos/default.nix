# For NixOS modules.
let
  modulePaths = {
    gaming = import ./gaming.nix;
    ssh = import ./ssh.nix;
    libvirt = import ./libvirt.nix;
  };
in
{
  bundle = { 
    imports = builtins.attrValues modulePaths;
  };

  modules = builtins.mapAttrs (_: import) modulePaths;
}
