_alert() {
    arg=$1
    test "$arg" = "" && arg="notificatoin from console"
    osascript -e "display notification \"$arg\" with title \"console\""
}

if [[ "$(uname)" = "Linux" ]]; then
    echo ;
else
    test -f /tmp/yabai.sa || echo $(sudo yabai --load-sa && touch /tmp/yabai.sa);
    alias alert='_alert'
fi


_ussh() {
    ssh -o UserKnownHostsFile=/dev/null -o "StrictHostKeyChecking=no" $@
}

alias ussh=_ussh

_uscp() {
    scp -o UserKnownHostsFile=/dev/null -o "StrictHostKeyChecking=no" $@
}

alias uscp=_uscp

_ussh_copy_id() {
    ssh-copy-id -i ~/.ssh/id_rsa.pub -o UserKnownHostsFile=/dev/null -o "StrictHostKeyChecking=no" $@
}

alias ussh-copy-id=_ussh_copy_id
