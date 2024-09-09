{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "momiji";
    userEmail = "anouluck.many@gmail.com";
  };

  home.packages = with pkgs; [
    lazygit
  ];
}
