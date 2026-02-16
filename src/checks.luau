--!strict
local checks = {}

type Char_Child_Name = "Head" | "Humanoid" | "HumanoidRootPart" | "Torso"


function checks.client_only()
	if game["Run Service"]:IsServer() then
		error("Client only usage detected!")
	end
end

function checks.server_only()
	if game["Run Service"]:IsClient() then
		error("Server only usage detected!")
	end
end

function checks.already_exists(parent: Instance?, what: string)
	if parent then
		error(what .. "already exists!")
	end
end

function checks.invalid_char(char: Model)
	if (not char:IsA("Model") or not char) then
		error("Invalid character provided!")
	end
end

function checks.invalid_char_child_inst(char_child_inst: BasePart? | Humanoid?, what: Char_Child_Name)
	if not char_child_inst then
		error("Invalid " .. what .. "!")
	end
	
	if char_child_inst.Name ~= what then
		error("Invalid " .. what .. "!" .. " Got " .. char_child_inst.Name)
	end
end

function checks.invalid_char_child_instances(char_child_instances: {BasePart?} | {Humanoid?}, what: Char_Child_Name)
	for _, char_child_inst in char_child_instances do
		if char_child_inst.Name ~= what then
			error("Invalid " .. what .. "!" .. " Got " .. char_child_inst.Name)
		end
	end
end

function checks.invalid_num(num: number)
	if (type(num) ~= "number" or not num) then
		error("Invalid number provided!")
	end
end

function checks.invalid_str(str: string)
	if (type(str) ~= "string" or not str) then
		error("Invalid string provided!")
	end
end

function checks.invalid_parent(parent: Instance?)
	if not parent then
		error("Invalid parent provided!")
	end
end

function checks.invalid_seconds(seconds: number): number | nil
	if (type(seconds) ~= "number" or seconds ~= seconds) then
		warn("Invalid seconds provided! Defaulting to 0")
		return 0
	end

	return nil
end

function checks.invalid_table(t: {[any]: any})
	if (type(t) ~= "table" or not t) then
		error("Invalid table provided!")
	end
end

function checks.invalid_thread(thread: thread | nil)
	if not thread then
		error("Invalid thread provided!")
	end
end

return checks