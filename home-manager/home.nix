{ config, pkgs, ... }:

{
  imports = [ 
    ./DE
    ./programs
  ];

  home.username = "momiji";
  home.homeDirectory = "/home/momiji";
  home.stateVersion = "24.05"; 

  programs.neovim = inputs.momiji-nvim.lib.mkHomeManager {inherit system;};

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
    freerdp3
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
