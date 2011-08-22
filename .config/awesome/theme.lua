---------------------------
-- Default awesome theme --
---------------------------

theme = {}
 
theme.font = "terminus 9"

--[[ more old colors
theme.bg_normal = "#131313"
theme.bg_focus = "#131313"
theme.bg_urgent = "#131313"

theme.fg_light = "#E8E8E8"
theme.fg_normal = "#C1C1C1"
theme.fg_focus = "#6b99ef"
theme.fg_urgent = "#C00000"
 
theme.border_width = "1"
theme.border_normal = "#1C1C1C"
theme.border_focus = "#909090"
theme.border_marked = "#CD2121"
theme.bg_widget = "#131313"
--]]

--[[ less old colors
theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "3"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"
--]]

theme.bg_normal     = "#222222"
theme.bg_focus      = "#4c4c4c"
theme.bg_urgent     = "#d23d3d"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "3"
theme.border_normal = "#303030"
theme.border_focus  = "#e84f4f"
theme.border_marked = "#ffffff"

-- There are another variables sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- Example:
--taglist_bg_focus = #ff0000

-- Display the taglist squares
theme.taglist_squares_sel = "/usr/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = "/usr/share/awesome/themes/default/taglist/squarew.png"

theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"

-- Variables set for theming menu
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = "/usr/share/awesome/themes/default/submenu.png"
theme.menu_height   = "15"
theme.menu_width    = "100"

-- Define the image to load
theme.titlebar_close_button_normal = "/usr/share/awesome/themes/default/titlebar/close_normal.png"
theme.titlebar_close_button_focus = "/usr/share/awesome/themes/default/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = "/usr/share/awesome/themes/default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = "/usr/share/awesome/themes/default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = "/usr/share/awesome/themes/default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = "/usr/share/awesome/themes/default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = "/usr/share/awesome/themes/default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = "/usr/share/awesome/themes/default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = "/usr/share/awesome/themes/default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = "/usr/share/awesome/themes/default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = "/usr/share/awesome/themes/default/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper_cmd = { "feh --bg-scale /home/lukasz/Obrazy/wallpaper-706217.jpg" }

-- You can use your own layout icons like this:
--[[
theme.layout_fairh = "/usr/share/awesome/themes/zenburn/layouts/fairh.png"
theme.layout_fairv = "/usr/share/awesome/themes/zenburn/layouts/fairv.png"
theme.layout_floating = "/usr/share/awesome/themes/zenburn/layouts/floating.png"
theme.layout_magnifier = "/usr/share/awesome/themes/zenburn/layouts/magnifier.png"
theme.layout_max = "/usr/share/awesome/themes/zenburn/layouts/max.png"
theme.layout_fullscreen = "/usr/share/awesome/themes/zenburn/layouts/fullscreen.png"
theme.layout_tilebottom = "/usr/share/awesome/themes/zenburn/layouts/tilebottom.png"
theme.layout_tileleft = "/usr/share/awesome/themes/zenburn/layouts/tileleft.png"
theme.layout_tile = "/usr/share/awesome/themes/zenburn/layouts/tile.png"
theme.layout_tiletop = "/usr/share/awesome/themes/zenburn/layouts/tiletop.png"
--]]

theme.layout_fairh = "/home/lukasz/.config/awesome/layouts/fairh.png"
theme.layout_fairv = "/home/lukasz/.config/awesome/layouts/fairv.png"
theme.layout_floating  = "/home/lukasz/.config/awesome/layouts/floating.png"
theme.layout_magnifier = "/home/lukasz/.config/awesome/layouts/magnifier.png"
theme.layout_max = "/home/lukasz/.config/awesome/layouts/max.png"
theme.layout_fullscreen = "/home/lukasz/.config/awesome/layouts/fullscreen.png"
theme.layout_tilebottom = "/home/lukasz/.config/awesome/layouts/tilebottom.png"
theme.layout_tileleft   = "/home/lukasz/.config/awesome/layouts/tileleft.png"
theme.layout_tile = "/home/lukasz/.config/awesome/layouts/tile.png"
theme.layout_tiletop = "/home/lukasz/.config/awesome/layouts/tiletop.png"
theme.layout_spiral  = "/home/lukasz/.config/awesome/layouts/spiral.png"
theme.layout_dwindle = "/home/lukasz/.config/awesome/layouts/dwindle.png"

theme.awesome_icon = "/home/lukasz/.config/awesome/icons/awesome16.png"

-- custom icons
theme.mpd_icon = "/home/lukasz/.config/awesome/icons/music.png"
theme.weather_icon = "/home/lukasz/.config/awesome/icons/temp.png"
theme.date_icon = "/home/lukasz/.config/awesome/icons/time.png"
theme.vol_high_icon = "/home/lukasz/.config/awesome/icons/volume-high.png"
theme.vol_medium_icon = "/home/lukasz/.config/awesome/icons/volume-medium.png"
theme.vol_low_icon = "/home/lukasz/.config/awesome/icons/volume-low.png"
theme.vol_off_icon = "/home/lukasz/.config/awesome/icons/volume-off.png"
theme.vol_muted_icon = "/home/lukasz/.config/awesome/icons/volume-muted.png"

return theme
