#!/bin/bash

alias ls='exa --icons --color=auto --group-directories-first'
alias lsa='exa -al --icons --group-directories-first'

alias cat='bat -p'

alias lf="lfcd"
# alias lf='function _lf() { if [[ -z "${TMUX}" ]] ; then lfcd ; else lf; fi; unset -f _lf; }; _lf'

alias lss='du -sh */ | sort -rn'

alias psa='ps -aux'

alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias distup='sudo apt dist-upgrade'
alias fupdate='flatpak update -y'

alias fls='flatpak list --app'
alias fins='flatpak install'
alias fpur='flatpak uninstall --delete-data -y'
alias fclean='flatpak uninstall --unused -y'

alias sysup='update && upgrade && fupdate'
alias sysins='sudo apt install'
alias syspur='sudo apt purge'
alias sysclean='sudo apt autoremove && sudo apt clean'

alias cls='printf "\033c"'

alias duse='du -sk * | sort -rn | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'''

alias h='history | grep $2'

alias ta="tmux a -t"
alias tls="tmux ls"
alias tk='tmux kill-session'
alias tka='tmux kill-session -a && tmux kill-session'

alias ca='conda activate'
alias cad='conda deactivate'
alias jn='jupyter notebook'
alias q='doc; cd Python/ticker; ~/anaconda3/envs/mrs/bin/python ticker_async_bash.py '

alias bfc='sudo tlp fullcharge'

alias ..='cd ..'
alias v='vim'
alias sv='sudoedit'

alias dl='cd ~/Downloads'
alias doc='cd ~/Documents'
alias mrs='cd ~/Documents/Python/MRS'

alias ydl="youtube-dl "

#alias ctc='cat $1 | xclip -selection clipboard'
alias ctc="xclip -selection clipboard -i < $2"

alias wac='function _wac() { mapwacom.sh --device-regex="$1" --screen="$2"; unset -f _wac; }; _wac'
alias wac1="wac stylus eDP-1"
alias wac2="wac stylus HDMI2"
