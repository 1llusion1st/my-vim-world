# tab panes navigation ^B + Alt-0 ... 4
bind-key -r M-0 select-pane -t 0
bind-key -r M-1 select-pane -t 1
bind-key -r M-2 select-pane -t 2
bind-key -r M-3 select-pane -t 3
bind-key -r M-4 select-pane -t 4

set -g default-terminal "screen-256color"
set-window-option automatic-rename off
set-option set-titles off
