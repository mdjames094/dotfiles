alias ls='ls --color=auto'
alias lsa='ls -alh'
alias lss='du -sh */ | sort -rn'

alias psa='ps -aux'

alias update='sudo apt update'
alias upgrade='sudo apt upgrade'
alias distup='sudo apt dist-upgrade'

alias sysup='update && upgrade'
alias sysins='sudo apt-fast install'
alias syspur='sudo apt purge'

alias cls='printf "\033c"'

alias duse='du -sk * | sort -rn | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'''

alias h='history | grep $2'

alias tm='tmux'
alias tm2='tmux new -s -d \'

alias tmk='tmux kill-session'
alias tmka='tmux kill-session -a && tmux kill-session'

alias tmls='tm ls'

alias ca='conda activate'
alias cad='conda deactivate'

#alias python='/usr/bin/python3'

alias bfc='sudo tlp fullcharge'


