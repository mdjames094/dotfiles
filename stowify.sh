#!/usr/bin/env bash

cd ~/dotfiles

for folder in *; do
    if [ -d "$folder" ]; then
        # Will not run if no directories are available
        echo "$folder"
	stow -R $folder
    fi
done


