{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python311
    go
  ];
}
