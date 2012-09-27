#!/usr/bin/env python
# -*- coding: utf-8 -*-

import locale
import platform

from feeddzen.manager import Manager
from feeddzen.plugins import *


locale.setlocale(locale.LC_TIME, ('pl_PL', 'UTF-8'))

is_laptop = platform.node() == 'laptop'

# Create widgets.
sep = StaticWidget(' << ')

clock = ClockWidget(
    60,
    '%a, %d %b %Y, %H:%M')

alsa = AlsaWidget(
    120 if is_laptop else 31,
    'Vol: {volume} [{state}]')

if is_laptop:
    bat = BatteryWidget(
        39,
        'BAT: {percentage}',
        'BAT: {percentage} [{hours}:{minutes}:{seconds}]',
        'BAT: {percentage} [{hours}:{minutes}:{seconds}]')

mpd = MPDWidgetMPC(
    30,
    'MPD: %artist% - %title%',
    'MPD: stop')

# The first item will be placed at left side.
if is_laptop:
    widgets = [
        bat, sep,
        volume, sep,
        clock
    ]
else:
    widgets = [
        mpd, sep,
        alsa, sep,
        clock
    ]

# x pos - to see workspaces
x = 200

if is_laptop:
    w = 1366 - x * 2
else:
    w = 1920 - x * 2

dzen_command = 'dzen2 -bg #000 -x {} -w {}'.format(x, w)

manager = Manager(widgets, dzen_command)
manager.start()
