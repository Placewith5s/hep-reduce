--!strict
local checks = {}

type What = "Head" | "Humanoid" | "HumanoidRootPart"


function checks.check_char(char: Model)
	if (not char:IsA("Model") or not char) then
		error("Invalid character provided! From: " .. debug.info(2, "sln"))
	end
end

function checks.check_char_inst(char_inst, char_name: string, what: What)
	if not char_inst then
		error("Couldn't get" .. what .. "for " .. char_name .. "!")
	end
end

function checks.check_seconds(seconds: number): number | nil
	if (type(seconds) ~= "number" or seconds ~= seconds) then
		warn("Invalid seconds provided! Defaulting to 0")
		return 0
	end

	return nil
end

function checks.check_thread(thread: thread | nil)
	if not thread then
		error("Couldn't return async thread!")
	end
end

return checks