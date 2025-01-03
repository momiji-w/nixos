{ pkgs, inputs, ... }:

let
  momiji-nixvim = inputs.momiji-nixvim.packages.x86_64-linux.default;
  nixvim = momiji-nixvim.extend {
    viAlias = true;
    vimAlias = true;
  };
  hypr-qtutils = inputs.hypr-qtutils.packages.x86_64-linux.default;
  # ghostty = inputs.ghostty.packages.x86_64-linux.default;
in {
  imports = [ 
    ./DE
    ./git
    ./pass
    ./kitty
    ./tmux
    ./fish
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
    alacritty
    kitty
    firefox
    qutebrowser
    wget
    xdg-utils
    koodo-reader
    lf
    fd
    ncspot
    gimp

    pamixer
    pavucontrol
    xfce.thunar
    btop
    pfetch

    p7zip
    fzf
    toybox
    mdbook
    marp-cli

    python311
    go
    android-tools
    scrcpy
  ] ++ [
    hypr-qtutils
    # ghostty
    nixvim
  ];

  programs.home-manager.enable = true;
}
