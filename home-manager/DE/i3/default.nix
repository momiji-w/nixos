{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
    feh
    arandr
    autorandr
    xss-lock
    i3lock-fancy
  ];

  services.dunst.enable = true;

  xsession.windowManager.i3 = let modkey = "Mod4";
  in {
    enable = true;
    config = {
      modifier = "${modkey}";
      terminal = "kitty";
      defaultWorkspace = "workspace number 1";

      startup = [
        # { command = "xss-lock --transfer-sleep-lock -- i3lock-fancy --nofork"; }
        { command = "feh --bg-fill /home/momiji/wallpapers/nimi.jpg"; }
        { command = "xset s off"; }
        { command = "xset -dmps"; }
        { command = "setxkbmap -layout \"us,la\""; }
        { command = "setxkbmap -option \"grp:win_space_toggle\""; }
      ];

      keybindings = let mod = "${modkey}";
      in lib.mkOptionDefault {
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+shift+h" = "move left";
        "${mod}+shift+j" = "move down";
        "${mod}+shift+k" = "move up";
        "${mod}+shift+l" = "move right";
        "${mod}+Ctrl+Shift+l" = "exec i3lock-fancy";
      };
    };
  };
}
