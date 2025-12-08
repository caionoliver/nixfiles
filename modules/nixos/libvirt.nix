{ config, lib, pkgs,... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # NOTE: For running NixOS as guest.
  # services.spice-vdagentd.enable = true;
  # services.qemuGuest.enable = true;

  # NOTE: Install Virt-manager for manage QEMU.
  programs.virt-manager.enable = true;
  
  users.groups.libvirtd.members = [ "caio" ];

  environment.systemPackages = with pkgs; [
    virt-viewer 
    spice
    spice-gtk
    spice-protocol
    win-spice
    virtio-win
  ];
}
