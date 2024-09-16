{ pkgs, ... }:

{
  imports = [ 
    ./DE
    ./nixvim
    ./git
    ./pass
    ./kitty
    ./tmux
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
    xfce.thunar
    htop

    p7zip
    fzf

    python311
    android-tools
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
