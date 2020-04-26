core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

if not Global.game_settings then
	return
end

Hooks:PreHook(MissionScriptElement, "_calc_base_delay", "CookFaster_calc_base_delay", function(self)
	local CookFaster = _G.CookFaster or {}
	if not CookFaster or not CookFaster.settings then
	
	else
		if Global.game_settings.level_id == "rat" or Global.game_settings.level_id == "alex_1" or Global.game_settings.level_id == "ratdaylight" then
			if self._id == 102197 and CookFaster.settings.Bile_Coming then
				self._values.base_delay_rand = nil
				self._values.base_delay = 1
			end
		end
	end
end)

Hooks:PreHook(MissionScriptElement, "_calc_element_delay", "CookFaster_calc_element_delay", function(self, params)
	local CookFaster = _G.CookFaster or {}
	if not CookFaster or not CookFaster.settings then
	
	else
		if ((Global.game_settings.level_id == "rat" or Global.game_settings.level_id == "alex_1" or Global.game_settings.level_id == "ratdaylight") and self._id == 100724) or 
			(Global.game_settings.level_id == "mex_cooking" and self._editor_name == "counter_below3") or 
			((Global.game_settings.level_id == "mia_1" or Global.game_settings.level_id == "crojob2") and self._editor_name == "timer_to_next") then
			params.delay_rand = nil
			params.delay = CookFaster.settings.Delay
			return CookFaster.settings.Delay + 0.1
		end
	end
end)