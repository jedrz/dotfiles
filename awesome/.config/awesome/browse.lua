-- Modified: https://github.com/mikar/awesome-config/blob/ebdb1275f1f33d1197e9797bc23d78c2a31f1133/vain/layout/browse.lua

-- Grab environment.
local ipairs = ipairs
local tonumber = tonumber
local beautiful = beautiful
local awful = awful

module("browse")

name = "browse"
function arrange(p)

    -- Layout with one fixed column meant for the browser window. Its
    -- width is calculated according to mwfact. Other clients are
    -- stacked vertically in a slave column on the right.

    --       (1)              (2)              (3)              (4)
    --   +-----+---+      +-----+---+      +-----+---+      +-----+---+
    --   |     |   |      |     |   |      |     | 3 |      |     | 4 |
    --   |     |   |      |     |   |      |     |   |      |     +---+
    --   |  1  |   |  ->  |  1  | 2 |  ->  |  1  +---+  ->  |  1  | 3 |
    --   |     |   |      |     |   |      |     | 2 |      |     +---+
    --   |     |   |      |     |   |      |     |   |      |     | 2 |
    --   +-----+---+      +-----+---+      +-----+---+      +-----+---+

    -- Screen.
    local wa = p.workarea
    local cls = p.clients

    -- Width of main column?
    local t = awful.tag.selected(p.screen)
    local mwfact = awful.tag.getmwfact(t)

    if #cls > 0
    then
        -- Main column, fixed width and height.
        local c = cls[#cls]
        local g = {}
        local mainwid = wa.width * mwfact
        local slavewid = wa.width - mainwid

        g.height = wa.height
        g.width = mainwid
        g.x = wa.x
        g.y = wa.y
        c:geometry(g)

        -- Remaining clients stacked in slave column, new ones on top.
        if #cls > 1
        then
            local slavehei = wa.height / (#cls - 1)
            for i = (#cls - 1), 1, -1
            do
                c = cls[i]
                g = {}
                g.width = slavewid
                g.height = slavehei
                g.x = wa.x + mainwid
                g.y = wa.y + (i - 1) * slavehei
                c:geometry(g)
            end
        end
    end
end
