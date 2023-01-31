#!/usr/bin/env python3

import os
import gi
import sys

gi.require_version("Gtk", "3.0")
gi.require_version("AppIndicator3", "0.1")
gi.require_version('Notify', '0.7')
from gi.repository import Gtk as gtk, GLib as glib
from gi.repository import AppIndicator3 as appindicator
# from gi.repository import Notify as notify

Deep = "https://www.youtube.com/playlist?list=PL1eEkhVDbtH-v7eALPFQBpQhUIOW1oqEf"
House = "https://www.youtube.com/watch?v=36YnV9STBqc"
Chill = "https://www.youtube.com/watch?v=vvGTc3LJtVQ"
Classic = "https://www.youtube.com/watch?v=trDnKzO-sQ8"


LAUNCHERS = [
    {
        "label": "Deep",
        "icon": "/usr/share/icons/Papirus-Dark/16x16/actions/media-playlist-shuffle.svg",
        "command": "shuffle",
    },
    {
        "label": "House",
        "icon": "/usr/share/icons/Papirus-Dark/16x16/actions/media-playlist-shuffle.svg",
        "command": "shuffle",
    },
    {
        "label": "Chill",
        "icon": "/usr/share/icons/Papirus-Dark/16x16/actions/media-playlist-shuffle.svg",
        "command": "shuffle",
    },
    {
        "label": "Classic",
        "icon": "/usr/share/icons/Papirus-Dark/16x16/actions/media-playlist-shuffle.svg",
        "command": "shuffle",
    },
    {
        "sep": True,
    },
    {
        "label": "Exit",
        "icon": None,
        "command": "quit",
    },
]

APPINDICATOR_ID = 'mk-tray'


class IconoTray:
    def __init__(self, appid, iconname):
        self.menu = gtk.Menu()
        self.ind = appindicator.Indicator.new(appid, iconname, appindicator.IndicatorCategory.APPLICATION_STATUS)
        self.ind.set_status (appindicator.IndicatorStatus.ACTIVE)
        self.ind.set_menu(self.menu)
        self.ind.set_title('Music for work')
        # print(dir(self.ind))
        # notify.init(APPINDICATOR_ID)
        # notify.Notification.new(appid, "started", None).show()

    def add_menu_item(self, label=None, icon=None, command=None, sep=False):
        if sep :
            item = gtk.SeparatorMenuItem()
        elif icon == None :
            item = gtk.MenuItem()
            item.set_label(label)
        else :
            img = gtk.Image()
            img.set_from_file(icon)
            item = gtk.ImageMenuItem(label=label)
            item.set_image(img)
        if command != None :
            item.connect("activate", getattr(self, command))
        self.menu.append(item)
        self.menu.show_all()


    def shuffle(self, source):
        selected = source.get_label()
        self.kill()
        os.system("mpv " + globals()[selected] + " --no-video --shuffle --start=$((RANDOM%100)) --audio-display=no --force-window=no --really-quiet >/dev/null 2>&1 &")
        self.ind.set_title(selected)
        return

    def kill(self):
        os.system("if [ '$(ps -o ppid= -C mpv)' ]; then ps -ef | awk '/[-]-no-video/{print $2}' | xargs kill -9 >/dev/null 2>&1; fi")

    def quit(self, source):
        self.kill()
        gtk.main_quit()


def re_start(app):
    app.shuffle(None)


def main():
    os.system("mpv " + Deep + " --no-video --shuffle --start=$((RANDOM%100)) --audio-display=no --force-window=no --really-quiet >/dev/null 2>&1 &")
    app = IconoTray(APPINDICATOR_ID, "google-music-manager-panel")
    for launcher in LAUNCHERS:
        app.add_menu_item(**launcher)
    glib.timeout_add(1000*60*10, re_start, app)
    gtk.main()

if __name__ == "__main__":
    main()



