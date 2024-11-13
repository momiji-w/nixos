{ pkgs, ... }:

{
    imports = [ 
        ./DE
        ./nixvim
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
        kitty
        firefox
        wget
        koodo-reader
        ncspot

        pamixer
        pavucontrol
        xfce.thunar
        htop
        pfetch

        p7zip
        fzf
        toybox
        mdbook
        marp-cli

        python311
        go
        nodejs_22
        android-tools
        scrcpy
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
