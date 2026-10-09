# Hep Reduce
- A module for Roblox Studio to reduce some repetitiveness.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases)

## Usage
```luau
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

local folder: Folder = hep_reduce.instance_creator:new(
	"Folder", {
		name = "Tester",
		parent = workspace
	}
)

local folder_child: Part = hep_reduce.instance_creator:new(
	"Part",
	{
		name = "child_part",
		parent = folder
	}
)

--[[hep_reduce.award_badge(
	plr, badge_id,
	{
		will_own_msg, already_owns_msg, err_msg
	}
)]]

-- optional custom error message as the 2nd argument
hep_reduce.assert_studio_common(folder)
--[[
Total folder items: 1
]]

local new_children = hep_reduce.GetClonedChildren(folder, game.ReplicatedStorage)
local new_descendants = hep_reduce.GetClonedDescendants(folder, game.ServerStorage)
print(new_children)
print(new_descendants)

-- parent is optional
local new_children_no_parent = hep_reduce.GetClonedChildren(folder)

for _, child in new_children_no_parent do
	print(child.Parent) -- nil
	
	child.Parent = game.ReplicatedStorage
	print(child.Parent) -- ReplicatedStorage
end

-- optional custom error message as the 2nd argument
hep_reduce.assert_studio(game ~= workspace, "DataModel is workspace!") -- nothing happens

hep_reduce.is_studio() -- true
```

## Documentation


## Contribution
[CONTRIBUTE.md](CONTRIBUTE.md)