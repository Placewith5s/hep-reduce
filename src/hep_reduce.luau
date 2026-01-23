--!strict
local hep_reduce = {}

local checks = require(script:WaitForChild("checks"))
local get_helper = require(script:WaitForChild("get_helper"))


-- (CLIENT ONLY)
-- @return - the updated debounce for cleanup / debugging purposes
-- @usage local debounce = hep_reduce.debouncer(0.3) if debounce() then print("Debounced") end
function hep_reduce.debouncer(duration: number): () -> boolean
	local debounce: boolean = false
	
	return function(): boolean
		if debounce then return false end
		debounce = true

		local thread: thread = task.delay(duration, function()
			debounce = false
		end)
		
		return true
	end
end

-- (SERVER ONLY)
-- @return - the updated debounce for player for cleanup / debugging purposes
-- @usage local debounce = hep_reduce.plr_debouncer(0.3) if debounce() then print("Debounced") end
function hep_reduce.plr_debouncer(player: Player, duration: number): (player: Player) -> boolean
	local debounce: {[Player]: boolean} = {}
	
	return function(player: Player): boolean
		if debounce[player] then return false end
		debounce[player] = true

		local thread: thread = task.delay(duration, function()
			debounce[player] = false
		end)

		return true
	end
end

-- (CLIENT ONLY)
-- Disables character respawn at all times
-- @param MAX_RETRIES - default is 8
function hep_reduce.disable_char_respawn(MAX_RETRIES: number | nil)
	local function core_call(method, ...)
		local CHOICE: number = MAX_RETRIES or 8

		local result = {}

		for retries = 1, CHOICE do
			result = {pcall(game.StarterGui[method], game.StarterGui, ...)}
			if result[1] then
				break
			end

			game["Run Service"].Stepped:Wait()
		end

		return unpack(result)
	end

	core_call('SetCore', 'ResetButtonCallback', false)
end

-- Get the model's "Head" using its character
-- @usage hep_reduce.get_head(char)
function hep_reduce.get_head(char: Model): BasePart
	checks.check_char(char)
	local head: BasePart | nil = get_helper.get_char_instance(char, "Head") :: BasePart | nil
	checks.check_char_inst(head, char.Name, "Head")

	return head :: BasePart
end

-- Get the model's "HumanoidRootPart" using its character
-- @usage hep_reduce.get_hrp(char)
function hep_reduce.get_hrp(char: Model): BasePart
	checks.check_char(char)
	local hrp: BasePart | nil = get_helper.get_char_instance(char, "HumanoidRootPart") :: BasePart | nil
	checks.check_char_inst(hrp, char.Name, "HumanoidRootPart")

	return hrp :: BasePart
end

-- Get the model's "Humanoid" using its character
-- @usage hep_reduce.get_hum(char)
function hep_reduce.get_hum(char: Model): Humanoid
	checks.check_char(char)
	local hum: Humanoid | nil = get_helper.get_char_instance(char, "Humanoid") :: Humanoid | nil
	checks.check_char_inst(hum, char.Name, "Humanoid")

	return hum :: Humanoid
end

-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @return - the thread for cleanup / debugging purposes
-- @usage hep_reduce.wait_async(3)
function hep_reduce.wait_async(seconds: number): thread?
	local invalid_seconds: number | nil = checks.check_seconds(seconds)

	local thread: thread | nil = nil

	if seconds == 0 or invalid_seconds then
		thread = task.spawn(function() task.wait() end)
	else
		thread = task.delay(seconds, function() end)
	end

	checks.check_thread(thread)

	return thread
end

return hep_reduce