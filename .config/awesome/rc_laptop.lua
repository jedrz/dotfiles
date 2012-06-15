-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

require("vicious")

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
theme_path = awful.util.getdir("config") .. "/theme.lua"
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = "gvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
}

-- Autorun programs
autorun = true
autorun_apps = 
{
    "pidgin",
    "mpd",
    "mpdscribble",
    "dropboxd"
}
-- }}}

-- {{{ Functions
function date()
    datewidget.text = " " .. awful.util.pread("date +'%a, %d %b %Y, %H:%M'")
end

function weather()
    weatherwidget.text = " " .. awful.util.pread("python2 /home/lukasz/Skrypty/weather")
end

-- volume notifications
function volume_get_icon()
    local status = awful.util.pread("amixer get Master")
    local volume = tonumber(status:match("%[(%d+)%%%]"))
    local is_muted = status:find("%[off%]")

    if is_muted then
        return beautiful.vol_muted_icon
    elseif volume > 70 then
        return beautiful.vol_high_icon
    elseif volume > 30 then
        return beautiful.vol_medium_icon
    elseif volume > 0 then
        return beautiful.vol_low_icon
    else
        return beautiful.vol_off_icon
    end
end

local volume_notification = nil

function volume_notify(volume)
    local img = image.argb32(200, 50, nil)
    img:draw_rectangle(0, 0, img.width, img.height, true, beautiful.bg_normal)
    local vol_icon = image(volume_get_icon())
    img:insert(vol_icon, 0, 1)
    img:draw_rectangle(62, 22, 126 * volume / 100, 6, true, beautiful.fg_normal)

    local id = nil
    if volume_notification then
        id = volume_notification.id
    end
    volume_notification = naughty.notify({
        icon = img,
        replaces_id = id,
        text = "\n" .. string.format("%3d", volume) .. "%",
        font = "DejaVu Sans 10"
    })
end

function volume_adjust(inc)
    if inc > 0 then
        inc = inc .. "%+"
    elseif inc < 0 then
        inc = -inc .. "%-"
    else
        inc = "toggle"
    end
    awful.util.spawn_with_shell("amixer set Master " .. inc)
    local status = awful.util.pread("amixer get Master")
    local volume = status:match("%[(%d+)%%%]")
    local volume = tonumber(volume)
    volume_notify(volume)
end

function volume_up()
    volume_adjust(5)
end

function volume_down()
    volume_adjust(-5)
end

function volume_mute()
    volume_adjust(0)
end

-- brightness notifications
local brightness_notification = nil

function brightness_notify(brightness)
    local img = image.argb32(200, 50, nil)
    img:draw_rectangle(0, 0, img.width, img.height, true, beautiful.bg_normal)
    local brightness_icon = image(beautiful.brightness_icon)
    img:insert(brightness_icon, 0, 1)
    img:draw_rectangle(62, 22, 126 * brightness / 100, 6, true, beautiful.fg_normal)

    local id = nil
    if brightness_notification then
        id = brightness_notification.id
    end
    brightness_notification = naughty.notify({
        icon = img,
        replaces_id = id,
        text = "\n" .. string.format("%3d", brightness) .. "%",
        font = "DejaVu Sans 10"
    })
end

function brightness_adjust(inc)
    --awful.util.spawn_with_shell("xbacklight -inc " .. inc)
    os.execute("xbacklight -inc " .. inc)
    local brightness = awful.util.pread("xbacklight")
    brightness = tonumber(brightness)
    brightness_notify(brightness)
end

function brightness_up()
    brightness_adjust(10)
end

function brightness_down()
    brightness_adjust(-10)
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    --tags[s] = awful.tag({ "ℵ", "⌥", "♐", "⌤", "♓" }, s, layouts[1])
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
mymainmenu = awful.menu({ items = { { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc_laptop.lua" },
                                    { "restart", awesome.restart },
                                    { "quit", awesome.quit },
                                    { "reboot", "sudo reboot" },
                                    { "poweroff", "sudo poweroff" } }
                        })

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mymainmenu })
-- }}}

-- {{{ Wibox
myseparator = widget({ type = "textbox" })
myseparator.text = " | "

datewidget = widget({ type = "textbox" })
dateicon = widget({ type = "imagebox" })
dateicon.image = image(beautiful.date_icon)

weatherwidget = widget({ type = "textbox" })
weatherwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, weather)
))
weathericon = widget({ type = "imagebox" })
weathericon.image = image(beautiful.weather_icon)

batwidget = widget({ type = "textbox" })
vicious.register(batwidget, vicious.widgets.bat, "$1 $2% [$3]", 67, "BAT0")

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = "14" })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mylayoutbox[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and mysystray or nil,
        myseparator,
        datewidget,
        dateicon,
        myseparator,
        weatherwidget,
        weathericon,
        myseparator,
        batwidget,
        myseparator,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),

    -- my keybindigs
    awful.key({ modkey, "Shift"   }, "Delete", function () awful.util.spawn_with_shell("sudo poweroff") end),
    --awful.key({ modkey,           }, "p",     function () awful.util.spawn("pcmanfm")   end),
    awful.key({ modkey,           }, "p",     function () awful.util.spawn(terminal .. " -e ranger") end),
    awful.key({ modkey,           }, "i",     function () awful.util.spawn("firefox")    end),
    awful.key({ modkey,           }, "a",     function () awful.util.spawn("anki")      end),
    awful.key({ modkey,           }, "c",     function () awful.util.spawn(terminal .. " -e ncmpcpp") end),
    awful.key({ modkey, "Control" }, "c",     function ()
                                                  awful.prompt.run({ prompt = "Calculate: " },
                                                  mypromptbox[mouse.screen].widget,
                                                  function (expr)
                                                      local msg = awful.util.pread("python -c \"from math import *;print(" .. expr .. ")\"")
                                                      msg = msg:gsub("\n", "")
                                                      naughty.notify({
                                                          text = msg,
                                                          timeout = 7,
                                                          position = "top_left"
                                                      })
                                                  end)
                                              end),
    awful.key({ modkey, "Shift"  }, "t",      function () awful.util.spawn_with_shell("/home/lukasz/Skrypty/touchpad-toggle") end),
    -- extra keyboard keys
    awful.key({ }, "XF86AudioRaiseVolume",    volume_up                                    ),
    awful.key({ }, "XF86AudioLowerVolume",    volume_down                                  ),
    awful.key({ }, "XF86AudioMute",           volume_mute                                  ),
    awful.key({ }, "XF86AudioNext",           function () awful.util.spawn_with_shell("mpc next") end),
    awful.key({ }, "XF86AudioPrev",           function () awful.util.spawn_with_shell("mpc prev") end),
    awful.key({ }, "XF86AudioPlay",           function ()
                                                  local s = awful.util.pread("mpc")
                                                  if s:find("%[playing%]") then
                                                      awful.util.spawn_with_shell("mpc pause")
                                                  else
                                                      awful.util.spawn_with_shell("mpc play")
                                                  end
                                              end),
    awful.key({ }, "XF86ScreenSaver",         function () awful.util.spawn("xscreensaver-command -lock") end),
    awful.key({ }, "XF86Sleep",               function () awful.util.spawn_with_shell("sudo pm-suspend") end),
    awful.key({ }, "XF86MonBrightnessDown",   brightness_down                              ),
    awful.key({ }, "XF86MonBrightnessUp",     brightness_up                                ),
    awful.key({ }, "XF86Battery",             function ()
                                                  naughty.notify({
                                                      text = awful.util.pread("acpi -i"),
                                                      timeout = 15
                                                  })
                                              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
  
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false } },
    --[[{ rule = { class = "Gimp" },
      properties = { floating = true },
      callback = awful.titlebar.add },]]
    { rule = { class = "Kadu" },
      properties = { floating = true },
      callback = awful.titlebar.add },
    { rule = { class = "Skype" },
      properties = { floating = true },
      callback = awful.titlebar.add }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- to kill some apps during exit
awesome.add_signal("exit", function () awful.util.spawn_with_shell("killall mpdscribble") end)
-- }}}

-- {{{ Timers
-- date
datetimer = timer { timeout = 60 }
datetimer:add_signal("timeout", date)
datetimer:start()

weathertimer = timer { timeout = "7177" }
weathertimer:add_signal("timeout", weather)
weathertimer:start()
-- }}}

-- {{{ Run functions
date()
weather()
-- }}}

-- {{{ Run apps from autorun_apps
if autorun then
   for _, app in ipairs(autorun_apps) do
       awful.util.spawn(app)
   end
end
-- }}}
