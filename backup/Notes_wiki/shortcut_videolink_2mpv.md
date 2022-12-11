1. Install xclip first :
```
sudo apt install xclip
```

2. Link this command to any keyboard shortcut to open (browser) link in mpv player

```
xterm -iconic -e 'mpv --no-terminal --ontop --autofit=640x480 --geometry=99%:2% --ytdl-format=22 "$(xclip -o -selection clipboard)" || mpv --no-terminal --ontop --autofit=640x480 --geometry=99%:2% "$(xclip -o -selection clipboard)" '
```
