#!/bin/bash

LANG=FR

if [[ ! "$(ps -o ppid= -C parec)" == "" ]] 
then 
  nerd-dictation end
  kill -9 $(ps aux|grep 'python nerd-tray.py'|grep -v grep |awk '{print $2}')
  # notify-send "nerd-ended" 

else 
  # nerd-dictation begin --vosk-model-dir=$HOME/.config/nerd-dictation/model_$LANG &
  cd $HOME/Documents/dotfiles/backup/Scripts
  python nerd-tray.py $LANG &
  # notify-send "nerd-started" 
fi


