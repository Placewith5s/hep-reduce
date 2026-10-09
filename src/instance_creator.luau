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
		return
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