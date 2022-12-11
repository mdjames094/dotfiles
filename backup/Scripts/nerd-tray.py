#!/usr/bin/env python3

import os
import gi
import sys

gi.require_version("Gtk", "3.0")
gi.require_version("AppIndicator3", "0.1")
gi.require_version('Notify', '0.7')
from gi.repository import Gtk as gtk
from gi.repository import AppIndicator3 as appindicator
# from gi.repository import Notify as notify

LAUNCHERS = [
    {
        "label": "US",
        "icon": "/usr/share/xfce4/xkb/flags/us.svg",
        "command": "setLang",
    },
    {
        "label": "FR",
        "icon": "/usr/share/xfce4/xkb/flags/fr.svg",
        "command": "setLang",
    },
    {
        "sep": True,
    },
    {
        "label": "Stop",
        "icon": None,
        "command": "stopLang",
    },
    {
        "label": "Exit",
        "icon": None,
        "command": "quit",
    },
]

APPINDICATOR_ID = 'nerd-tray'

class IconoTray:
    def __init__(self, appid, iconname):
        self.menu = gtk.Menu()
        self.ind = appindicator.Indicator.new(appid, iconname, appindicator.IndicatorCategory.APPLICATION_STATUS)
        self.ind.set_status (appindicator.IndicatorStatus.ACTIVE)
        self.ind.set_menu(self.menu)
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

    def setLang(self, source):
        current_label = source.get_label()
        os.system("nerd-dictation end")
        os.system("nerd-dictation begin --vosk-model-dir=$HOME/.config/nerd-dictation/model_" + current_label + " &")
        for item in self.menu:
            item.set_sensitive(item.get_label() != current_label)
        self.ind.set_icon('audio-recorder-on')
        return

    def stopLang(self, source):
        os.system("nerd-dictation end")
        for item in self.menu:
            item.set_sensitive(True)
        self.ind.set_icon('notification-microphone-sensitivity-high')
        return

    def selectItem(self, label):
        for item in self.menu:
            if item.get_label() == label:
                self.setLang(item)
        return

    def quit(self, source):
        os.system("nerd-dictation end")
        # notify.Notification.new("nerd-dictation", "stopped.", None).show()
        # notify.uninit()
        gtk.main_quit()

def main():
    app = IconoTray(APPINDICATOR_ID, "notification-microphone-sensitivity-high")
    for launcher in LAUNCHERS:
        app.add_menu_item(**launcher)
    if len(sys.argv) >= 2 :
        app.selectItem(sys.argv[1])
    gtk.main()

if __name__ == "__main__":
    main()



