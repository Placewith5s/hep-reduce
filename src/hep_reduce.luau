--!strict
local hep_reduce = {}

local checks = require(script:WaitForChild("checks"))
local gets = require(script:WaitForChild("gets"))


-- (SERVER ONLY)
function hep_reduce.create_leaderstats(parent: Player)
	checks.invalid_service("DataStoreService")
	checks.invalid_parent(parent)

	local leaderstats_found: Folder | nil = parent:FindFirstChild("leaderstats") :: Folder | nil

	checks.already_exists(leaderstats_found, "Leaderstats")

	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = parent

	return leaderstats
end

-- (SERVER ONLY)
function hep_reduce.new_leaderstat(stat_name: string, inst_name: string, value, parent: Folder)
	checks.invalid_service("DataStoreService")
	checks.invalid_parent(parent)

	local new_stat: ValueBase = Instance.new(stat_name)
	new_stat.Name = inst_name
	new_stat.Value = value
	new_stat.Parent = parent

	return new_stat
end


-- (CLIENT ONLY)
-- @usage local debounce = hep_reduce.debouncer(0.3) if debounce() then print("Debounced") end
function hep_reduce.debouncer(duration: number): () -> boolean
	local debounce: boolean = false

	return function(): boolean
		if debounce then return false end
		debounce = true

		local _thread: thread = task.delay(duration, function()
			debounce = false
		end)

		return true
	end
end

-- (SERVER ONLY)
-- @usage local debounce = hep_reduce.plr_debouncer(0.3) if debounce() then print("Debounced") end
function hep_reduce.plr_debouncer(player: Player, duration: number): (player: Player) -> boolean
	local debounce: {[Player]: boolean} = {}

	return function(player: Player): boolean
		if debounce[player] then return false end
		debounce[player] = true

		local _thread: thread = task.delay(duration, function()
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
	checks.invalid_char(char)
	local head: BasePart | nil = gets.get_char_instance(char, "Head") :: BasePart | nil
	checks.invalid_char_inst(head, char.Name, "Head")

	return head :: BasePart
end

-- Get the model's "HumanoidRootPart" using its character
-- @usage hep_reduce.get_hrp(char)
function hep_reduce.get_hrp(char: Model): BasePart
	checks.invalid_char(char)
	local hrp: BasePart | nil = gets.get_char_instance(char, "HumanoidRootPart") :: BasePart | nil
	checks.invalid_char_inst(hrp, char.Name, "HumanoidRootPart")

	return hrp :: BasePart
end

-- Get the model's "Humanoid" using its character
-- @usage hep_reduce.get_hum(char)
function hep_reduce.get_hum(char: Model): Humanoid
	checks.invalid_char(char)
	local hum: Humanoid | nil = gets.get_char_instance(char, "Humanoid") :: Humanoid | nil
	checks.invalid_char_inst(hum, char.Name, "Humanoid")

	return hum :: Humanoid
end

function hep_reduce.is_zero_or_lower(num: number): boolean
	checks.invalid_num(num)
	
	if num <= 0 then
		return true
	end

	return false
end

function hep_reduce.is_nan(num: number): boolean
	checks.invalid_num(num)
	
	if num ~= num then
		return true
	end
	
	return false
end

function hep_reduce.is_empty_str(str_to_check: string): boolean
	checks.invalid_str(str_to_check)

	if str_to_check == "" then
		return true
	end

	return false
end

function hep_reduce.is_empty_table(table_to_check: {[any]: any}): boolean
	checks.invalid_table(table_to_check)
	return next(table_to_check) == nil
end

-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @return - the thread for cleanup / debugging purposes
-- @usage hep_reduce.wait_async(3)
function hep_reduce.wait_async(seconds: number): thread?
	local invalid_seconds: number | nil = checks.invalid_seconds(seconds)

	local thread: thread | nil = nil

	if seconds == 0 or invalid_seconds then
		thread = task.spawn(function() task.wait() end)
	else
		thread = task.delay(seconds, function() end)
	end

	checks.invalid_thread(thread)

	return thread
end

return hep_reduce