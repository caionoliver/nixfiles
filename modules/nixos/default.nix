# For NixOS modules.
{
  audio = import ./audio.nix;
  bluetooth = import ./bluetooth.nix;
  gaming = import ./gaming.nix;
  graphics  = import ./graphics.nix;
  libvirt = import ./libvirt.nix;
  network = import ./network.nix;
  nix-ld = import ./nix-ld.nix;
  power = import ./power.nix;
  ssh = import ./ssh.nix;

}
