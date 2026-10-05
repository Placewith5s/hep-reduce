# Hep Reduce
- A module for Roblox Studio to reduce some repetitiveness.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases)

## Usage
```luau
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

local folder: Folder = Instance.new("Folder")
folder.Name = "Tester"
folder.Parent = workspace

hep_reduce.award_badge(
	plr, badge_id,
	will_own_msg, already_owns_msg, err_msg
)

-- optional custom error message as the 2nd argument
hep_reduce.assert_studio_common(folder)
--[[
Total folder items: 0
Tester is empty!
]]
hep_reduce.assert_studio(game ~= workspace, "DataModel is workspace!") -- nothing happens

hep_reduce.is_studio() -- true

## Documentation


## Contribution
[CONTRIBUTE.md](CONTRIBUTE.md)