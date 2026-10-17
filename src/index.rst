.. hep-reduce documentation master file, created by
   sphinx-quickstart on Fri Oct 16 16:04:17 2026.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

hep-reduce documentation
========================

.. meta::
   :title: Hep Reduce Documentation
   :description: The documentation for a module for Roblox Studio to reduce some coding repetitiveness.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

.. lua:data:: hep_reduce.warn_in_prod: boolean

	.. version-added:: v2.4.0

	Whether to warn in production for server scripts only

.. lua:function:: hep_reduce.is_studio(): boolean
	
	.. version-added:: v2.0.0

	used by assert studio functions but can come in handy

	.. code-block:: luau
		:linenos:
		:caption: is_studio Example

		hep_reduce.is_studio() -- true

.. lua:function:: hep_reduce.assert_studio(what: any, err_msg: string?)

	.. version-added:: v2.0.0

	:param what: What to check for assert. Either a condition or a variable
	:param err_msg: The error message

	:caption: default error message for conditions: "false!" 
	:caption: default error message for other types: "typeof(what) is nil!"

	.. code-block:: luau
		:linenos:
		:caption: assert_studio Example

		hep_reduce.assert_studio(game ~= workspace, "DataModel is workspace!") -- nothing happens

.. lua:function:: hep_reduce.assert_studio_common(var: string | number | {any} | Folder, err_msg: string?, get_descendants: boolean?)

	.. version-added:: v2.0.0

	Assert studio but for strings, numbers, a certain type of 1D tables, and folders

	:param var: The variable to check for assert
	:param err_msg: The error message
	:param get_descendants: The method used for folders. Defaults to GetChildren()

	:caption: INFO: debug message included for little time saving
	:caution: Does not handle whitespace for strings

	.. code-block:: luau
		:linenos:
		:caption: assert_studio_common Example

		hep_reduce.assert_studio_common(folder)
		--[[
		Total folder items: 1
		]]

.. lua:function:: hep_reduce.award_badge(plr: Player, badge_id: number, logs: {will_own_msg: string, already_owns_msg: string, err_msg: string})

	.. version-added:: v2.0.0

	Award a badge to a player

	:caption: Checks if not already owned before awarding

	:param plr: The player
	:param badge_id: The asset id of the badge
	:param logs.will_own_msg: The log message displayed for players who are about to get the badge
	:param logs.already_owns_msg: The log message displayed for players who already have the badge
	:param logs.err_msg: The error message

	.. code-block:: luau
		:linenos:
		:caption: award_badge Example

		hep_reduce.award_badge(
			plr, 1234567890,
			{
				"Player will own badge name",
				"Player already owns badge name",
				"Cannot award badge! Is badge enabled?"
			}
		)

.. lua:function:: hep_reduce.GetClonedChildren(instance: Instance?, parent: Instance?): {Instance}

	.. version-added:: v2.2.0
	
	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned instance's children

	.. code-block:: luau
		:linenos:
		:caption: GetClonedChildren Example

		local new_children = hep_reduce.GetClonedChildren(folder, game.ReplicatedStorage)
		print(new_children)

.. lua:function:: hep_reduce.GetClonedDescendants(instance: Instance?, parent: Instance?): {Instance}

	.. version-added:: v2.2.0

	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned descendants of the instance

	.. code-block:: luau
		:linenos:
		:caption: GetClonedDescendants Example

		local new_descendants = hep_reduce.GetClonedDescendants(folder, game.ServerStorage)
		print(new_descendants)

.. lua:function:: hep_reduce.player_added(args: {func: (player: Player) -> ()})

	.. version-added:: v2.3.0

	:param args.func: The function to call inside PlayerAdded:Connect()
	:return: RBXScriptConnection

	.. code-block:: luau
		:linenos:
		:caption: player_added Example
		
		local function when_plr_added(plr: Player)
			print("Player added")

			print(plr.UserId)
			local char = plr.Character or plr.CharacterAdded:Wait()
			print(char.Parent.Parent)
		end

		hep_reduce.player_added(
			{
				func = when_plr_added
			}
		)

.. lua:function:: hep_reduce.character_added(args: {func: (character: Model) -> ()})

	.. version-added:: v2.3.0

	:param args.func: The function to call inside CharacterAdded:Connect()
	:return: RBXScriptConnection

	:note: PlayerAdded connection returned and CharacterAdded connection not returned

	.. code-block:: luau
		:linenos:
		:caption: character_added Example

		local function when_char_added(char: Model)
			print("Character added")

			print(char)
			local hum = char:WaitForChild("Humanoid")
			print(hum)
		end

		hep_reduce.character_added(
			{
				func = when_char_added
			}
		)

.. lua:function:: hep_reduce.get_local_plr_gui(): PlayerGui

	.. version-added:: v2.5.0

	Getting local PlayerGui QOL

	:note: Asserts / warns when used in a server script

	.. code-block:: luau
		:linenos:
		:caption: get_local_plr_gui Example

		local plr_gui = hep_reduce.get_local_plr_gui()
		print(plr_gui) -- PlayerGui

.. lua:function:: hep_reduce.get_local_char()

	.. version-added:: v2.5.0

	Getting local Character QOL

	:return: Model

	:note: Asserts / warns when used in a server script

	.. code-block:: luau
		:linenos:
		:caption: get_local_char Example

		local char = hep_reduce.get_local_char()
		print(char)


.. lua:function:: hep_reduce.create_regular_audio_player(name: string, asset_id: number, parent: Instance | SoundService): AudioPlayer

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.create_leaderstats(parent: Player): Folder

	.. version-removed:: v2.0.0
		hep_reduce.instance_creator:new() should be used instead

.. lua:function:: hep_reduce.create_leaderstat(class_name: string, stat_name: string, value, parent: Folder)

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.create_debounce(duration: number): () -> boolean

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.create_plr_debounce(duration: number): (player: Player) -> boolean

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.disable_char_respawn(MAX_RETRIES: number | nil)

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.get_head(char: Model): BasePart

	.. version-removed:: v2.0.0
		Use hep_reduce.character_added or hep_reduce.get_local_char() instead

.. lua:function:: hep_reduce.get_hrp(char: Model): BasePart

	.. version-removed:: v2.0.0
		Use hep_reduce.character_added or hep_reduce.get_local_char() instead

.. lua:function:: hep_reduce.get_hum(char: Model): Humanoid

	.. version-removed:: v2.0.0
		Use hep_reduce.character_added or hep_reduce.get_local_char() instead

.. lua:function:: hep_reduce.get_torso(char: Model): BasePart

	.. version-removed:: v2.0.0
		Use hep_reduce.character_added or hep_reduce.get_local_char() instead

.. lua:function:: hep_reduce.init_instance_list(container: Instance?)

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.get_random_instance(storage: {Instance?})

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.is_non_positive(num: number): boolean

	.. version-removed:: v2.0.0
		Use math.isinf(x: number) or math.isfinite(x: number) instead

.. lua:function:: hep_reduce.is_nan(num: number): boolean

	.. version-removed:: v2.0.0
		Use the built-in math.isnan(x: number) instead

.. lua:function:: hep_reduce.is_empty_str(str_to_check: string): boolean

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.is_empty_str_no_trim(str_to_check: string): boolean

	.. version-removed:: v2.0.0
		Use hep_reduce.assert_studio_common() instead

.. lua:function:: hep_reduce.is_empty_table(table_to_check: {[any]: any}): boolean

	.. version-removed:: v2.0.0
		Use hep_reduce.assert_studio_common() instead

.. lua:function:: hep_reduce.magnitude(hrp_1: BasePart, hrp_2: BasePart)

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.unit(hrp_1: BasePart, hrp_2: BasePart, multiplied_value: number)

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.schedule(seconds: number): thread?

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.retry(max_attempts: number, func: () -> ()): boolean

	.. version-removed:: v2.0.0

.. lua:function:: hep_reduce.timeout(seconds: number, err_msg: string, func: () -> ())

	.. version-removed:: v2.0.0