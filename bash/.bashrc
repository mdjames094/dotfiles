# If not running interactively, don't do anything
[[ $- == *i* ]] || return

set -o vi
shopt -s autocd

export EDITOR=vim
export VISUAL=vim

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# [ -f /usr/share/powerline/bindings/bash/powerline.sh ] && source /usr/share/powerline/bindings/bash/powerline.sh

[ -d "$HOME/Documents/dotfiles/backup/Scripts" ] && export PATH="$PATH:$HOME/Documents/dotfiles/backup/Scripts"

[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -f ~/.bash_conda ] && source ~/.bash_conda
[ -f ~/.bash_ssh ] && source ~/.bash_ssh
[ -f ~/.bash_tmux ] && source ~/.bash_tmux
[ -f ~/.bash_fzf ] && source ~/.bash_fzf
[ -f ~/.bash_exa ] && source ~/.bash_exa
[ -f ~/.bash_lf ] && source ~/.bash_lf

eval "$(zoxide init bash)"

curl wttr.in/?format=3
echo
