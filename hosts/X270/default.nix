# configuration.nix

{ config, inputs, lib, pkgs, mainUser, ... }:
{
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-x270
    ./hardware-configuration.nix
  ];
  # NOTE: All local modules are imported by default; must be disabled explicitly.
  nm.libvirt.enable = false;

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    timeout = 0;
  };

  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.consoleLogLevel = 3;
  boot.initrd.verbose  = false;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];

  time.timeZone = "America/Bahia";

  i18n.defaultLocale = "pt_BR.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services.xserver = {
    enable = true;
    xkb.layout = "br";
  };
  services.libinput.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  # NOTE: "username" or "mainUser" are defined in flake.nix!
  users.users.${mainUser} = {
    description = "Caio"; # Change as you like;
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "audio"
      "networkmanager"
      "adbusers"
      "libvirt"
    ];
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      flake-registry = "";
      nix-path = config.nix.nixPath;
      auto-optimise-store = true;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.pt_BR
    vim
    curl
    wget
    android-tools
  ];

  fonts.packages = with pkgs; [
    corefonts
    vista-fonts
    freefont_ttf
  ];

  programs = {
    firefox.enable = true;
    java.enable = true; # needed for gdzx/audiosource
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services.flatpak.enable = true;

  # NOTE: zRAM for memory swap, optional
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 75;
    priority = 100;
  };
  boot.kernel.sysctl."vm.swappiness" = 100;

  # NOTE: DON'T CHANGE UNTIL YOU READ RELEASE NOTES
  system.stateVersion = "26.05";
}
