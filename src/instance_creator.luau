local instance_creator = {}
instance_creator.__index = instance_creator


local function make(class_name: string, name: string, parent: Instance?): any
	local creation: any = nil
	
	local success, err = pcall(function()
		creation = Instance.new(class_name)
		creation.Name = name
		creation.Parent = parent
	end)
	
	if not success then
		warn("Cannot make instance:", err)
	end
	
	return creation
end


function instance_creator:new(class_name: string, common: {name: string, parent: Instance?}): any
	local instance = setmetatable({}, self)
	
	instance.class_name = class_name
	instance.name = common.name
	instance.parent = common.parent
	
	instance.creation = make(
		instance.class_name, instance.name,
		instance.parent
	)
	return instance.creation
end


return instance_creator