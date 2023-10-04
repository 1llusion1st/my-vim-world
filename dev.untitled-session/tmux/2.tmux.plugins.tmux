set -g @plugin 'tmux-plugins/tpm'

# list of plugins
set -g @plugin 'jimeh/tmux-themepack'
set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes

# theme
set -g @themepack 'powerline/default/cyan' # use this theme for tmux

set -g @resurrect-capture-pane-contents 'on'
set -g @continuum-restore 'on'

run '~/.tmux/plugins/tpm/tpm'
