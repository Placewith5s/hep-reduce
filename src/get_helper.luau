--!strict
local get_helper = {}


function get_helper.get_char_instance(char: Model, inst_name: string): Instance | nil
	local found_inst: Instance | nil = char:FindFirstChild(inst_name)

	return found_inst
end

return get_helper