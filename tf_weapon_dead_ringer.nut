
/*
console commands:
	script_execute give_tf_weapon/_master
	script_reload_code give_tf_weapon/tf_weapon_dead_ringer

	script GetListenServerHost().GiveWeapon("My Weapon Here")
	script_execute give_tf_weapon/_master
	bot -name "test dummy" -class soldier -team red
References:
	https://wiki.alliedmods.net/Team_Fortress_2_Events
	https://wiki.teamfortress.com/wiki/List_of_item_attributes
	https://developer.valvesoftware.com/wiki/VScript
	https://developer.valvesoftware.com/wiki/List_of_TF2_Script_Functions
	https://developer.valvesoftware.com/wiki/Squirrel
*/


function tf_weapon_dead_ringer(weapon, player)
{
	//Basic weapon attributes

	weapon.AddAttribute("set cloak is feign death",1,-1)					// Use the feign cloak type to grant damage resistance, speed, and drop a fake corpse
	weapon.AddAttribute("ReducedCloakFromAmmo",0.1,-1)						// Although Dead Ringer spam was rightfully nerfed, removing the ability to get cloak from ammo was overkill IMO
	weapon.AddAttribute("cloak_consume_on_feign_death_activate",0.8,-1)		// Gotta have downsides

	if(player.ValidateScriptScope())
	{
		//m_bFeignDeathReady
		const DELAY_THINK = 1


		local entityscript = player.GetScriptScope()


		entityscript["think_Transform"] <- function()	//Our script's name.
		{

			// NetProps.GetPropBool(handle entity, "m_bFeignDeathReady")
			printl(NetProps.GetPropBool(weapon, "m_bFeignDeathReady"))
			return DELAY_THINK
		}
		AddThinkToEnt(player, "think_Transform")
		AddThinkToEnt(weapon, "think_task")

	}



}
RegisterCustomWeapon("Dead Ringer 2", "Dead Ringer", false, tf_weapon_dead_ringer,null , null)
function OnGameEvent_player_hurt(params)
{
	if ("userid" in params)
	{
		local player = GetPlayerFromUserID(params.userid)
		if(player.ReturnWeapon("Your Eternal Reward"))
		{

			player.SetHealth(player.GetHealth())
		}
	}
}
function OnGameEvent_post_inventory_application(params)
{
	if ("userid" in params)
	{
		local player = GetPlayerFromUserID(params.userid)
		if (player.GetPlayerClass() == Constants.ETFClass.TF_CLASS_SPY)	//If class is Pyro...
		{
			if (player.ReturnWeapon("Dead Ringer"))
			{
				player.GiveWeapon("Dead Ringer 2")
			}

			if (player.ReturnWeapon("Ambassador"))
			{
				player.GiveWeapon("Ambassador 2")
			}
			if (player.ReturnWeapon("Diamondback"))
			{
				player.GiveWeapon("Ambassador 2")
			}
		}
		}
	}
}
__CollectEventCallbacks(this, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener)
printl("I was here")
