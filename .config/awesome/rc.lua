-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")

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
    awful.layout.suit.floating
}

-- Autorun programs
autorun = true

autorun_apps = 
{
    "kadu",
    "mpd",
    "mpdscribble",
    "dropboxd"
}
-- }}}

-- {{{ Functions
function mail ()
    mailwidget.text = " " .. awful.util.pread("/home/lukasz/Skrypty/check_gmail.sh")
end

function weather ()
    weatherwidget.text = " " .. awful.util.pread("python2 /home/lukasz/Skrypty/weather.py")
end

function date ()
    datewidget.text = " " .. awful.util.pread("date +'%a, %d %b %Y, %H:%M'")
end

function volume (mode)
    if mode == "up" then
        awful.util.spawn("ossvol -i 4")
    elseif mode == "down" then
        awful.util.spawn("ossvol -d 4")
    elseif mode == "mute" then
        awful.util.spawn("ossvol -t")
    end
    local volume = awful.util.pread("ossvol -v")
    volume = tonumber(volume)
	if volume == 0 then
        volume = " MUTE"
    else
        volume = volume * 4
        volume = " " .. volume .. "%"
    end
    volwidget.text = volume
end

function rss ()
    rsswidget.text = " " .. awful.util.pread("/home/lukasz/Skrypty/conkyGoogleReader.sh")
end

function mpd ()
    mpdwidget.text = " " .. awful.util.pread("/home/lukasz/Skrypty/mpd-notify.sh")
end

function quit ()
    awful.util.spawn("killall mpd mpdscribble")
    awesome.quit()
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    --tags[s] = awful.tag({ 1, 2, 3, 4, 5 }, s, layouts[1])
    tags[s] = awful.tag({ "⌘", "⌥", "✇", "⌤", "☭" }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
mymainmenu = awful.menu({ items = { { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
                                    { "res network", "sudo rc.d restart network" },
                                    { "restart", awesome.restart },
                                    { "quit", quit },
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

mailwidget = widget({ type = "textbox" })
mailwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function ()
        awful.util.spawn("firefox gmail.com")
    end),
    awful.button({ }, 3, mail)
))
mailicon = widget({ type = "imagebox" })
mailicon.image = image(beautiful.mail_icon)

weatherwidget = widget({ type = "textbox" })
weatherwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, weather)
))
weathericon = widget({ type = "imagebox" })
weathericon.image = image(beautiful.weather_icon)

volwidget = widget({ type = "textbox" })
volwidget:buttons(awful.util.table.join(
    awful.button({ }, 4, function () volume("up") end),
    awful.button({ }, 5, function () volume("down") end),
    awful.button({ }, 1, function () volume("mute") end)
))
volicon = widget({ type = "imagebox" })
volicon.image = image(beautiful.vol_icon)

rsswidget = widget({ type = "textbox" })
rsswidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () 
        awful.util.spawn("firefox reader.google.pl")
    end),
    awful.button({ }, 3, rss)
))
rssicon = widget({ type = "imagebox" })
rssicon.image = image(beautiful.rss_icon)

mpdwidget = widget({ type = "textbox" })
mpdwidget:buttons(awful.util.table.join(
    awful.button({ }, 1, mpd)
))
mpdicon = widget({ type = "imagebox" })
mpdicon.image = image(beautiful.mpd_icon)

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
            myseparator,
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and mysystray or nil,
        myseparator,
        datewidget,
        dateicon,
        myseparator,
        volwidget,
        volicon,
        myseparator,
        weatherwidget,
        weathericon,
        myseparator,
        mailwidget,
        mailicon,
        myseparator,
        rsswidget,
        rssicon,
        myseparator,
        mpdwidget,
        mpdicon,
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
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey, "Shift"   }, "q", quit),

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
    awful.key({ modkey, "Shift"   }, "Delete", function () awful.util.spawn("sudo poweroff") end),
    awful.key({ modkey,           }, "p",     function () awful.util.spawn("pcmanfm")    end),
    awful.key({ modkey,           }, "i",     function () awful.util.spawn("firefox")   end),
    awful.key({ modkey,           }, "a",     function () awful.util.spawn("anki")      end),
    awful.key({ modkey,           }, "c",     function () awful.util.spawn(terminal .. " -e ncmpcpp") end),
    -- extra keyboard keys
    awful.key({ }, "XF86AudioRaiseVolume",    function () volume("up")                  end),
    awful.key({ }, "XF86AudioLowerVolume",    function () volume("down")                end),
    awful.key({ }, "XF86AudioMute",           function () volume("mute")                end),
    awful.key({ }, "XF86AudioNext",           function () awful.util.spawn("mpc next")  end),
    awful.key({ }, "XF86AudioPrev",           function () awful.util.spawn("mpc prev")  end),
    awful.key({ }, "XF86AudioPlay",           function ()
                                                  local s = awful.util.pread("mpc")
                                                  if string.find(s, "%[playing%]") then
                                                      awful.util.spawn("mpc pause")
                                                  else
                                                      awful.util.spawn("mpc play")
                                                  end
                                              end),
    awful.key({ }, "XF86AudioStop",           function () awful.util.spawn("mpc stop")  end)
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
    { rule = { class = "Gimp" },
      properties = { floating = true },
      callback = awful.titlebar.add },
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
-- }}}

-- {{{ Timers
-- date
datetimer = timer { timeout = 53 }
datetimer:add_signal("timeout", date)
datetimer:start()

-- weather
weathertimer = timer { timeout = 4637 }
weathertimer:add_signal("timeout", weather)
weathertimer:start()

-- mpd
mpdtimer = timer { timeout = 37 }
mpdtimer:add_signal("timeout", mpd)
mpdtimer:start()

-- rss
rsstimer = timer { timeout = 3863 }
rsstimer:add_signal("timeout", rss)
rsstimer:start()
-- }}}

-- {{{ Run functions
date()
mail()
weather()
volume("update")
mpd()
rss()
-- }}}

-- {{{ Run apps in table autorun_apps
if autorun then
   for i, app in ipairs(autorun_apps) do
       awful.util.spawn(app)
   end
end
-- }}}
