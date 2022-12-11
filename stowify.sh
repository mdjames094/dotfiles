#!/bin/bash

echo "Stowing Dotfiles...";

for file in *; do
  # Only run Stow on the directories in the dotfiles folder and not the individual files.
  # Using 'basename' strips the filepath from the directory name.
  if [ -d ${file} ]; then
    stow  $(basename $file)
    echo " $(basename $file) stowed.";
  fi
done

echo 'All stowed';
