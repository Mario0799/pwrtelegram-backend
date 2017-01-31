#!/bin/bash
cd $(dirname "$0")
if [ "$1" == "start" ];then
        killall caddy
	tmux kill-session -t pwrtelegram &>/dev/null; tmux new-session -s pwrtelegram -d "caddy &> caddy.log"
	echo "Caddy was started. Waiting until log gets populated..."
	sleep 10
	cat caddy.log

fi
[ "$1" == "stop" ] && tmux kill-session -t pwrtelegram
