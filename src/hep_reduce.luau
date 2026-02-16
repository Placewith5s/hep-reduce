--!strict
local hep_reduce = {}

local checks = require(script:WaitForChild("checks"))
local gets = require(script:WaitForChild("gets"))


local function create_instance(class_name: string, name: string | nil, parent: Instance?)
	local new_instance = Instance.new(class_name)
	new_instance.Name = name or class_name
	new_instance.Parent = parent
	return new_instance
end

-- @param parent - defaults to SoundService
-- NOTE: Also checks if provided name is invalid
function hep_reduce.create_regular_audio_player(
	name: string, asset_id: number, parent: Instance | SoundService): AudioPlayer
	checks.invalid_str(name)
	
	local regular_audio_player: AudioPlayer = create_instance(
		"AudioPlayer", name, parent or game.SoundService)
	regular_audio_player.Asset = "rbxassetid://" .. asset_id
	
	local audio_device_output: AudioDeviceOutput = create_instance(
		"AudioDeviceOutput", nil, regular_audio_player)
	
	local wire: Wire = create_instance("Wire", nil, regular_audio_player)
	wire.SourceInstance = regular_audio_player
	wire.TargetInstance = audio_device_output
	
	return regular_audio_player
end

-- (SERVER ONLY)
-- NOTE: Also checks if provided parent is invalid
function hep_reduce.create_leaderstats(parent: Player): Folder
	checks.server_only()
	checks.invalid_parent(parent)

	local leaderstats_found: Folder | nil = parent:FindFirstChild("leaderstats") :: Folder | nil

	checks.already_exists(leaderstats_found, "Leaderstats")

	local leaderstats: Folder = create_instance("Folder", "leaderstats", parent)
	
	return leaderstats
end

-- (SERVER ONLY)
-- NOTE: Also checks if provided parent is invalid
function hep_reduce.create_leaderstat(class_name: string, stat_name: string, value, parent: Folder)
	checks.server_only()
	checks.invalid_parent(parent)

	local new_stat: ValueBase = create_instance(class_name, stat_name, parent)
	new_stat.Value = value

	return new_stat
end

-- @usage local debounce = hep_reduce.create_debounce(0.3) if debounce() then print("Debounced") end
function hep_reduce.create_debounce(duration: number): () -> boolean
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
-- @usage local plr_debounce = hep_reduce.create_plr_debounce(0.3) if plr_debounce() then print("Debounced") end
function hep_reduce.create_plr_debounce(duration: number): (player: Player) -> boolean
	checks.server_only()
	
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
	checks.client_only()
	
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
-- NOTE: Also checks if provided character is invalid
function hep_reduce.get_head(char: Model): BasePart
	checks.invalid_char(char)
	local head: BasePart | nil = gets.get_char_instance(char, "Head") :: BasePart | nil
	checks.invalid_char_child_inst(head, "Head")

	return head :: BasePart
end

-- Get the model's "HumanoidRootPart" using its character
-- NOTE: Also checks if provided "HumanoidRootPart" is invalid
function hep_reduce.get_hrp(char: Model): BasePart
	checks.invalid_char(char)
	local hrp: BasePart | nil = gets.get_char_instance(char, "HumanoidRootPart") :: BasePart | nil
	checks.invalid_char_child_inst(hrp, "HumanoidRootPart")

	return hrp :: BasePart
end

-- Get the model's "Humanoid" using its character
-- NOTE: Also checks if provided "Humanoid" is invalid
function hep_reduce.get_hum(char: Model): Humanoid
	checks.invalid_char(char)
	local hum: Humanoid | nil = gets.get_char_instance(char, "Humanoid") :: Humanoid | nil
	checks.invalid_char_child_inst(hum, "Humanoid")

	return hum :: Humanoid
end

-- Get the model's "Torso" using its character
-- NOTE: Also checks if provided "Torso" is invalid
function hep_reduce.get_torso(char: Model): BasePart
	checks.invalid_char(char)
	local hum: BasePart | nil = gets.get_char_instance(char, "Torso") :: BasePart | nil
	checks.invalid_char_child_inst(hum, "Torso")

	return hum :: BasePart
end

function hep_reduce.init_instance_list(container: Instance?)
	local storage: {Instance?} = {}
	
	for _, key in container:GetChildren() do
		table.insert(storage, key)
	end
	
	return storage
end

-- NOTE: Also checks if provided table is invalid
function hep_reduce.get_random_instance(storage: {Instance?})
	checks.invalid_table(storage)
	
	local chosen_num: number = math.random(1, #storage)
	local chosen_key = storage[chosen_num]
	return chosen_key
end

-- NOTE: Also checks if provided number is invalid
function hep_reduce.is_non_positive(num: number): boolean
	checks.invalid_num(num)
	return num <= 0
end

-- NOTE: Also checks if provided number is invalid
function hep_reduce.is_nan(num: number): boolean
	checks.invalid_num(num)
	return num ~= num
end

-- NOTE: Also checks if provided string is invalid
function hep_reduce.is_empty_str(str_to_check: string): boolean
	checks.invalid_str(str_to_check)
	return not str_to_check:find("%S")
end

-- NOTE: Also checks if provided string is invalid
function hep_reduce.is_empty_str_no_trim(str_to_check: string): boolean
	checks.invalid_str(str_to_check)
	return str_to_check == ""
end

-- NOTE: Also checks if provided table is invalid
function hep_reduce.is_empty_table(table_to_check: {[any]: any}): boolean
	checks.invalid_table(table_to_check)
	return next(table_to_check) == nil
end

-- NOTE: Also checks if any provided "HumanoidRootPart" is invalid
function hep_reduce.magnitude(hrp_1: BasePart, hrp_2: BasePart)
	local hrps: {BasePart?} = {hrp_1, hrp_2}
	checks.invalid_char_child_instances(hrps, "HumanoidRootPart")
	
	return (hrp_1.Position - hrp_2.Position).Magnitude
end

-- NOTE: Also checks if any provided "HumanoidRootPart" is invalid
function hep_reduce.unit(hrp_1: BasePart, hrp_2: BasePart, multiplied_value: number)
	local hrps: {BasePart?} = {hrp_1, hrp_2}
	checks.invalid_char_child_instances(hrps, "HumanoidRootPart")

	return (hrp_1.Position - hrp_2.Position).Unit * multiplied_value
end

-- @param seconds - setting it to 0 will default to RunService.Heartbeat:Wait()
-- @return - the thread for cleanup / debugging purposes
-- NOTE: Also checks if provided number or thread is invalid
function hep_reduce.schedule(seconds: number): thread?
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