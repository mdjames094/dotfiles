---
title: SSH & GITHUB
updated: 2022-11-12 10:27:48Z
created: 2022-11-12 00:18:57Z
---

# 1. Create a ssh key
```
# Generate ssh key
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Check if ssh agent is alive
eval "$(ssh-agent -s)"

# Add the new key to local ssh-agent
ssh-add -l
ssh-add ~/.ssh/id_rsa
ssh-add -l
```

# 2. Link ssh key to github
```
# Add 'github.com' authenticity to your known_hosts
sudo ssh-keyscan github.com | sudo tee -a ~/.ssh/known_hosts

#  Copy public key to clipboard
xclip -selection clipboard -i < ~/.ssh/id_rsa.pub
```

# 3. Create your repository with or without SSH

## 3.1 On your local git config
```
git config --global init.defaultBranch master
```

## 3.2. Create a new repository on the command line
```
echo "# dotfiles" >> README.md
git init
git add README.md (or git add --all)
git commit -m "first commit"
git branch -M main

# For HTTPS
git remote add origin https://github.com/username/dotfiles.git
# Or for SSH
git remote add origin git@github.com:username/dotfiles.git

git push -u origin main
```

## 3.2. Or push an existing repository from the command line
```
# For HHTPS
git remote add origin https://github.com/username/dotfiles.git
# Or fot SSH
git remote add origin git@github.com:username/dotfiles.git

git branch -M main
git push -u origin main
```

# 3. Visit https://rogerdudler.github.io/git-guide/index.fr.html
