{ config, lib, pkgs, ... }:

{
  imports = [ ./hyprland ./dunst];

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
  };
}
