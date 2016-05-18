core:module("CoreMissionScriptElement")
core:import("CoreXml")
core:import("CoreCode")
core:import("CoreClass")

local CookFaster = _G.CookFaster or {}

if not CookFaster then
	return
end

local _f_MissionScriptElement_on_executed = MissionScriptElement.on_executed

function MissionScriptElement:on_executed(instigator, alternative, skip_execute_on_executed)
	local _id = tostring(self._id)
	if Global.game_settings then
		if Global.game_settings.level_id == "rat" or Global.game_settings.level_id == "alex_1" then
			if _id == "100724" then
				local element = self:get_mission_element(100494)
				CookFaster:DelayScript(self, element, instigator)
				return
			end
		end
	end
	_f_MissionScriptElement_on_executed(self, instigator, alternative, skip_execute_on_executed)
end