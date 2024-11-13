{ pkgs, ... }:

{
    programs.wofi = {
        enable = true;
        style = ''
* {
    font-size: 18px;
}
window {
    margin: 0px;
    border: 1px solid #39c5bb;
    background-color: #242829;
}

#input {
    margin: 5px;
    border: none;
    border-radius: 5px;
    color: #dcd7d7;
    background-color: #4a4b4b;
}

#inner-box {
    margin: 5px;
    border: none;
    background-color: #242829;
}

#outer-box {
    margin: 5px;
    border: none;
    background-color: #242829;
}

#scroll {
    margin: 0px;
    border: none;
}

#text {
    margin: 5px;
    border: none;
    color: #dcd7d7;
} 

#entry.activatable #text {
    color: #242829;
}

#entry > * {
    color: #dcd7d7;
}

#entry:selected {
    background-color: #4a4b4b;
}

#entry:selected #text {
    font-weight: bold;
}
        '';
    };
}
