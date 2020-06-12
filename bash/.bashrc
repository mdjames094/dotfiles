set -o vi
shopt -s autocd


# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Powerline
#if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
#    source /usr/share/powerline/bindings/bash/powerline.sh
#fi


# Aliases
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi


# conda
if [ -f ~/.bash_conda ]; then
    source ~/.bash_conda
fi


# Prompt and other commands
if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi


# Linux Lite Custom Terminal
_llver=$(awk '{print}' /etc/llver)
_kernelv=$(uname -r)
_date=$(date "+%d/%m %R")
_kernel=$(echo -e "\e[94m \e[37m${_kernelv}")
_mem=$(free -m | awk 'NR==2{printf "\033[94m" "\033[37m" "%s" "\033[0m" "/%sMB\n", $3,$2 }')
_disk=$(df -h | awk '$NF=="/"{printf "\033[94m" "\033[37m" "%d" "\033[0m" "/%dGB\n", $3,$2}')
echo -e "$_date,$_kernel, $_mem, $_disk"
echo " "


# Clear screen shortcut
bind -x '"\C-t": printf "\033c"'


export HISTCONTROL=IGNORESPACE



