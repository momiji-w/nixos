{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
    };
    font.package = pkgs.nerdfonts.override {
      fonts = [ "JetBrainsMono" ];
    };
    font.name = "JetBrains Mono Nerd Font";
    font.size = 14;
  };
}
