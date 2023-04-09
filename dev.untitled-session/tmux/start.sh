 #!/usr/bin/env zsh

FILE=$0:A
DEV_DIR=`python -c "print(\"$FILE\".rpartition('/')[0].rpartition('/')[0])" 2>/dev/null`
PROJ_DIR=`python -c "print(\"$DEV_DIR\".rpartition('/')[0])" 2>/dev/null`
TMUX_DIR="$DEV_DIR/tmux"
TMUX_CONF_FILES=$(ls $TMUX_DIR/*.tmux | sort)
SESSION_NAME=`python -c "print(\"$DEV_DIR\".split(\"/\")[-1].split(\".\")[1])" 2>/dev/null`
VIM_DIR=$DEV_DIR/vim

pyenv activate neovim

echo "DEV_DIR: $DEV_DIR"

GOBIN=~/go/bin
export GOPATH=~/go
export PATH="$GOBIN:$PATH"

# OPENAI
export OPENAI_ORG="$(cat $DEV_DIR/etc/openai.com/org)"
export OPENAI_APIKEY="$(cat $DEV_DIR/etc/openai.com/api.key)"
export OPENAI_API_KEY=$OPENAI_APIKEY

# JIRA
export JIRA_HOST=$(cat $DEV_DIR/jira/domain)
export JIRA_USERNAME=$(cat $DEV_DIR/jira/account)
export JIRA_TOKEN=$(cat $DEV_DIR/jira/token)
export JIRA_PROJECT="$(cat $DEV_DIR/jira/project)"
export JIRA_ISSUE_STATES="$(cat $DEV_DIR/jira/issue_states)"
export TRANS_API_KEY="$(cat $DEV/google/translate/api.key)"

echo "TMUX_CONF_FILES: $TMUX_CONF_FILES"
echo "SESSION_NAME: $SESSION_NAME"
test "$SESSION_NAME" = "" && echo "dev directory must contain session name. e.g.: dev.my-session"
test "$SESSION_NAME" = "" && SESSION_NAME="untitled0"


cd $PROJ_DIR

docker kill plantuml-server || echo not present
docker container rm plantuml-server || echo not present
docker run -d --name plantuml-server -p 4040:8080 plantuml/plantuml-server:jetty

docker kill pgadmin4 || echo not present pgadmin4
docker container rm pgadmin4 || echo not present

mkdir -p $DEV_DIR/pgadmin4/sessions
mkdir -p $DEV_DIR/pgadmin4/servers
mkdir -p $DEV_DIR/pgadmin4/storage
mkdir -p $DEV_DIR/pgadmin4/azurecredentialcache
docker run -d --name pgadmin4 --network=host -u 0 \
    -v "$(realpath $DEV_DIR)/pgadmin4:/var/lib/pgadmin" \
    -e 'PGADMIN_DEFAULT_EMAIL=andrew@example.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    -e 'PGADMIN_CONFIG_ENHANCED_COOKIE_PROTECTION=True' \
    -e 'PGADMIN_CONFIG_LOGIN_BANNER="Authorised users only!"' \
    -e 'PGADMIN_CONFIG_CONSOLE_LOG_LEVEL=10' \
    -d dpage/pgadmin4


# D2 server
docker kill d2server || echo not present
docker container rm d2server || echo not present
docker run -d --name d2server -p 4041:8000 andriyvasyltsiv/d2server
export D2SERVER='http://localhost:7001'

tmux new-session -d -s $SESSION_NAME -x "$(tput cols)" -y "$(tput lines)" -n main \; send-keys $DEV_DIR/opt/nvim/bin/nvim\ -u\ $DEV_DIR/vim/init.vim\ todo.txt ENTER ;
echo "SESSION CREATED ? $?"
tmux setenv GOBIN ~/go/bin
tmux setenv GOPATH ~/go
tmux setenv PATH ~/go/bin:$PATH

tmux select-layout main-vertical ; 
echo "LAYOUT PREPARED ? $?"

tmux split-window -h -p 15 \; send-keys "make -f dev/Makefile tool-vpn-up" C-m \; split-window -v -p 92 \; send-keys "clear; while true; do clear; cat -n todo.txt ; sleep 1; done" C-m \; split-window -v -p 66 \; send-keys "ipython" C-m \; split-window -v -p 66 \; send-keys "ghci" C-m \; split-window -v -p 50 ;
echo "PANES PREPARED ? $?"

for file in $TMUX_CONF_FILES; do
	echo "loading $file"
	tmux source $file ;
done;

tmux display 'LOADED'
tmux set -g status off

tmux a -t $SESSION_NAME  ;

