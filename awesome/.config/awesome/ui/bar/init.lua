local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local lain = require("lain")
-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

local batwidget = lain.widget.bat({
	battery = "BAT1", -- Change this to match your battery name
	settings = function()
		if bat_now.status == "Discharging" then
			widget:set_markup("󰂂 " .. bat_now.perc .. "% | ")
		elseif bat_now.status == "Charging" then
			widget:set_markup("󰂄  " .. bat_now.perc .. "% | ")
		else
			widget:set_markup("󰁹 " .. bat_now.perc .. "% | ")
		end
	end,
})

-- Alsa widget
local alsa_widget = lain.widget.alsa({
	settings = function()
		widget:set_markup(" 󰖀 " .. volume_now.level .. "% | ")
	end,
})

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t)
		t:view_only()
	end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t)
		awful.tag.viewnext(t.screen)
	end),
	awful.button({}, 5, function(t)
		awful.tag.viewprev(t.screen)
	end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create a text widget
my_current_app = wibox.widget.textbox()

-- Function to update the widget with the current window title
local function update_current_app()
	local c = client.focus
	if c then
		if c.class == "kitty" then
			my_current_app.text = c.name or ""
		else
			my_current_app.text = c.class or ""
		end
	else
		my_current_app.text = ""
	end
end

-- Connect to the 'property::name' signal to update the widget when the window changes
client.connect_signal("property::name", update_current_app)

-- Connect to the 'focus' signal to update the widget when focus changes
client.connect_signal("focus", update_current_app)
client.connect_signal("unfocus", update_current_app)

-- Initial update
update_current_app()

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	s.systray = wibox.widget.systray()
	s.systray.visible = false

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons,
	})

	-- Create a tasklist widget
	s.mytasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
	})

	-- Create the wibox
	s.mywibox = awful.wibar({
		position = "top",
		screen = s,
		width = s.geometry.width,
	})

	-- Add widgets to the wibox
	s.mywibox:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			s.mytaglist,
			s.mypromptbox,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			-- s.mytasklist, -- Middle widget
			my_current_app,
		},
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- mykeyboardlayout,
			batwidget,
			mytextclock,
			alsa_widget,
			s.mylayoutbox,
			s.systray,
		},
	})
end)
-- }}}
