# configuration.nix

{ inputs, config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # NOTE: systemd-boot configuration (UEFI only).
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # NOTE: Network configuration.
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  #  proxy = { 
  #    default = "http://user:password@proxy:port/";
  #    noProxy = "127.0.0.1,localhost,internal.domain";
  #  };
  };

  # NOTE: Locale settings and sychronize to hardware.
  time.timeZone = "America/Bahia";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  #  keyMap = "br";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # NOTE: Primary services (X11 support, audio server, etc).
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
      };
    };

    libinput.enable = true; # Touchpad support.
    printing.enable = true; # Printing system.

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };

    displayManager.sddm = { # SDDM with Wayland support.
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  # NOTE: System firmwares and drivers.
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics.enable = true; # for GPU acceleration.
    cpu.intel.updateMicrocode = true;
  };

  # NOTE: User and groups management.
  users.users.caio = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "adbusers"
    ];
  };

  # NOTE: Firefox as default web browser.
  programs.firefox.enable = true;

  # NOTE: Nixpkgs configuration.
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # NOTE: System-wide package management.
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    tree
    python3Full
  ];

  # NOTE: Enable flakes and deduplicated store.
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older than 15d";
    };
  };

  # NOTE: Enable SSH and GPG.
  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = [ "caio" ];
      PasswordAuthentication = false;
      # PermitRootLogin = "yes";
    };
  };
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # NOTE: Firewall ports configuration.
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ];
  };

  # NOTE: Enable ADB and Java module for audiosource.
  programs.adb.enable = true;
  programs.java.enable = true;
 
  system.stateVersion = "25.05"; # NOT CHANGE UNTIL READ RELEASE NOTES.

}

