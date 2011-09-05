-- Global variables for luakit
globals = {
    homepage            = "http://gazeta.pl",
    scroll_step         = 100,
    zoom_step           = 0.1,
    max_cmd_history     = 100,
    max_srch_history    = 100,
    default_window_size = "800x600",
    term = "urxvt"

 -- Disables loading of hostnames from /etc/hosts (for large host files)
 -- load_etc_hosts      = false,
 -- Disables checking if a filepath exists in search_open function
 -- check_filepath      = false,
}

-- Make useragent
--[[
local arch = string.match(({luakit.spawn_sync("uname -sm")})[2], "([^\n]*)")
local lkv  = string.format("luakit/%s", luakit.version)
local wkv  = string.format("WebKitGTK+/%d.%d.%d", luakit.webkit_major_version, luakit.webkit_minor_version, luakit.webkit_micro_version)
local awkv = string.format("AppleWebKit/%s.%s+", luakit.webkit_user_agent_major_version, luakit.webkit_user_agent_minor_version)
globals.useragent = string.format("Mozilla/5.0 (%s) %s %s %s", arch, awkv, wkv, lkv)
--]]
globals.useragent = "Mozilla/5.0 (X11; U; Linux i686; pl; rv:5.0) Gecko/20100101 Firefox/5.0"

-- Search common locations for a ca file which is used for ssl connection validation.
local ca_files = {
    -- $XDG_DATA_HOME/luakit/ca-certificates.crt
    luakit.data_dir .. "/ca-certificates.crt",
    "/etc/certs/ca-certificates.crt",
    "/etc/ssl/certs/ca-certificates.crt",
}
-- Use the first ca-file found
for _, ca_file in ipairs(ca_files) do
    if os.exists(ca_file) then
        soup.set_property("ssl-ca-file", ca_file)
        break
    end
end

-- Change to stop navigation sites with invalid or expired ssl certificates
soup.set_property("ssl-strict", false)

-- Set cookie acceptance policy
cookie_policy = { always = 0, never = 1, no_third_party = 2 }
soup.set_property("accept-policy", cookie_policy.no_third_party)

-- List of search engines. Each item must contain a single %s which is
-- replaced by URI encoded search terms. All other occurances of the percent
-- character (%) may need to be escaped by placing another % before or after
-- it to avoid collisions with lua's string.format characters.
-- See: http://www.lua.org/manual/5.1/manual.html#pdf-string.format
search_engines = {
    g = "http://google.pl/search?q=%s",
    w = "http://pl.wikipedia.org/wiki/Special:Search?search=%s",
    y = "http://youtube.com/results?search_query=%s",
    a = "https://wiki.archlinux.org/index.php?title=Special:Search&search=%s",
    b = "http://google.pl/search?q=site:bbs.archlinux.org %s",
    p = "http://google.pl/search?q=site:peb.pl %s",
    bt = "http://btjunkie.org/search?q=%s",
    al = "http://allegro.pl/listing.php/search?string=%s",
    luakit_s = "http://luakit.org/search/index/luakit?q=%s"
}

-- Set google as fallback search engine
search_engines.default = search_engines.g
-- Use this instead to disable auto-searching
--search_engines.default = "%s"

-- Per-domain webview properties
-- See http://webkitgtk.org/reference/webkitgtk-WebKitWebSettings.html
--[[ domain_props = {
    ["all"] = {
        ["enable-scripts"]          = false,
        ["enable-plugins"]          = false,
        ["enable-private-browsing"] = false,
        ["user-stylesheet-uri"]     = "",
    },
    ["youtube.com"] = {
        ["enable-scripts"] = true,
        ["enable-plugins"] = true,
    },
    ["bbs.archlinux.org"] = {
        ["user-stylesheet-uri"]     = "file://" .. luakit.data_dir .. "/styles/dark.css",
        ["enable-private-browsing"] = true,
    },
} --]]

domain_props = {
    ["all"] = {
        ["user-stylesheet-uri"] = "file://" .. luakit.data_dir .. "/styles/fonts.css"
    }
}

-- vim: et:sw=4:ts=8:sts=4:tw=80
