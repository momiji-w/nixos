{ pkgs, ... }:

let
  # nixvim = inputs.momiji-nixvim.packages.x86_64-linux.default;
  cli-packages = with pkgs; [
    ncspot
    pamixer
    btop
    pfetch
    slides
    vial

    p7zip
    fzf
    mdbook
    marp-cli
    wget
    xdg-utils
    lf

    python311
    go
    android-tools
    scrcpy
    dconf
  ];
  gui-packages = with pkgs; [
    firefox
    ungoogled-chromium
    qutebrowser
    luakit

    alacritty

    koodo-reader
    gimp
    loupe
    abiword

    pavucontrol
    xfce.thunar
    blueman
    burpsuite
    thunderbird

    osu-lazer-bin
    river
  ];
  flake-packages = [ ];
in {
  imports = [ ./DE ./git ./pass ./tmux ./fish ./kitty ];

  # home.username = "momiji";
  # home.homeDirectory = "/home/momiji";
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  programs.direnv.enable = true;

  home.packages = cli-packages ++ gui-packages ++ flake-packages;

  # programs.home-manager.enable = true;
}
