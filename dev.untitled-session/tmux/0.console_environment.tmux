# tab panes navigation ^B + Alt-0 ... 4
set -g default-terminal "screen-256color"
set-window-option automatic-rename off
set-option set-titles off
set -g pane-border-status top
set -g pane-border-format " [ ###P #T ] "

unbind-key r
bind r source-file ~/.tmux.conf

bind -r j resize-pane -D 5
bind -r k resize-pane -U 5
bind -r l resize-pane -R 5
bind -r h resize-pane -L 5
