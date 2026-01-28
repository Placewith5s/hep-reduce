# Hep Reduce
- A module for Roblox Studio to reduce coding repetitiveness and easily improve readability.

## Installation
[hep_reduce.rbxm](https://github.com/Placewith5s/hep_reduce/releases)

## Usage
```lua
--!strict
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

game.Players.PlayerAdded:Wait() -- studio's poop break :)


local function test_wait_async()
	print("Hello from async serial!")
end

hep_reduce.wait_async(3)
print("Here before 3 seconds!")
```

- [Client example usage](./client_test.luau)
- [Server example usage](./server_test.luau)

## Documentation
- LuaDoc

## Contribution
[CONTRIBUTE.md](CONTRIBUTE.md)