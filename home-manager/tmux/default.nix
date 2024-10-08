{ config, ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    terminal = "tmux-256color";
    extraConfig = ''
      bind -n M-l select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-h select-pane -R

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      bind _ split-window -v -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
    '';
  };
}
