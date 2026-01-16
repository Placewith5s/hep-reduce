# Hep Reduce
- A module for Roblox Studio to reduce coding repetitiveness.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases/download/0.2.0/hep_reduce.rbxm)

## Usage
```lua
--!strict
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

game.Players.PlayerAdded:Wait() > 0 -- studio's poop break :)


local function test_wait_async()
	print("Hello from async serial!")
end

hep_reduce.wait_async(3)
print("Here before 3 seconds!")
```

## Documentation
- LuaDoc

## Contribution
[CONTRIBUTE.md](CONTRIBUTE.md)