{ lib, config, pkgs, ...}:

{
    home.packages = with pkgs; [ 
        wofi
        wl-clipboard
        swaynotificationcenter
        swaybg
        hyprlock
        hyprshot
    ];
    wayland.windowManager.sway = {
        enable = true;
        systemd.enable = true;
        config = {
            modifier = "Mod4";
            terminal = "kitty"; 
            menu = "wofi --show drun";
            defaultWorkspace = "workspace number 1";
            startup = [
                { command = "exec swaync"; }
            ];
            keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
            in lib.mkOptionDefault {
                "${modifier}+Shift+Ctrl+l" = "exec hyprlock";
                "${modifier}+Shift+n" = "exec adb shell am start -a android.intent.action.VIEW -d $(wl-paste)";
                "${modifier}+Shift+s" = "exec hyprshot -m region --clipboard-only";
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
