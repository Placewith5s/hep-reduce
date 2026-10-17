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

	Whether to warn in production for server scripts only

.. lua:function:: hep_reduce.is_studio(): boolean
	
	used by assert studio functions but can come in handy

	.. code-block:: luau
		:linenos:
		:caption: is_studio Example

		hep_reduce.is_studio() -- true

.. lua:function:: hep_reduce.assert_studio(what: any, err_msg: string?)

	:param what: What to check for assert. Either a condition or a variable
	:param err_msg: The error message

	:caption: default error message for conditions: "false!" 
	:caption: default error message for other types: "typeof(what) is nil!"

	.. code-block:: luau
		:linenos:
		:caption: assert_studio Example

		hep_reduce.assert_studio(game ~= workspace, "DataModel is workspace!") -- nothing happens

.. lua:function:: hep_reduce.assert_studio_common(var: string | number | {any} | Folder, err_msg: string?, get_descendants: boolean?)

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

	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned instance's children

	.. code-block:: luau
		:linenos:
		:caption: GetClonedChildren Example

		local new_children = hep_reduce.GetClonedChildren(folder, game.ReplicatedStorage)
		print(new_children)

.. lua:function:: hep_reduce.GetClonedDescendants(instance: Instance?, parent: Instance?): {Instance}

	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned descendants of the instance

	.. code-block:: luau
		:linenos:
		:caption: GetClonedDescendants Example

		local new_descendants = hep_reduce.GetClonedDescendants(folder, game.ServerStorage)
		print(new_descendants)

.. lua:function:: hep_reduce.player_added(args: {func: (player: Player) -> ()})

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

	Getting local PlayerGui QOL

	:note: Asserts / warns when used in a server script

	.. code-block:: luau
		:linenos:
		:caption: get_local_plr_gui Example

		local plr_gui = hep_reduce.get_local_plr_gui()
		print(plr_gui) -- PlayerGui

.. lua:function:: hep_reduce.get_local_char()

	Getting local Character QOL

	:return: Model

	:note: Asserts / warns when used in a server script

	.. code-block:: luau
		:linenos:
		:caption: get_local_char Example

		local char = hep_reduce.get_local_char()
		print(char)