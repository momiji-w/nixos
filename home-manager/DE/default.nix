{ pkgs, ... }:

{
    imports = [ ./hyprland ];

    gtk = {
        enable = true;
        iconTheme = {
            name = "Adwaita";
            package = pkgs.gnome-themes-extra;
        };
        theme = {
            name = "Materia-dark";
            package = pkgs.materia-theme;
        };
        cursorTheme = {
            name = "Bibata-Modern-Classic";
            package = pkgs.bibata-cursors;
        };
    };

    home.pointerCursor = {
        x11.enable = true;
        gtk.enable = true;
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
        size = 20;
    };
}
