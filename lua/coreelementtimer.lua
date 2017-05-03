core:module("CoreElementTimer")
core:import("CoreMissionScriptElement")
ElementTimer = ElementTimer or class(CoreMissionScriptElement.MissionScriptElement)

local CookFaster = _G.CookFaster or {}

if not CookFaster or not CookFaster.settings then
	return
end

if not Global.game_settings or (Global.game_settings.level_id ~= "rat" and Global.game_settings.level_id ~= "alex_1") then
	return
end

function ElementTimer:timer_operation_reset()
	local _time = self:value("timer")
	if (self._id == 102164 or self._id == 102166 or self._id == 102177 or self._id == 102178) and CookFaster.settings.Bile_Coming then
		_time = 1
	end
	self._timer = self:get_random_table_value_float(_time)
	self:_update_digital_guis_timer()
end