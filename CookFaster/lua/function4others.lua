_G.CookFaster = _G.CookFaster or {}
CookFaster.options_menu = "CookFaster_menu"
CookFaster.ModPath = ModPath
CookFaster.SaveFile = CookFaster.SaveFile or SavePath .. "CookFaster.txt"
CookFaster.ModOptions = CookFaster.ModPath .. "menus/modoptions.txt"
CookFaster.settings = CookFaster.settings or {}

function CookFaster:Reset()
	self.settings = {
		Delay = 1,
		Bile_Coming = true,
	}
	self:Save()
end

function CookFaster:Load()
	local file = io.open(self.SaveFile, "r")
	if file then
		for key, value in pairs(json.decode(file:read("*all"))) do
			self.settings[key] = value
		end
		file:close()
	else
		self:Reset()
	end
end

function CookFaster:Save()
	local file = io.open(self.SaveFile, "w+")
	if file then
		file:write(json.encode(self.settings))
		file:close()
	end
end

CookFaster:Load()

Hooks:Add("LocalizationManagerPostInit", "CookFaster_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["CookFaster_menu_title"] = "Cook Faster",
		["CookFaster_menu_desc"] = "",
		["CookFaster_menu_Delay_title"] = "Time for Next Thing",
		["CookFaster_menu_Delay_desc"] = "",
		["CookFaster_menu_Bile_Coming_title"] = "Faster Bile",
		["CookFaster_menu_Bile_Coming_desc"] = "",
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "CookFasterOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu( CookFaster.options_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "CookFasterOptions", function( menu_manager, nodes )
	MenuCallbackHandler.CookFaster_menu_Delay_callback = function(self, item)
		CookFaster.settings.Delay = math.floor(item:value())
		CookFaster:Save()
	end
	MenuHelper:AddSlider({
		id = "CookFaster_menu_Delay_callback",
		title = "CookFaster_menu_Delay_title",
		callback = "CookFaster_menu_Delay_callback",
		value = CookFaster.settings.Delay,
		min = 1,
		max = 45,
		step = 1,
		show_value = true,
		menu_id = CookFaster.options_menu,  
	})
	MenuCallbackHandler.CookFaster_menu_Bile_Coming_callback = function(self, item)
		CookFaster.settings.Bile_Coming = item:value() == "on" and true or false
		CookFaster:Save()
	end
	MenuHelper:AddToggle({
		id = "CookFaster_menu_Bile_Coming_callback",
		title = "CookFaster_menu_Bile_Coming_title",
		callback = "CookFaster_menu_Bile_Coming_callback",
		value = CookFaster.settings.Bile_Coming,
		menu_id = CookFaster.options_menu,  
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "CookFasterOptions", function(menu_manager, nodes)
	nodes[CookFaster.options_menu] = MenuHelper:BuildMenu( CookFaster.options_menu )
	MenuHelper:AddMenuItem(nodes["blt_options"], CookFaster.options_menu, "CookFaster_menu_title", "CookFaster_menu_desc")
end)
