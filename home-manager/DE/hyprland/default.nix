{ pkgs, ... }:

{
  imports = [ ./hyprlock.nix ./waybar.nix ./hyprpaper.nix ./wofi.nix ];

  home.packages = with pkgs; [
    swaynotificationcenter
    hyprlock
    hyprshot
    wl-clipboard
    xwayland
    hyprutils
    swappy
  ];

  xdg.portal = {
    enable = true;
    config = { common = { default = [ "wlr" ]; }; };
    extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  home = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      monitor =
        [ "eDP-1, highres, auto, 1" 
          ", highres, auto, 1"
          "eDP-1, highres, auto, 1, mirror, HDMI-A-1" 
        ];
      xwayland = { force_zero_scaling = true; };

      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "wofi --show drun";

      exec-once = [ "waybar" "hyprpaper" "swaync" ];
      general = {
        gaps_in = 0;
        gaps_out = 0;

        border_size = 1;

        # "col.active_border" = "rgb(ffd1dc)";
        # "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "hy3";
      };

      decoration = {
        rounding = 0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      animations = { enabled = false; };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
      input = {
        kb_layout = "us, la";
        kb_options = "grp:win_space_toggle";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = { natural_scroll = true; };
      };
      gestures = { workspace_swipe = false; };
      "$mainMod" = "SUPER";
      "$screenshot" = "hyprshot -m region --clipboard-only";
      "$screenshot_edit" = "hyprshot -m region -raw | swappy -f -";
      "$screenshot_whole" = "hyprshot -m output -o ~/Screenshots";
      "$lock" = "hyprlock";
      plugin = {
        hy3 = {
          tabs = {
            height = 12;
            boarder_width = 1;
            render_text = false;
            "col.active" = "rgba(33ccff20)";
            "col.active.border" = "rgba(33ccffee)";
            "col.inactive" = "rgba(30303020)";
            "col.inactive.border" = "rgba(595959aa)";
            "col.urgent" = "rgba(ff2233ee)";
            "col.urgent.border" = "rgba(ff2233ee)";
          };
        };
      };
      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod&SHIFT_L, Q, killactive,"
        "$mainMod, F, fullscreen,"
        "$mainMod&SHIFT_L, M, exit,"
        # "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        # "$mainMod, S, exec, $screenshot"
        "$mainMod&SHIFT_L, S, exec, $screenshot_edit"
        ", PRINT, exec, $screenshot_whole"
        "$mainMod&SHIFT_L&CTRL_L, L, exec, $lock"
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"
        "$mainMod&SHIFT_L, H, movewindow, l"
        "$mainMod&SHIFT_L, L, movewindow, r"
        "$mainMod&SHIFT_L, K, movewindow, u"
        "$mainMod&SHIFT_L, J, movewindow, d"
        "$mainMod&CTRL_L, H, resizeactive, -30 0"
        "$mainMod&CTRL_L, L, resizeactive, 30 0"
        "$mainMod&CTRL_L, K, resizeactive, 0 -30"
        "$mainMod&CTRL_L, J, resizeactive, 0 30"
        "$mainMod, n, workspace, 1"
        "$mainMod, e, workspace, 2"
        "$mainMod, i, workspace, 3"
        "$mainMod, o, workspace, 4"
        "$mainMod, t, workspace, 5"
        "$mainMod, s, workspace, 6"
        "$mainMod, r, workspace, 7"
        "$mainMod, a, workspace, 8"
        "$mainMod SHIFT, n, movetoworkspace, 1"
        "$mainMod SHIFT, e, movetoworkspace, 2"
        "$mainMod SHIFT, i, movetoworkspace, 3"
        "$mainMod SHIFT, o, movetoworkspace, 4"
        "$mainMod SHIFT, t, movetoworkspace, 5"
        "$mainMod SHIFT, s, movetoworkspace, 6"
        "$mainMod SHIFT, r, movetoworkspace, 7"
        "$mainMod SHIFT, a, movetoworkspace, 8"
        ",XF86AudioMicMute,exec,pamixer --default-source -t"
        ",XF86MonBrightnessDown,exec,light -U 20"
        ",XF86MonBrightnessUp,exec,light -A 20"
        ",XF86AudioMute,exec,pamixer -t"
        ",XF86AudioLowerVolume,exec,pamixer -d 10"
        ",XF86AudioRaiseVolume,exec,pamixer -i 10"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPause,exec,playerctl play-pause"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      windowrulev2 = "suppressevent maximize, class:.*";
    };
  };
}
