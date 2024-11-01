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

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "wlr"
        ];
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

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
    koodo-reader
    mdbook
    marp-cli

    python311
    android-tools
    scrcpy
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
