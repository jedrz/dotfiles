#!/usr/bin/env python
# -*- coding: utf-8 -*-

import locale
import platform
import os.path

from feeddzen.manager import Manager
from feeddzen.plugins import *


locale.setlocale(locale.LC_TIME, ('pl_PL', 'UTF-8'))

is_laptop = platform.node() == 'laptop'

# Icons
icon_path = os.path.expanduser('~/.xbm-icons')
def create_icons_dict(**kwds):
    d = {icon_short: StaticWidget('^i({}) '.format(os.path.join(icon_path, icon_name))) \
             for icon_short, icon_name in kwds.items()}
    return d

icons = create_icons_dict(bat='bat_full_01.xbm',
                          clock='clock.xbm',
                          alsa='spkr_01.xbm',
                          mpd='play.xbm')

# Create widgets.
sep = StaticWidget(' << ')

clock = ClockWidget(
    60,
    '%a, %d %b %Y, %H:%M')

alsa = AlsaWidget(
    120 if is_laptop else 31,
    '{volume} [{state}]')

if is_laptop:
    bat = BatteryWidget(
        39,
        '{percentage}',
        '{percentage} [{hours}:{minutes}:{seconds}]',
        '{percentage} [{hours}:{minutes}:{seconds}]')

mpd = MPDWidgetMPC(
    30,
    '%artist% - %title%',
    'stop')

# The first item will be placed at left side.
if is_laptop:
    widgets = [
        icons['bat'], bat, sep,
        icons['alsa'], alsa, sep,
        icons['clock'], clock
    ]
else:
    widgets = [
        icons['mpd'], mpd, sep,
        icons['alsa'], alsa, sep,
        icons['clock'], clock
    ]

# x pos - to see workspaces
x = 200

if is_laptop:
    w = 1366 - x * 2
else:
    w = 1920 - x * 2

font = 'Terminus-9'

dzen_command = 'dzen2 -bg #000 -y 2 -x {} -w {} -fn {}'.format(x, w, font)

manager = Manager(widgets, dzen_command)
manager.start()
