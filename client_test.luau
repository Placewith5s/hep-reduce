--!strict
local hep_reduce = require(game.ReplicatedStorage.hep_reduce)

local test_gui: ScreenGui = script.Parent
local test_btn: TextButton = test_gui and test_gui:FindFirstChild("test_btn") :: TextButton

local debounce = hep_reduce.debouncer(2)


local function debounced_click()
	if debounce() then print("Debounced the click") end
end

test_btn.Activated:Connect(debounced_click)