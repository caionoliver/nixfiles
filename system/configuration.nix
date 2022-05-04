# This is the configuration file. 
# Use this file to edit your system-wide settings.

{ inputs, lib, config, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
    ./networking.nix
    ./system-environment.nix
  ];

  # Set your hostname machine
  networking.hostName = "cool-pc";

  #boot.loader.systemd-boot.enable = true; # Use systemd-boot (for UEFI only)
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    useOSProber = false;
    device = "nodev";
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  # Enable X11 and set the desktop environment
  services.xserver = {
    enable = true;
    windowManager.berry.enable = true;
    displayManager = {
      startx.enable = true; # To run startx on TTY
      #gdm = {
      #  enable = true;
      #  wayland = false;
      #};
      #defaultSession = "none+berry";
    };
  };

  # User management
  users.users = {
    caio = {
      isNormalUser = true;
      shell = pkgs.zsh;
      description = "Caio Fernando";
      extraGroups = [
        "wheel"
        "audio"
        "video"
        "networkmanager"
      ];
    };
  };

  # SSH setup.
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "no";
  };

  # TODO: Feel free to install some packages. It's keep on system-wide environment
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    sxhkd
  ];

  # This will make activate the home-manager upon login
  environment.loginShellInit = ''
    [ -d "$HOME/.nix-profile" ] || /nix/var/nix/profiles/per-user/$HOME/home-manager/activate &> /dev/null
  '';

  # Release version
  system.stateVersion = "21.11";

}

