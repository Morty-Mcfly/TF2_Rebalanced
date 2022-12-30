/*
Find documentation at:
https://wiki.teamfortress.com/wiki/List_of_item_attributes
https://developer.valvesoftware.com/wiki/VScript
https://developer.valvesoftware.com/wiki/List_of_TF2_Script_Functions

*/

//--------------------------------------------------------------||-------------------------------------------------------------
//	script_execute give_tf_weapon/_master
//	script_reload_code give_tf_weapon/custom_weapons
//	script GetListenServerHost().GiveWeapon("My Weapon Here")
//script_execute give_tf_weapon/_master;script GetListenServerHost().GiveWeapon("Ambassador 2");script GetListenServerHost().GiveWeapon("Dead Ringer 2")
//SPY TWEAKS
	//----------------------------------------------------------AMBASSADOR---------------------------------------------------------
		//	script GetListenServerHost().GiveWeapon("Ambassador 2")
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
			// printl(player.CheckItems())

		}

		RegisterCustomWeapon("Ambassador 2", "Ambassador", false, Ambassador,null, null)	//register the revamped Ambassador

	//-----------------------------------------------------------------------------------------------------------------------------

	//----------------------------------------------------------DEAD RINGER--------------------------------------------------------
		//	script GetListenServerHost().GiveWeapon("Dead Ringer 2")
		
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
			weapon.AddAttribute("ReducedCloakFromAmmo",0.1,-1)						// Although Dead Ringer spam was rightfully nerfed, removing the ability to get cloak from ammo was overkill IMO	
			weapon.AddAttribute("cloak_consume_on_feign_death_activate",0.8,-1)	// Gotta have downsides
			//notice the lack of faster regen and longer cloak duration. The added ability to get cloak from ammo boxes offsets this pretty well IMO

		}

		RegisterCustomWeapon("Dead Ringer 2", "Dead Ringer", false, DeadRinger,null , null)
	//-----------------------------------------------------------------------------------------------------------------------------

	//-----------------------------------------------------------ENFORCER---------------------------------------------------------
		
		/*
		//	script GetListenServerHost().GiveWeapon("Enforcer 2")
		

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

		//	script GetListenServerHost().GiveWeapon("Silent Stabber")

		/*
		Kill the enemy, leave no trace 
		silent killer
		*/

		function SilentStabber(weapon, player) {
				weapon.AddAttribute("silent killer",1,-1)				// Silent Killer
				weapon.AddAttribute("disguise on backstab",1,-1)		// disguise on backstab(TEST)
				weapon.AddAttribute("damage penalty",0.1,-1)			// Half Damage bleeding duration
				weapon.AddAttribute("bleeding duration",3,-1)			// Half Damage
				weapon.AddAttribute("hit self on miss",1,0)			// Hit yourself on a miss
				weapon.AddAttribute("mod_disguise_consumes_cloak",1,0)			// Hit yourself on a miss





		}

			RegisterCustomWeapon("Silent Stabber", "Wanga Prick", false, SilentStabber, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------


	//----------------------------------------------------BACKSTABBER'S BACKPACK---------------------------------------------------

		//	script GetListenServerHost().GiveWeapon("Backstabbers Backpack")

		/*
		
		*/

		function BackstabbersBackpack(weapon, player) {
			// const DAMAGE_RESISTANCE = 0.1	//10%
			weapon.AddAttribute("cloak meter regen rate",20,-1)						//	+X% cloak regen rate
			weapon.AddAttribute("health regen",4,-1)										//	+X health regenerated per second on wearer
			

			weapon.AddAttribute("dmg taken from fire reduced",0.7,-1)					//	+X% fire damage resistance on wearer
			weapon.AddAttribute("dmg taken from crit reduced",0.7,-1)					//	+X% critical hit damage resistance on wearer
			weapon.AddAttribute("dmg taken from blast reduced",0.7,-1)					//	+X% explosive damage resistance on wearer
			weapon.AddAttribute("dmg taken from bulets reduced",0.7,-1)					//	+X% bullet damage resistance on wearer
			
			weapon.AddAttribute("cloak regen rate decreased",1,-1)					//	+X% bullet damage resistance on wearer






		}

			RegisterCustomWeapon("Backstabbers Backpack", "Sapper", true, BackstabbersBackpack, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------

	

	
































































































