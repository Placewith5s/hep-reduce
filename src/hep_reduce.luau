--!strict
local hep_reduce = {}

local BS: BadgeService = game.BadgeService
local RS = game["Run Service"]


-- used by assert studio functions but can come in handy
function hep_reduce.is_studio(): boolean
	return RS:IsStudio()
end


--[[
default error message for conditions: "false!" 
default error message for other types: "typeof(what) is nil!"
]]
function hep_reduce.assert_studio(what: any, err_msg: string?)
	if hep_reduce.is_studio then
		debug.info(2, "sl")
		
		if type(what) == "boolean" then
			assert(what, err_msg or "false!")
		else
			assert(what, err_msg or typeof(what) .. "is nil!")
		end
	end
end


--[[ Assert studio but for strings, numbers, a certain type of 1D tables, and folders

get_descendants: matters only for folders

INFO: debug message included for little time saving
CAUTION: Does not handle whitespace for strings
]]
function hep_reduce.assert_studio_common(var: string | number | {any} | Folder, err_msg: string?, get_descendants: boolean?)
	hep_reduce.assert_studio(var, "Invalid variable given (assert studio common)!")
	
	if type(var) == "string" then
		hep_reduce.assert_studio(var ~= "", err_msg or "String is empty!")
	elseif type(var) == "number" then
		hep_reduce.assert_studio(var > 0, err_msg or "Number is not higher than 0!")
	elseif type(var) == "table" then
		local success, err = pcall(function()
			hep_reduce.assert_studio(#var > 0, err_msg or "Table is empty!")
		end)
		
		if not success then
			warn("Table variable should NOT be 2D or higher:", err)
		end
	elseif var.ClassName == "Folder" then
		if get_descendants then
			print("Total folder items:", #var:GetDescendants())
			hep_reduce.assert_studio(#var:GetDescendants(), var.Name .. " is empty!")
		else
			print("Total folder items:", #var:GetChildren())
			hep_reduce.assert_studio(#var:GetChildren(), var.Name .. " is empty!")
		end
	else
		hep_reduce.assert_studio(var, "Unsupported variable! Variable not string or not number!")
	end
end


--[[ Award a badge to a player

Checks if not already owned before awarding

NOTE: NaN not checked against (may be okay for badges)
]]
function hep_reduce.award_badge(plr: Player, badge_id: number, logs: {will_own_msg: string, already_owns_msg: string, err_msg: string})
	hep_reduce.assert_studio(badge_id, "Invalid badge id given!")
	hep_reduce.assert_studio(badge_id > 0, "Badge id given is not higher than 0!")

	local success, err = pcall(function()
		if not BS:UserHasBadgeAsync(plr.UserId, badge_id) then
			print(logs.will_own_msg)
			BS:AwardBadgeAsync(plr.UserId, badge_id)
		end

		print(logs.already_owns_msg)
	end)

	if not success then
		warn(logs.err_msg, err)
		return
	end
end

return hep_reduce