--!strict
local checks = {}

type What = "Head" | "Humanoid" | "HumanoidRootPart"


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

function checks.already_exists(parent, what: string)
	if parent then
		error(what .. "already exists!")
	end
end

function checks.invalid_char(char: Model)
	if (not char:IsA("Model") or not char) then
		error("Invalid character provided!")
	end
end

function checks.invalid_char_inst(char_inst, char_name: string, what: What)
	if not char_inst then
		error("Couldn't get" .. what .. "for " .. char_name .. "!")
	end
end

function checks.invalid_num(num: number)
	if (type(num) ~= "number" or not num) then
		error("Invalid number!")
	end
end

function checks.invalid_str(str: string)
	if (type(str) ~= "string" or not str) then
		error("Invalid string!")
	end
end

function checks.invalid_parent(parent)
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
		error("Invalid table!")
	end
end

function checks.invalid_thread(thread: thread | nil)
	if not thread then
		error("Couldn't return async thread!")
	end
end

return checks