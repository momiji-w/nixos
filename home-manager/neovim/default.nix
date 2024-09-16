{ config, pkgs, ...}:

{
  programs.nixvim = let neovim = (import ../../nixosModules/neovim) { inherit config pkgs; }; in with neovim.config; {
    inherit keymaps plugins globalOpts global;
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
