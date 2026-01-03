# Hep Reduce
- A module for Roblox Studio to reduce coding repetitiveness.

## Installation


## Usage
```lua
--!strict
local our_module = require(game.ServerScriptService.our_module)

repeat task.wait() until #game.Players:GetPlayers() > 0 -- studio's poop break :)


local function test_wait_async()
	print("Hello from async serial!")
end

local function test_while_wait_async()
	print("Repeated hello from while async serial")
end

local cancelable_thread: thread = our_module.wait_async(3, test_wait_async)
local cancelable_thread_2: thread = our_module.while_wait_async(1, test_while_wait_async, false)
```

## Documentation
- LuaDoc