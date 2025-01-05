{ pkgs, inputs, ... }:

let
  nixvim = inputs.momiji-nixvim.packages.x86_64-linux.default;
  hypr-qtutils = inputs.hypr-qtutils.packages.x86_64-linux.default;
  cli-packages = with pkgs; [
    ncspot
    pamixer
    btop
    pfetch

    p7zip
    fzf
    mdbook
    marp-cli
    wget
    xdg-utils
    lf
    fd

    python311
    go
    android-tools
    scrcpy
  ];
  gui-packages = with pkgs; [
    firefox
    qutebrowser

    alacritty
    kitty

    koodo-reader
    gimp
    loupe

    pavucontrol
    xfce.thunar
  ];
  flake-packages = [ hypr-qtutils nixvim ];
in {
  imports = [ ./DE ./git ./pass ./kitty ./tmux ./fish ];

  home.username = "momiji";
  home.homeDirectory = "/home/momiji";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  xdg.portal = {
    enable = true;
    config = { common = { default = [ "wlr" ]; }; };
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  programs.direnv.enable = true;

  home.packages = cli-packages ++ gui-packages ++ flake-packages;

  programs.home-manager.enable = true;
}
