{ config, pkgs, ... }:

{
  imports = [ 
    ./DE
    ./programs
    ./dev
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
    
    xfce.thunar
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
