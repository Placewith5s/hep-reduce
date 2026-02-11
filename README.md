# Hep Reduce
- A module for Roblox Studio to reduce coding repetitiveness and easily improve readability.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases)

## Usage
```lua
--!strict
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

hep_reduce.create_regular_audio_player("test_audio", 1234567890)

game.Players.PlayerAdded:Wait() -- studio's poop break :)

local possible_parts = hep_reduce.init_instance_list(workspace.Test_Folder)

hep_reduce.schedule(3)
print("Here before 3 seconds!")

local chosen_part = hep_reduce.get_random_instance(storage)
```

## Documentation
- LuaDoc

## Contribution
[CONTRIBUTE.md](CONTRIBUTE.md)