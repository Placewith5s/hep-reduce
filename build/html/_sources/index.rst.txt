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

.. lua:function:: hep_reduce.assert_studio(what: any, err_msg: string?)

	:param what: What to check for assert. Either a condition or a variable
	:param err_msg: The error message

	:caption: default error message for conditions: "false!" 
	:caption: default error message for other types: "typeof(what) is nil!"

.. lua:function:: hep_reduce.assert_studio_common(var: string | number | {any} | Folder, err_msg: string?, get_descendants: boolean?)

	Assert studio but for strings, numbers, a certain type of 1D tables, and folders

	:param var: The variable to check for assert
	:param err_msg: The error message
	:param get_descendants: The method used for folders. Defaults to GetChildren()

	:caption: INFO: debug message included for little time saving
	:caution: Does not handle whitespace for strings

.. lua:function:: hep_reduce.award_badge(plr: Player, badge_id: number, logs: {will_own_msg: string, already_owns_msg: string, err_msg: string})

	Award a badge to a player

	:caption: Checks if not already owned before awarding

	:param plr: The player
	:param badge_id: The asset id of the badge
	:param logs.will_own_msg: The log message displayed for players who are about to get the badge
	:param logs.already_owns_msg: The log message displayed for players who already have the badge
	:param logs.err_msg: The error message

.. lua:function:: hep_reduce.GetClonedChildren(instance: Instance?, parent: Instance?): {Instance}

	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned instance's children

.. lua:function:: hep_reduce.GetClonedDescendants(instance: Instance?, parent: Instance?): {Instance}

	:param instance: The instance to clone
	:param parent: The parent to clone instance to
	:return: an array containing all of the cloned descendants of the instance

.. lua:function:: hep_reduce.player_added(args: {func: (player: Player) -> ()})

	:param args.func: The function to call inside PlayerAdded:Connect()
	:return: RBXScriptConnection

.. lua:function:: hep_reduce.character_added(args: {func: (character: Model) -> ()})

	:param args.func: The function to call inside CharacterAdded:Connect()
	:return: RBXScriptConnection

	:note: PlayerAdded connection returned and CharacterAdded connection not returned

.. lua:function:: hep_reduce.get_local_plr_gui(): PlayerGui

	Getting local PlayerGui QOL

	:note: Asserts / warns when used in a server script

.. lua:function:: hep_reduce.get_local_plr_gui()

	Getting local Character QOL

	:return: Model

	:note: Asserts / warns when used in a server script