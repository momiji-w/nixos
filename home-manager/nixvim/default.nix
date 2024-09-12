{ config, pkgs, ... }:

{
  home-manager.users.momiji.programs.nixvim = let nixvim = (import ../../nixosModules/nixvim) { inherit config pkgs; }; in with nixvim.config; {
    inherit plugins globalOtps globals keymaps;
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
