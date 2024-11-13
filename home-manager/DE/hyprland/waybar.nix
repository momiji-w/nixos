{
    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                position = "bottom";
                modules-left = ["hyprland/workspaces"];
                # modules-center = ["hyprland/window"];
                modules-right = ["network" "custom/bar" "battery" "custom/bar" "clock"];

                tray = {
                    icon-size = 21;
                    spacing = 10;
                };
                clock = {
                    format = "{:%Y-%m-%d %I:%M %p}";
                };
                backlight = {
                    format = "{percent}% ";
                    format-icons = ["" ""];
                };
                battery = {
                    states = {
                        good = 95;
                        warning = 30;
                        critical = 15;
                    };
                    format = "  {capacity}% ";
                    format-charging = "󱐋 {capacity}%";
                    format-plugged = "  {capacity}%";
                };
                "battery#bat2" = {
                    bat = "BAT2";
                };
                network = {
                    format-wifi = "{essid} ({signalStrength}%)";
                    format-ethernet = "{ifname}: {ipaddr}/{cidr}";
                    format-linked = "{ifname} (No IP)";
                    format-disconnected = "Disconnected";
                    format-alt = "{ifname}: {ipaddr}/{cidr}";
                };
                "custom/bar" = {
                    format = " | ";
                };
            };
        };
        style = ''
* {
    border: none;
    border-radius: 0px;
    font-family: "JetBrains Mono", sans-serif;

    /* adjust font-size value to your liking: */
    font-size: 14px;

    min-height: 0;
}

window#waybar {
    background-color: rgba(0, 0, 0, 0.9);
    color: #ffffff;
}

#window,
#workspaces {
    background: rgba(0, 0, 0, 0);
    margin: 0 4px;
}

#workspaces button {
    color: #ffffff;
    box-shadow: inset 0 -3px transparent;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
#workspaces button:hover {
    box-shadow: inset 0 -3px #39c5bb;
}

#workspaces button.active {
    box-shadow: inset 0 -3px #39c5bb;
}

#clock,
#battery,
#network
{
    background: rgba(0, 0, 0, 0);
    padding: 0 10px;
    margin: 6px 3px; 
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#clock {
    color: white;
}

#battery {
    color: white;
}

@keyframes blink {
    to {
        background-color: #ffffff;
        color: #000000;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: #ffffff;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

#network {
    color:white;
}

#network.disconnected {
    background-color: #f53c3c;
}
'';
    };
}
