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

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    kitty
    firefox
    chromium
    spotify
    wget

    pamixer
    pavucontrol
    xfce.thunar
    htop

    p7zip
    fzf
    koodo-reader

    python311
    android-tools
    scrcpy
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
