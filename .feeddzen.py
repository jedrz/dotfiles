#!/usr/bin/env python
# -*- coding: utf-8 -*-

import locale
import platform
import os.path
import time

from feeddzen.manager import Manager
from feeddzen.plugins import *


locale.setlocale(locale.LC_TIME, ('pl_PL', 'UTF-8'))

is_laptop = platform.node() == 'laptop'

# Icons
icon_path = os.path.expanduser('~/.xbm-icons')
def create_icons_dict(**kwds):
    d = {icon_short: core.StaticWidget('^i({}) '.format(
                os.path.join(icon_path, icon_name))) \
             for icon_short, icon_name in kwds.items()}
    return d

icons = create_icons_dict(bat='bat_full_01.xbm',
                          clock='clock.xbm',
                          vol='spkr_01.xbm',
                          mpd='play.xbm')

# Create widgets.
sep = core.StaticWidget(' << ')

def clock_f():
    return time.strftime('%a, %d %b %Y, %H:%M')
clock_w = core.Widget(60, clock_f)

def vol_f(volume, muted):
    state = 'off' if muted else 'on'
    return '{}% [{}]'.format(volume, state)
vol_w = volume.AlsaWidget(97 if is_laptop else 31, vol_f)

if is_laptop:
    def bat_f(state, d):
        if state == 'charging':
            return '{percentage}% [{hours}:{minutes}]'.format(**d)
        elif state == 'discharging':
            return '{percentage}% [{hours}:{minutes}]'.format(**d)
        else:
            return '{percentage}%'.format(**d)
    bat_w = battery.BatteryWidget(67, bat_f)

if not is_laptop:
    def mpd_f(playing, d):
        if playing:
            return '{artist} - {title}'.format(**d)
        else:
            return 'stop'
    mpd_w = mpd.MPDWidgetMPC(37, mpd_f)

# The first item will be placed at left side.
if is_laptop:
    widgets = [
        icons['bat'], bat_w, sep,
        icons['vol'], vol_w, sep,
        icons['clock'], clock_w
    ]
else:
    widgets = [
        icons['mpd'], mpd_w, sep,
        icons['vol'], vol_w, sep,
        icons['clock'], clock_w
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
