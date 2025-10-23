{ config, lib, pkgs, ...}:

{
  # NOTE: Setup libvirt daemon.
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [(pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd];
        };
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };

  # NOTE: For running NixOS as guest.
  # services.spice-vdagentd.enable = true;
  # services.qemuGuest.enable = true;

  # NOTE: Install Virt-manager for manage isos.
  programs.virt-manager.enable = true;
  
  users.groups.libvirtd.members = [ "caio" ];

  environment.systemPackages = with pkgs; [
    virt-viewer 
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];
}
