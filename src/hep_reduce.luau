--[[
MIT License

Copyright (c) [2026] [Placewith5s]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

]]

--!strict
local hep_reduce = {}

hep_reduce.instance_creator = require(script.instance_creator)

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
			return
		end
	elseif var.ClassName == "Folder" then
		if get_descendants then
			print("Total folder items:", #var:GetDescendants())
			hep_reduce.assert_studio(#var:GetDescendants() > 0, var.Name .. " is empty!")
		else
			print("Total folder items:", #var:GetChildren())
			hep_reduce.assert_studio(#var:GetChildren() > 0, var.Name .. " is empty!")
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


local function clone_worker(current_array: {Instance}, parent: Instance?)
	local cloned_array: {Instance} = {}
	
	for _, inst in current_array do
		local clone: Instance = inst:Clone()

		if inst.Parent then
			clone.Parent = parent
		end

		table.insert(cloned_array, clone)
	end
	
	return cloned_array
end


--[[ Returns an array containing all of the cloned instance's children.

parent: the parent of the cloned children (optional)
]]
function hep_reduce.GetClonedChildren(instance: Instance?, parent: Instance?)
	hep_reduce.assert_studio(
		instance,
		"Cannot get new cloned children! Invalid instance given!"
	)
	
	local current_array = instance:GetChildren()
	local cloned_array: {Instance} = clone_worker(current_array, parent)
	return cloned_array
end


--[[ Returns an array containing all of the cloned descendants of the instance.

parent: the parent of the cloned descendants (optional)
]]
function hep_reduce.GetClonedDescendants(instance: Instance?, parent: Instance?)
	hep_reduce.assert_studio(
		instance,
		"Cannot get new cloned descendants! Invalid instance given!"
	)
	
	local current_array = instance:GetDescendants()
	local cloned_array: {Instance} = clone_worker(current_array, parent)
	return cloned_array
end


--[[ PlayerAdded QOL
]]
function hep_reduce.player_added(args: {func: (player: Player) -> ()})
	hep_reduce.assert_studio(type(args.func) == "function", "Invalid function given!")

	local plr_added_conn = game.Players.PlayerAdded:Connect(function(plr: Player)
		local success, err = pcall(args.func, plr)

		if not success then
			warn("Cannot call given function:", err)
			return
		end
	end)
	
	return plr_added_conn
end


--[[ CharacterAdded QOL

INFO: PlayerAdded connection returned and CharacterAdded connection not returned
]]
function hep_reduce.character_added(args: {func: (character: Model) -> ()})
	hep_reduce.assert_studio(type(args.func) == "function", "Invalid function given!")
	
	local plr_added_conn = game.Players.PlayerAdded:Connect(function(plr: Player)
		plr.CharacterAdded:Connect(function(char: Model)
			local success, err = pcall(args.func, char)
			
			if not success then
				warn("Cannot call given function:", err)
				return
			end
		end)
	end)
	
	return plr_added_conn
end

return hep_reduce