--!strict
local hep_reduce = require(game.ServerScriptService.hep_reduce)

local plr: Player = game.Players.PlayerAdded:Wait()

local leaderstats: Folder = hep_reduce.create_leaderstats(plr)
local coins: IntValue = hep_reduce.new_leaderstat("IntValue", "Coins", 0, leaderstats)

print("Stat:", coins.Name, "Amount:", coins.Value)