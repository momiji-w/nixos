{ config, pkgs, ... }:

{
  imports = [ 
    ./DE
    ./dev
    ./programs
  ];

  home.username = "momiji";
  home.homeDirectory = "/home/momiji";
  home.stateVersion = "24.05"; 

  home.packages = with pkgs; [
    kitty
    firefox
    wget

    pamixer
    pavucontrol
    htop

    p7zip
    git
    kanata
    
    xfce.thunar
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
