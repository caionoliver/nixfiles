# For NixOS modules.
{
  gaming = import ./gaming.nix;
  ssh = import ./ssh.nix;
  libvirt = import ./libvirt.nix;

}
