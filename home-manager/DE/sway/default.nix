{ lib, config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wofi
    wl-clipboard
    swaynotificationcenter
    swaybg
    hyprshot
  ];

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 20;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "wofi --show drun";
      defaultWorkspace = "workspace number 1";
      startup = [{ command = "exec swaync"; }];
      keybindings =
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+Ctrl+l" = "exec swaylock";
          "${modifier}+Shift+n" =
            "exec adb shell am start -a android.intent.action.VIEW -d $(wl-paste)";
          "${modifier}+Shift+s" = "exec hyprshot -m region --clipboard-only";
          "${modifier}+Shift+m" = "exec sway exit";
        };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "*" = {
          xkb_layout = "us,la";
          xkb_options = "grp:win_space_toggle";
        };
      };
    };
  };
}
