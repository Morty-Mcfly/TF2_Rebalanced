/*
Find documentation at:
https://wiki.teamfortress.com/wiki/List_of_item_attributes
https://developer.valvesoftware.com/wiki/VScript
https://developer.valvesoftware.com/wiki/List_of_TF2_Script_Functions

*/

//--------------------------------------------------------------||-------------------------------------------------------------
//script_execute give_tf_weapon/_master
// script_reload_code give_tf_weapon/custom_weapons

//SPY TWEAKS
	//----------------------------------------------------------AMBASSADOR---------------------------------------------------------

		/*
		The Ambassador as-is in vanilla TF2 is pretty undesirable. It takes thousands of hours to master, and is a direct downgrade from stock if you aren't breathing on your opponent

		You should be rewarded for precision, regardless of range, although 102 damage from across the map should only come from Sniper, not Spy (even that's debatable)

		The following changes have been made:

			- Removed critical hit damage falloff
		
		
		
		
		
		
		
		*/

		function Ambassador(weapon, player) {
			weapon.AddAttribute("revolver use hit locations", 1, -1)	//	Use body groups. Allows Ambassador to headshot
			weapon.AddAttribute("damage penalty",0.85,-1)				//	Reduce damage by 15% so headshots do 102 damage
			weapon.AddAttribute("fire rate penalty",0.8,-1)				//	20% slower firing speed
			printl(player.CheckItems())

		}

		RegisterCustomWeapon("Ambassador 2", "Ambassador", false, Ambassador,null, null)	//register the revamped Ambassador

	//-----------------------------------------------------------------------------------------------------------------------------

	//----------------------------------------------------------DEAD RINGER--------------------------------------------------------
		
		/*
		The Dead Ringer as-is in vanilla TF2 is pretty undesirable. The other two invis watches are far more reliable.
		The Dead Ringer is meant to be a tool to trick opponents into thinking you are dead, while you are not. Due to the fact that it has offered absurd damage resistances, its true purpose has been overshadowed by the damage resistance it offers
		The damage resistance it offers has deserves to be there - tricking a player you are dead comes down to be at low health prior to activating feign, which is completely nullified if it kills you anyways


		The following changes have been made:

			- The Dead ringer can now replenish cloak via ammo pickups, dispensers, and payload cart, albeit at a 66% loss
		
		
		Future Changes:
			I think that damage resistance needs to be interpolated - 10% vulnerability at max health, 90% damage resistance at 1 HP (resistance during entire cloak duration, calculated value on attack that triggers feign)
		
		
		
		
		*/

		function DeadRinger(weapon, player) {
			weapon.AddAttribute("set cloak is feign death",1,-1)					// Use the feign cloak type to grant damage resistance, speed, and drop a fake corpse
			weapon.AddAttribute("ReducedCloakFromAmmo",0.33,-1)						// Although Dead Ringer spam was rightfully nerfed, removing the ability to get cloak from ammo was overkill IMO	
			weapon.AddAttribute("cloak_consume_on_feign_death_activate",0,-1)	// Gotta have downsides
			//notice the lack of faster regen and longer cloak duration. The added ability to get cloak from ammo boxes offsets this pretty well IMO

		}

		RegisterCustomWeapon("Dead Ringer 2", "Dead Ringer", false, DeadRinger,null , null)
	//-----------------------------------------------------------------------------------------------------------------------------

	//-----------------------------------------------------------ENFORCER---------------------------------------------------------
		
		/*
		The enforcer, as is, is not very good. It fires slow, and rarely offers a damage bonus as you have to both be disguised and hit the first shot


		The following changes have been made:

			- Added 10% damage buff
			- -33% clip size
			- damage bonus while disguise nerfed from 20% to 10% to counteract damage buff

		
		
		Future Changes:
			I think that damage resistance needs to be interpolated - 10% vulnerability at max health, 90% damage resistance at 1 HP (resistance during entire cloak duration, calculated value on attack that triggers feign)
		
		
		
		
		*/

		function Enforcer(weapon, player) {
			weapon.AddAttribute("dmg pierces resists absorbs",1,-1)				//Damage pierces resitances
			weapon.AddAttribute("damage bonus while disguised",1.1,-1)			//	10% damage bonus while disguised
			weapon.AddAttribute("fire rate penalty",1.2,-1)						//	20% fire rate penalty
			weapon.AddAttribute("crit mod disabled",1,-1)					//	No random critical hits

			weapon.AddAttribute("clip size penalty",0.66,-1)					//	4 rounds per clip
			weapon.AddAttribute("damage bonus",1.1,-1)							//	

			//notice the lack of faster regen and longer cloak duration. The added ability to get cloak from ammo boxes offsets this pretty well IMO

		}

		RegisterCustomWeapon("Enforcer 2", "Enforcer", false, Enforcer, null, null)
	//-----------------------------------------------------------------------------------------------------------------------------




//

//SPY CUSTOM
	//--------------------------------------------------------SILENT STABBER-------------------------------------------------------

		/*
		Kill the enemy, leave no trace 
		silent killer
		*/

		function SilentStabber(weapon, player) {
				weapon.AddAttribute("silent killer",1,-1)				// Silent Killer
				weapon.AddAttribute("disguise on backstab`",1,-1)		// disguise on backstab
				weapon.AddAttribute("damage penalty",0.5,-1)			// Half Damage bleeding duration
				weapon.AddAttribute("bleeding duration",3,-1)			// Half Damage
				weapon.AddAttribute("hit self on miss",10,0)			// Hit yourself on a miss




		}

			RegisterCustomWeapon("Silent Stabber", "Knife", false, SilentStabber, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------


	//----------------------------------------------------BACKSTABBER'S BACKPACK---------------------------------------------------

		/*
		Kill the enemy, leave no trace 
		silent killer
		*/

		function SilentStabber(weapon, player) {
				weapon.AddAttribute("silent killer",1,-1)		// Silent Killer
				weapon.AddAttribute("disguise on backstab`",1,-1)	// disguise on backstab
				weapon.AddAttribute("hit self on miss",1,-1)	// Hit yourself on a miss

		}

			RegisterCustomWeapon("Silent Stabber", "Knife", false, SilentStabber, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------

	































































































//EXTRAS

	//-----------------------------------------------------------------------------
		// That's it! You've finished the tutorial!
		// You can do what ever you want with this script. However, I know I can't tell you what to do, but I can say please think about balancing your stats for your weapons.
		// -> Refer to reddit /r/TF2WeaponIdeas to further understand how to balance your new weapons!
		//-----------------------------------------------------------------------------



		//-----------------------------------------------------------------------------
		// Now that we've got a better ideas on how to make a weapon, let's see more examples.
		// This is more of the deep end!
		// (You can use these examples fully work in-game, too!)
		//-----------------------------------------------------------------------------

		//-----------------------------------------------------------------------------
		// Example weapon #1. This one is the Scout's Medieval Crossbow.
		// It is based off the Crusader's Crossbow. Main stat thing is it slows the player while reloading.
	//-----------------------------------------------------------------------------
	function CW_Stats_Example_Scout_Medieval_Crossbow(weapon, player)
	{
		//Weapon stats
			weapon.AddAttribute("override projectile type", 8, -1)	//shoots Huntsman arrows (that headshot!)
			weapon.AddAttribute("damage penalty", 0.667, -1)		//reduces damage dealt
		
		//This is a think script. What it does is constantly runs in the background, checking for what ever we put in it.
		if( weapon.ValidateScriptScope() )
		{
			const THINK_SCOUTWEAPONRELOAD_DELAY = 0.25	//delay. Place at the end after `return` to change delay time. Default is 0.1.
			
			local entityscript = weapon.GetScriptScope()
			entityscript["think_SlowPlayerDuringReload"] <- function()	//Our script's name.
			{
				if ( NetProps.GetPropInt(weapon, "m_iReloadMode") == 2)	//if we are reloading...
				{
					player.AddCustomAttribute("move speed penalty", 0.67, -1)	//Add attribute that reduces move speed.
				}
				else if ( NetProps.GetPropInt(weapon, "m_iReloadMode") != 2)	//if -not- reloading...
				{
					player.RemoveCustomAttribute("move speed penalty")	//Remove move speed penalty.
				}
				return THINK_SCOUTWEAPONRELOAD_DELAY	//return to top after 0.25 ticks
			}
			AddThinkToEnt(weapon, "think_SlowPlayerDuringReload")	//Adds the think script to handle 'weapon' after it has been validated.
		}
	}

	//-----------------------------------------------------------------------------
	// The following function registers this weapon as "Scout Crossbow".
	// Use `hPlayer.GiveWeapon("Medieval Crossbow")` to give yourself this weapon.
	//-----------------------------------------------------------------------------
		RegisterCustomWeapon("Medieval Crossbow", "Crusader's Crossbow", false, CW_Stats_Example_Scout_Medieval_Crossbow, GTFW_ARMS.MEDIC, null)



	//-----------------------------------------------------------------------------
	// Example weapon #2. This one turns you into the Horseless Headless Horsemann.
	// It is based off the Demo's Headtaker.
	//-----------------------------------------------------------------------------
	function CW_Stats_Example_Headless_Hatman(weapon, player)
	{
	// Setup
		player.SetCustomModelWithClassAnimations("models/player/demo.mdl")	//Needs to be here, else errors.
		NetProps.SetPropInt(player, "m_PlayerClass.m_iClass", 4)			//Forcefully sets tfclass to DEMOMAN
		
	//Our stats
		weapon.AddAttribute("hidden maxhealth non buffed", (player.GetMaxHealth()*10) + 75, -1)	//using this attribute because it can't be overhealed
		player.SetHealth(player.GetMaxHealth())				//set health to max after given maxhealth bonus
		weapon.AddAttribute("move speed bonus", 1.25, -1)	//move speed up
		weapon.AddAttribute("damage bonus", 99, -1)			//instant death
		weapon.AddAttribute("melee range multiplier", 2, -1)//longer melee range
		weapon.AddAttribute("melee bounds multiplier", 2, -1)//larger melee range
		
		player.DeleteWeapon(TF_WEAPONSLOTS.PRIMARY)		//deletes primary weapon
		player.DeleteWeapon(TF_WEAPONSLOTS.SECONDARY)		//deletes secondary weapon
		player.DeleteWeapon(player.ReturnWeapon(-3))		//deletes anything not primary, secondary, or melee
		player.DeleteWeapon(player.ReturnWeapon(-4))		//deletes anything not primary, secondary, or melee
		player.DeleteWeapon(player.ReturnWeapon(-5))		//deletes anything not primary, secondary, or melee
		player.DeleteWeapon(player.ReturnWeapon(-6))		//deletes anything not primary, secondary, or melee
		
	// Our effects
		player.SetForcedTauntCam(1)										//sets third person mode
		DoEntFire("!self", "SetModelScale", "1.3", 0, null, player)		//sets player scale
		Convars.SetValue("tf_item_based_forced_holiday", 2)				//Forces holiday to Halloween
		player.AddCustomAttribute("SPELL: set Halloween footstep type", 2, -1)	//enables Horseless Horseshoes spell walk flames
		player.AddCustomAttribute("set item tint RGB", 9109759, -1)		//sets tint for Horseless Horseshoes
		
	// Deletes all cosmetics from the player
		for (local i = 0; i < 42; i++)
		{
			local wearable = Entities.FindByClassname(null, "tf_*")

			if ( wearable != null && wearable.GetOwner() == player && wearable.GetClassname() != "tf_weapon_sword" && wearable.GetClassname() != "tf_viewmodel" && wearable.Name() != "tf_wearable_vscript" )
			{
				wearable.Kill()
			}
			else
			{
				break
			}
		}
	// Think script, used to remove stats from the player if the weapon disappears from loadout.
		if( player.ValidateScriptScope() )
		{
			const DELAY_THINK_STOP = 999
			const DELAY_THINK = 1
			local truefalse = true
			local entityscript = player.GetScriptScope()
			entityscript["think_HHHH_Maker"] <- function()	//Our script's name.
			{
				if ( truefalse ) {
					truefalse = false
					player.Weapon_Switch(weapon)		//vscript built-in function. Forces switch to handle 'weapon'.
					player.AddCond(41)					//locks player in melee
					return DELAY_THINK
				}
				if ( player.GetActiveWeapon() != weapon ) {	//if we unequip this weapon, force us the shapeshift back to Demoman.
					player.SetForcedTauntCam(0)
					DoEntFire("!self", "SetModelScale", "1", 0, null, player)
					player.RemoveCustomAttribute("SPELL: set Halloween footstep type")
					player.RemoveCustomAttribute("set item tint RGB")
					player.Regenerate(false)
					return DELAY_THINK_STOP	//can't stop a think script within a think script, so we delay it until oblivion
				}
				return
			}
			AddThinkToEnt(player, "think_HHHH_Maker")	//Adds the think script to handle 'weapon' after it has been validated.
		}
	}

	//-----------------------------------------------------------------------------
	// Using an enum for define model paths
	//-----------------------------------------------------------------------------
	/* Tip: You can use an enum like this to create shortcuts for your coding. */
	enum GTFW_MODELS_CUSTOM_WEAPONS
	{
		HHH_BIGAXE		= "models/weapons/c_models/c_bigaxe/c_bigaxe.mdl",	//Horsemann's REAL Headtaker
		HHH_BIGMALLET		= "models/weapons/c_models/c_big_mallet/c_big_mallet.mdl", //Horsemann's Mallet
	}
	//-----------------------------------------------------------------------------
	// Precaching models
	//-----------------------------------------------------------------------------
	//PrecacheModel("models/weapons/c_models/c_bigaxe/c_bigaxe.mdl")
	//PrecacheModel("models/weapons/c_models/c_big_mallet/c_big_mallet.mdl")

	//Use this function to precache models, so the game preloads them and doesn't crash.
	//Not needed if using SetModelSimple function (which precaches for you)

	//-----------------------------------------------------------------------------
	//Registers this weapon as "Horsemann's Hex"...
	// Notice we are using "RegisterCustomWeaponEx()" with "Ex" at the end. This has more properties for us to toy with!
	//-----------------------------------------------------------------------------
		RegisterCustomWeaponEx("Horsemann's Hex", "HHHH", false, CW_Stats_Example_Headless_Hatman, GTFW_ARMS.DEMO, GTFW_MODELS_CUSTOM_WEAPONS.HHH_BIGAXE, null, "models/bots/headless_hatman.mdl", TF_AMMO.NONE, -1, -1)




	//-----------------------------------------------------------------------------
	// Example weapon #3. A Hot Hand variant that lets you shoot fireballs by taunting!
	// Hadouken!
	//-----------------------------------------------------------------------------
	function CW_Stats_Example_Hottest_Hand(weapon, player)
	{
		weapon.AddAttribute("special taunt", 1, -1) //Makes sure that Halloween holiday can't make us not use the taunt kill+fireball.
		
	//Function to create a fireball, but only usable from within CW_Stats_Example_Hottest_Hand
		CTFPlayer.ShootFireball <- function()
		{
			local fireball = Entities.CreateByClassname("tf_projectile_spellfireball")
			
			fireball.SetOwner(this)
			NetProps.SetPropInt(fireball, "m_iTeamNum", this.GetTeam())
			fireball.SetLocalOrigin(this.EyePosition()+(this.EyeAngles().Forward()*32) + Vector(0,0,this.EyeAngles().z-16))
			fireball.SetLocalAngles(this.EyeAngles())
			fireball.SetAbsVelocity(this.EyeAngles().Forward()*800)

			Entities.DispatchSpawn(fireball)
		}
		
	//Uses a think script to check for when the Pyro is 1) Has the HotHand and 2) Is taunting
		if( weapon.ValidateScriptScope() )
		{
			local wep = null
			local CAN_TAUNT_WITH_HOTHAND = false
		
			local entityscript = weapon.GetScriptScope()
			entityscript["think_PyroHottestHand"] <- function()	//Our script's name.
			{
				if ( player.InCond(7) && CAN_TAUNT_WITH_HOTHAND ) {	//IF taunting and while CAN_TAUNT_WITH_HOTHAND is True...
					CAN_TAUNT_WITH_HOTHAND = false
					wep = null
					
					DoEntFire("!self", "RunScriptCode", "self.ShootFireball()", 1.9, null, player)
				}
				else if ( player.GetActiveWeapon() != null && !player.InCond(7) && player.GetActiveWeapon() != wep )	// if player switches weapons...
				{
					wep = player.GetActiveWeapon()	//...make it so they don't run this condition again!
					
					if ( player.GetActiveWeapon().GetClassname() == "tf_weapon_slap" ) {	//if player is holding the hothand...
						CAN_TAUNT_WITH_HOTHAND = true	//...set to true for checking taunting with Hot Hand
					}
				}
				if ( player.GetActiveWeapon() != null && player.GetActiveWeapon().GetClassname() == "tf_weapon_slap" ) {
					player.AddCondEx(37, 0.15, player) //First-blood arena crit-boost. Constantly applies so if the weapon is gone the conditions don't stay.
				}
				else	//if not using Hot Hand
				{
					player.RemoveCond(37)
				}
				return	//uses default 0.1 delay
			}
			AddThinkToEnt(weapon, "think_PyroHottestHand")	//Adds the think script to handle 'weapon' after it has been validated.
		}
	}
	//-----------------------------------------------------------------------------
	// Finally, registers the weapon for us to use with GiveWeapon()!
	//-----------------------------------------------------------------------------
		RegisterCustomWeapon("Hottest Hand", "Hot Hand", true, CW_Stats_Example_Hottest_Hand, null, null)
		
		
	//-----------------------------------------------------------------------------
	// End Examples. I hope this helps explain how to use this script better.
	// Contact me to tell me if it helped or not!
	// And... Have fun making weapons in VScript!
	//-----------------------------------------------------------------------------
//
