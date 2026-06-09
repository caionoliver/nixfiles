{ config, lib, pkgs, ... }:
let
  cfg = config.nixos.libvirt;
in
{
  options.nixos.libvirt = {
    enable = lib.mkEnableOption "Enable manage Virtual Machines with libvirt";
    users = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Users to add to the libvirtd group.";
    };
  };

  config = lib.mkIf cfg.enable {
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

    users.groups.libvirtd.members = cfg.users;

    environment.systemPackages = with pkgs; [
      spice
      spice-gtk
      win-spice
      virtio-win
    ];
  };
}
