# Neovim configuration by Nix (home-manager)
{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-polyglot
			gruvbox
    ];
    extraConfig = ''
      syntax enable
      colorscheme gruvbox

      highlight Normal guibg=NONE ctermbg=NONE
      highlight NonText guibg=NONE ctermbg=NONE
      highlight EndOfBuffer guibg=NONE ctermbg=NONE
    '';
  };
}
