# -*- coding: utf-8 -*-

import locale
import platform

from i3pystatus import Status

locale.setlocale(locale.LC_TIME, ('pl_PL', 'UTF-8'))

is_laptop = platform.node() == 'laptop'

status = Status(standalone=True)

status.register("clock",
                format="⌚ %a, %-d %b %Y, %X")

status.register("load",
                format="☢ {avg1} {avg5}")

status.register("temp",
                format="⌘ {temp:.0f}°C")

status.register("battery",
                format="⚡ {percentage:.2f}% [{remaining:%E%hh:%Mm} ]{status}",
                alert=True,
                alert_percentage=5,
                status={
                    'DIS': '↓',
                    'CHR': '↑',
                    'FULL': '=',
                })

if not is_laptop:
    # FIXME: change to dhcpcd
    status.register("runwatch",
                    name="DHCP",
                    path="/var/run/dhclient*.pid")

if is_laptop:
    status.register("wireless",
                    interface="wlan0",
                    format_up=" {essid} {quality:03.0f}%",
                    format_down=" {interface} down")

status.register("alsa",
                format="{muted} {volume}%",
                muted="",
                unmuted="")

siedlce_location_code = "PLXX0028"
warsaw_location_code = "PLMA1493"
location_code = siedlce_location_code if is_laptop else warsaw_location_code
status.register("weather",
                format="☀ {current_temp}",
                location_code=location_code)

status.register("mpd",
                format="{status} [{artist} - {title}]",
                status={
                    "pause": "▷",
                    "play": "▶",
                    "stop": "◾",
                })

status.run()
