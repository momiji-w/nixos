{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    python
    go
    rust
  ];
}
