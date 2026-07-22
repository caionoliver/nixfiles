{ config, lib, pkgs, ... }:
let
  cfg = config.nm.nix-ld;
in
{
  options.nm.nix-ld = {
    enable = lib.mkEnableOption "Common Nix-ld libraries";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc.lib
        glib
        zlib
        xz
        zstd

        # File system
        e2fsprogs
        expat
        fuse

        # Audio
        alsa-lib
        libogg
        libpulseaudio
        libvorbis
        pipewire

        # Graphics
        cairo
        fontconfig
        freetype
        libdrm
        libgbm
        libGL
        libvdpau
        vulkan-loader

        # GTK / UI
        atk
        at-spi2-atk
        at-spi2-core
        cups
        dbus
        gtk3
        gtk4
        harfbuzz
        icu
        nspr
        nss
        pango

        # X11 / Wayland
        libxcb
        libxkbcommon
        libxmu
        wayland
        libxcb-cursor

        # Misc
        krb5
        lm_sensors
        openssl
        pciutils

        # Crypto
        libxcrypt

        # SDL2
        SDL2
        SDL2_image
        SDL2_mixer
        SDL2_ttf

        # SDL1
        SDL
        SDL_image
        SDL_mixer
        SDL_ttf
      ];
    };
  };
}
