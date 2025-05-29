{ pkgs, ... }:

{
  programs.password-store.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentry.package = pkgs.pinentry-tty;
}
