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

LAUNCHERS = [
    {
        "label": "eDP-1",
        "icon": "/usr/share/icons/hicolor/128x128/devices/xfce-display-internal.png",
        "command": "display",
    },
    {
        "label": "HDMI-2",
        "icon": "/usr/share/icons/hicolor/128x128/devices/xfce-display-external.png",
        "command": "display",
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

APPINDICATOR_ID = 'wc-tray'


class IconoTray:
    def __init__(self, appid, iconname):
        self.menu = gtk.Menu()
        self.ind = appindicator.Indicator.new(appid, iconname, appindicator.IndicatorCategory.APPLICATION_STATUS)
        self.ind.set_status (appindicator.IndicatorStatus.ACTIVE)
        self.ind.set_menu(self.menu)
        self.ind.set_title('Wacom tablet\n:' +  LAUNCHERS[0]['label'])
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
        if label == LAUNCHERS[0]['label'] :
            item.set_sensitive(False)
        self.menu.append(item)
        self.menu.show_all()


    def display(self, source):
        selected = source.get_label()
        os.system("mapwacom.sh --device-regex=stylus --screen=" +  selected)
        for item in self.menu:
            item.set_sensitive(item.get_label() != selected)
        self.ind.set_title('Wacom tablet\n:'+selected)
        return

    def quit(self, source):
        gtk.main_quit()


def re_start(app):
    app.display(None)


def main():
    os.popen("mapwacom.sh --device-regex=stylus --screen=" +  LAUNCHERS[0]['label'])
    app = IconoTray(APPINDICATOR_ID, "tabletconnected")
    for launcher in LAUNCHERS:
        app.add_menu_item(**launcher)
    gtk.main()

if __name__ == "__main__":
    main()



