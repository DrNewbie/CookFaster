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

local _f_MissionScriptElement_on_executed = MissionScriptElement.on_executed

function MissionScriptElement:on_executed(instigator, alternative, skip_execute_on_executed)
	local _id = tostring(self._id)
	if _id == "100724" then
		local element = self:get_mission_element(100494)
		CookFaster:DelayScript(self, element, instigator, CookFaster.settings.Delay)
		return
	end
	if _id == "102197" and CookFaster.settings.Bile_Coming then	
		local element = self:get_mission_element(102263)
		CookFaster:DelayScript(self, element, instigator, 1)
	end
	_f_MissionScriptElement_on_executed(self, instigator, alternative, skip_execute_on_executed)
end