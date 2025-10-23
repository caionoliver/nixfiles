# configuration.nix
{ config,
  inputs,
  lib,
  pkgs,
  outputs,
  ...
}:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/nixos/default.nix
    ];

  # NOTE: systemd-boot configuration (UEFI only).
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  # NOTE: Network configuration.
  networking = {
    hostName = "NixOS";
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
      # jack.enable = true; # NOTE: Uncomment if want to use JACK applications.
      pulse.enable = true;
      wireplumber = {
        extraConfig.bluetoothEnhancements = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
          };
        };
      };
    };

    displayManager.sddm = { # SDDM with Wayland support.
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
  security.rtkit.enable = true; # recommended for PipeWire setup.

  # NOTE: System firmwares and drivers.
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
    graphics = {
      enable = true; # for GPU acceleration.
      enable32Bit = true; # for 32-bit applications such Wine
    };
    cpu.intel.updateMicrocode = true;
  };

  # NOTE: User and groups management.
  users.users.caio = {
    description = "Caio";
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "adbusers"
    ];
  };

  # NOTE: Nixpkgs configuration.
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # NOTE: System-wide package management.
  environment.systemPackages = with pkgs; [
    # Environment
    hunspell
    hunspellDicts.pt_BR
    libreoffice-qt
    python3Full
    vim

    # Utils
    curl
    fastfetch
    fzf
    killall
    htop
    ripgrep
    wget

    # File compression.
    bzip2
    gzip
    p7zip
    rar
    unar
    unrar
    xz

    # MS core fonts.
    corefonts
    vista-fonts
  ];
  programs.firefox.enable = true; # Firefox as default browser.
  
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

  # NOTE: appimage-run setup.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

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

