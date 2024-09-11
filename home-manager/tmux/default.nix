{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    terminal = "tmux-256color";
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator 
    ];
    extraConfig = ''
      bind-key l select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key h select-pane -R

      bind -n M-h  previous-window
      bind -n M-l next-window

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      bind _ split-window -v -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
    '';
  };
}
