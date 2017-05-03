core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

local CookFaster = _G.CookFaster or {}

if not CookFaster or not CookFaster.settings then
	return
end

if not Global.game_settings or (Global.game_settings.level_id ~= "rat" and Global.game_settings.level_id ~= "alex_1") then
	return
end

function MissionScriptElement:_calc_base_delay()
	if self._id == 102197 and CookFaster.settings.Bile_Coming then
		return 1
	end
	if not self._values.base_delay_rand then
		return self._values.base_delay
	end
	return self._values.base_delay + math.rand(self._values.base_delay_rand)
end

function MissionScriptElement:_calc_element_delay(params)
	if self._id == 100724 then
		return CookFaster.settings.Delay
	end
	if not params.delay_rand then
		return params.delay
	end
	return params.delay + math.rand(params.delay_rand)
end