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
    plugins = with pkgs.hyprlandPlugins; [ hy3 ];

    settings = {
      monitor =
        [ "eDP-1, 1920x1080@144, auto, 1" ", highrr, auto, 1, mirror, eDP-1" ];
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
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, D, exec, $menu"
        "$mainMod, S, exec, $screenshot"
        "$mainMod&SHIFT_L, S, exec, $screenshot_edit"
        ", PRINT, exec, $screenshot_whole"
        "$mainMod, T, hy3:makegroup, tab"
        "$mainMod&SHIFT_L&CTRL_L, L, exec, $lock"
        "$mainMod, H, hy3:movefocus, l"
        "$mainMod, L, hy3:movefocus, r"
        "$mainMod, K, hy3:movefocus, u"
        "$mainMod, J, hy3:movefocus, d"
        "$mainMod&SHIFT_L, H, hy3:movewindow, l"
        "$mainMod&SHIFT_L, L, hy3:movewindow, r"
        "$mainMod&SHIFT_L, K, hy3:movewindow, u"
        "$mainMod&SHIFT_L, J, hy3:movewindow, d"
        "$mainMod&CTRL_L, H, resizeactive, -30 0"
        "$mainMod&CTRL_L, L, resizeactive, 30 0"
        "$mainMod&CTRL_L, K, resizeactive, 0 -30"
        "$mainMod&CTRL_L, J, resizeactive, 0 30"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
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
