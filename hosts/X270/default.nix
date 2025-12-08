# System Environment configuration (it replaces /etc/nixos/configuration.nix).
# Check https://nixos.org/manual/nixos/stable/options for more options (stable branch).

{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}: 
{
  imports = [
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x270
      outputs.nixosModules.bundle # "modules/default.nix"
      ./hardware-configuration.nix
    ];

  # NOTE: systemd-boot configuration (UEFI only).
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
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
    useXkbConfig = true;
  };

  # NOTE: X11 support, audio server, etc.
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "br";
      };
    };
    libinput.enable = true; # Touchpad support.
    printing.enable = false; # Printing system.
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      # jack.enable = true; # Uncomment for use JACK applications.
      pulse.enable = true;
    };
    displayManager.sddm = { # SDDM with Wayland support.
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
  security.rtkit.enable = true; # recommended for PipeWire setup.

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

  # NOTE: Nix package management configuration.
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = ""; # Disable flake global registry.
      nix-path = config.nix.nixPath; # For flakes on NIX_PATH.
      auto-optimise-store = true;
    };

    # NOTE: Disable channels, setting flakeInputs on flake registry and NIX_PATH.
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # NOTE: Garbage collecting configuration.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older than 15d";
    };
  };
  nixpkgs = {
    config = {
      # NOTE: If you do not want unfree packages, change to "false".
      allowUnfree = true;
    };
  };

  # NOTE: System-wide package management.
  environment.systemPackages = with pkgs; [
    # Environment
    hunspell
    hunspellDicts.pt_BR
    libreoffice-qt
    python3
    vim

    # Utils
    curl
    fastfetch
    fzf
    killall
    htop
    ripgrep
    wget
    which

    # File compression.
    bzip2
    gzip
    p7zip
    rar
    unar
    unrar
    unzip
    xz
    zip

    # MS core fonts.
    corefonts
    vista-fonts
  ];
  programs.firefox.enable = true; # Firefox as default browser.

  # NOTE: appimage-run setup.
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  services.flatpak.enable = true;

  # NOTE: Firewall ports configuration.
  networking.firewall = {
    enable = true;
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ];
  };

  # NOTE: Bluetooth setup.
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    # NOTE: Enable OpenGL for GPU acceleration
    graphics = {
      enable = true;
      enable32Bit = true; # for 32-bit applications such Wine
      extraPackages = with pkgs; [ intel-media-driver ];
    };
  };
  # NOTE: Enable ADB and Java module for audiosource.
  programs.adb.enable = true;
  programs.java.enable = true;
 
  system.stateVersion = "25.11"; # NOT CHANGE UNTIL READ RELEASE NOTES.

}

