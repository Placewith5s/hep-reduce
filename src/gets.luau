--!strict
local gets = {}


function gets.get_char_instance(char: Model, inst_name: string): Instance | nil
	local found_inst: Instance | nil = char:FindFirstChild(inst_name)

	return found_inst
end

return gets