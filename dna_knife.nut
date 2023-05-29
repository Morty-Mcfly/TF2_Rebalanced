enum BUTTONS
{
    IN_ATTACK = 1,
    IN_JUMP = 2,
    IN_DUCK = 4,
    IN_FORWARD = 8,
    IN_BACK = 16,
    IN_USE = 32,
    IN_CANCEL = 64,
    IN_LEFT = 128,
    IN_RIGHT = 256,
    IN_MOVELEFT = 512,
    IN_MOVERIGHT = 1024,
    IN_ATTACK2 = 2048,
    IN_RUN = 4096,
    IN_RELOAD = 8192,
    IN_ALT1 = 16384,
    IN_ALT2 = 32768,
    IN_SCORE = 65536,
    IN_SPEED = 131072,
    IN_WALK = 262144,
    IN_ZOOM = 524288,
    IN_WEAPON1 = 1048576,
    IN_WEAPON2 = 2097152,
    IN_BULLRUSH = 4194304,
    IN_GRENADE1 = 8388608,
    IN_GRENADE2 = 16777216,
    IN_ATTACK3 = 33554432
};

local healthvalues = {}
local statlist = []
local customflags = {}
local loadoutstealing = false

//-----------------------------------------------------------------------------
// This file holds all custom weapon stuffs. Feel free to make your own.
//-----------------------------------------------------------------------------
/*	RegisterCustomWeapon Notes
		NOTE: Watch your map's ent count!
			It spawns 1 entity for the class_arms (tf_wearable_vm) if using a given weapon.
			It spawns 2 additional entities per weapon--one for the thirdperson model (tf_wearable), and another for firstperson (tf_wearable_vm)
			It also spawns 1 ent (tf_wearable) for managing ammo supply for given weapons, disabled weapons, and enabled weapons.
		NOTE: The player's viewmodel has a think script to fix the weapon appearing when needed, and being invisible when not
	
	Parameters Overview
	The two functions to register your custom weapon are as follows.
	NOTE: Everything is optional except item_name and baseitem. Pass `null` if using baseitem's parameters.
	
 ->	RegisterCustomWeapon(item_name, baseitem, stats_function, custom_weapon_model, custom_arms_model, custom_extra_wearable)
 ->	RegisterCustomWeaponEx(item_name, baseitem, stats_function, custom_weapon_model, custom_arms_model, custom_extra_wearable, ammo_type, clip_size, reserve_ammo, draw_seq)
		item_name = Custom item's name. Use this name in GiveWeapon to equip!
		baseitem = Accepts handles, weapon classnames, weapons by slot, or weapon string name. Same parameters as GiveWeapon() and others.
		stats_function = Custom stats to be called by a function. (Examples described later in this file)
		custom_weapon_model = Your new model over the old one. Appears in thirdperson as well as firstperson.
		custom_arms_model = Custom arms animations in first person.
		custom_extra_wearable = Custom wearable cosmetic on wearer.
		(Ex only) ammo_type = Which weapon slot the ammo is used from.
		(Ex only) clip_size = Max clip size
		(Ex only) reserve_ammo = Max reserve ammo
		(Ex only) draw_seq = The item's weapon deploying animation
*/

function DNA_Knife(weapon, player)
{
weapon.AddAttribute("max health additive penalty", -25, -1)
weapon.AddAttribute("fire rate penalty", 1.25, -1)
weapon.AddAttribute("mult cloak meter consume rate", 1.20, -1)
if( player.ValidateScriptScope() )
	{
		const DELAY_THINK_LONG = 5
		const DELAY_THINK = 0.05
		local truefalse = true
		local usable = true
		local entityscript = player.GetScriptScope()
		entityscript["think_Transform"] <- function()	//Our script's name.
		{
			if (usable == false) {
				weapon.RemoveAttribute("damage penalty")
				usable = true
			}
			local btn = NetProps.GetPropInt(player, "m_nButtons")
			if (btn & BUTTONS.IN_ATTACK3) {
			if (player in customflags && player.GetCondDuration(64) == 0.0 && customflags[player].transformed) 
			{
			customflags[player].transformed = false
			//local healthratio = player.GetHealth().tofloat() / player.GetMaxHealth().tofloat()
			player.RemoveCond(14)
			player.RemoveCond(64)
			player.RemoveCond(32)
			NetProps.SetPropInt(player, "m_PlayerClass.m_iClass", 8)
			player.RemoveCustomAttribute("max health additive penalty")
			player.RemoveCustomAttribute("damage penalty")
			player.RemoveCustomAttribute("health drain")
			player.Regenerate(true)
			player.AddCondEx(30, 6.0, player)
			player.AddCondEx(14, 3.0, player)
			player.AddCondEx(32, 3.0, player)
			player.AddCondEx(106, 1.5, player)
			//local ind = statlist.find("max health additive penalty")
			//if (ind != null) {
			//statlist.remove(ind)
			//}
			player.RemoveAllObjects(true)
			local rval = 100
			if (healthvalues[player]) {
			//rval = delete healthvalues[player]
			rval = healthvalues[player]
			}
			player.SetHealth(rval)
			//player.SetHealth(player.GetMaxHealth().tofloat() * healthratio)
			usable = false
			return DELAY_THINK_LONG
			}
			}
			return DELAY_THINK
		}
		AddThinkToEnt(player, "think_Transform")
	}
}

RegisterCustomWeaponEx("DNA Knife", "Your Eternal Reward", DNA_Knife, null, null, null, null, TF_AMMO.NONE, null, null)

function OnGameEvent_player_death(params)
{
	local dead = GetPlayerFromUserID(params.userid)
	if ("attacker" in params) 
	{
	local player = GetPlayerFromUserID(params.attacker)
	if (params.crit_type == 2 && GetItemID(player.ReturnWeaponBySlot(2)) == 1048801 && player.GetHealth() > 1 && player.GetActiveWeapon() == player.ReturnWeaponBySlot(2)) 
		{
			player.GTFW_Cleanup()
			if (player in healthvalues) {
			}
			else {
			healthvalues[player] <- player.GetHealth()
			}
			healthvalues[player] = player.GetHealth()
			//local healthratio = player.GetHealth().tofloat() / player.GetMaxHealth().tofloat()
			NetProps.SetPropInt(player, "m_PlayerClass.m_iClass", NetProps.GetPropInt(dead, "m_PlayerClass.m_iClass"))
			customflags[player].transformed = true
			player.AddCustomAttribute("damage penalty", 0.75, -1)
			player.Regenerate(false)
			statlist.append("damage penalty")
			player.AddCondEx(14, 4.0, player)
			player.AddCondEx(64, 4.0, player)
			player.AddCondEx(32, 4.0, player)
			player.AddCondEx(106, 1.5, player)
			player.AddCond(70)
			player.AddCustomAttribute("max health additive penalty", -(player.GetMaxHealth() * 0.5), -1)
			player.SetHealth(player.GetMaxHealth() * 1.5)
			if (loadoutstealing == true) {
			player.GiveWeapon(dead.ReturnWeaponBySlot(2))
			player.GiveWeapon(dead.ReturnWeaponBySlot(1))
			player.GiveWeapon(dead.ReturnWeaponBySlot(0))
			}
			player.RemoveCustomAttribute("max health additive penalty")
			player.AddCustomAttribute("max health additive penalty", -(player.GetMaxHealth() * 0.5), -1)
			player.SetHealth(player.GetMaxHealth() * 1.5)
		}
	}
	AddThinkToEnt(dead, null)
	if (dead in customflags) {
		customflags[dead].transformed = false
	}
}
function OnGameEvent_player_hurt(params)
{
	if ("userid" in params) 
	{
	local player = GetPlayerFromUserID(params.userid)
	if (player in customflags && customflags[player].transformed && params.health <= 1) {
	customflags[player].transformed = false
			//local healthratio = player.GetHealth().tofloat() / player.GetMaxHealth().tofloat()
			player.RemoveCond(14)
			player.RemoveCond(64)
			player.RemoveCond(32)
			NetProps.SetPropInt(player, "m_PlayerClass.m_iClass", 8)
			player.RemoveCustomAttribute("max health additive penalty")
			player.RemoveCustomAttribute("damage penalty")
			player.RemoveCustomAttribute("health drain")
			player.Regenerate(true)
			player.AddCondEx(30, 6.0, player)
			player.AddCondEx(14, 3.0, player)
			player.AddCondEx(32, 3.0, player)
			player.AddCondEx(106, 1.5, player)
			//local ind = statlist.find("max health additive penalty")
			//if (ind != null) {
			//statlist.remove(ind)
			//}
			player.RemoveAllObjects(true)
			local rval = 125
			if (healthvalues[player]) {
			//rval = delete healthvalues[player]
			rval = healthvalues[player]
			}
			player.SetHealth(rval)
	}
	}
}

function OnGameEvent_post_inventory_application(params)
{
	if ("userid" in params)
	{
		local player = GetPlayerFromUserID(params.userid)	//grab player ID...

			if (player in customflags) {
 			} else {
			customflags[player] <- {}
			customflags[player].transformed <- false
			}
		
		player.GTFW_Cleanup()	//clean up function, deletes unused weapon entities from GiveWeapon.

		//for (local i = 1 ; i < statlist.len() ; i++) {
		//player.RemoveCustomAttribute(statlist[i])
		//}
		foreach (stat in statlist) {
		player.RemoveCustomAttribute(stat)
		}
		statlist = []
		
		if (player.GetPlayerClass() == Constants.ETFClass.TF_CLASS_SPY)	//If class is Pyro...
		{
			if (player.ReturnWeapon("Your Eternal Reward"))
			{
			player.GiveWeapon("DNA Knife")
		}
		}
	}
}

__CollectEventCallbacks(this, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener)
