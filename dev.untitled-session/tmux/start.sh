#!/usr/bin/env zsh

FILE=$0:A
DEV_DIR=`python -c "print(\"$FILE\".rpartition('/')[0].rpartition('/')[0])" 2>/dev/null`
PROJ_DIR=`python -c "print(\"$DEV_DIR\".rpartition('/')[0])" 2>/dev/null`
TMUX_DIR="$DEV_DIR/tmux"
TMUX_CONF_FILES=$(ls $TMUX_DIR/*.tmux | sort)
SESSION_NAME=`python -c "print(\"$DEV_DIR\".split(\"/\")[-1].split(\".\")[1])" 2>/dev/null`
VIM_DIR=$DEV_DIR/vim

GOBIN=~/go/bin
export GOPATH=~/go
export PATH="$GOBIN:$PATH"

echo "TMUX_CONF_FILES: $TMUX_CONF_FILES"
echo "SESSION_NAME: $SESSION_NAME"
test "$SESSION_NAME" = "" && echo "dev directory must contain session name. e.g.: dev.my-session"
test "$SESSION_NAME" = "" && SESSION_NAME="untitled0"


cd $PROJ_DIR

tmux new-session -d -s $SESSION_NAME -x "$(tput cols)" -y "$(tput lines)" -n main \; send-keys $DEV_DIR/opt/nvim/bin/nvim\ -u\ $DEV_DIR/vim/init.vim ENTER ;
echo "SESSION CREATED ? $?"
tmux setenv GOBIN ~/go/bin
tmux setenv GOPATH ~/go
tmux setenv PATH ~/go/bin:$PATH

tmux select-layout main-vertical ; 
echo "LAYOUT PREPARED ? $?"

tmux split-window -h -p 10 \; split-window -v -p 66 \; split-window -v -p 50 ;
echo "PANES PREPARED ? $?"

for file in $TMUX_CONF_FILES; do
	tmux source $file ;
done;

tmux display 'LOADED'
tmux a -t $SESSION_NAME  ;

