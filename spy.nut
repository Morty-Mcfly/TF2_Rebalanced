/*
	References:
		https://wiki.teamfortress.com/wiki/List_of_item_attributes
		https://developer.valvesoftware.com/wiki/VScript
		https://developer.valvesoftware.com/wiki/List_of_TF2_Script_Functions
		https://developer.valvesoftware.com/wiki/Squirrel
		1 tick is half a second
*/

//--------------------------------------------------------------||-------------------------------------------------------------
	//	script_execute give_tf_weapon/_master
	//	script_reload_code give_tf_weapon/spy
	//	script GetListenServerHost().GiveWeapon("My Weapon Here")
	//	script_execute give_tf_weapon/_master

	//	script GetListenServerHost().GiveWeapon("Ambassador 2")
	//	script GetListenServerHost().GiveWeapon("Dead Ringer 2")
	//bot -name "test dummy" -class soldier -team red

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
			weapon.AddAttribute("fire rate penalty",1.2,-1)				//	20% slower firing speed


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

			- The Dead ringer can now replenish cloak via ammo pickups, dispensers, and payload cart, albeit at a 90% loss


		Future Changes:
			I think that damage resistance needs to be interpolated - 10% vulnerability at max health, 90% damage resistance at 1 HP (resistance during entire cloak duration, calculated value on attack that triggers feign)




		*/

		function DeadRinger(weapon, player)
		{
			weapon.AddAttribute("set cloak is feign death",1,-1)
			weapon.AddAttribute("ReducedCloakFromAmmo",0.25,-1)
			weapon.AddAttribute("cloak consume rate decreased",0.5,-1)
			weapon.AddAttribute("mult cloak meter regen rate",1.5,-1)
			//notice the lack of faster regen and longer cloak duration. The added ability to get cloak from ammo boxes offsets this pretty well IMO
			// printl(player.ReturnWeapon("Conniver's Kunai")==null)

			if(player.ReturnWeapon("Conniver's Kunai")!=null) {
				weapon.AddAttribute("max health additive penalty",-5,-1)
			}

			if(player.ReturnWeapon("YER")) {


				weapon.RemoveAttribute("mult cloak meter regen rate")
				weapon.AddAttribute("NoCloakWhenCloaked", 1, -1)
				weapon.AddAttribute("mult cloak meter regen rate",2,-1)
			}


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



//SPY CUSTOM
	//--------------------------------------------------------SILENT STABBER-------------------------------------------------------

		//	script GetListenServerHost().GiveWeapon("Silent Stabber")

		/*
		Kill the enemy, leave no trace
		silent killer
		*/

		function SilentStabber(weapon, player)
		{
				weapon.AddAttribute("silent killer",1,-1)					// Silent Killer
				weapon.AddAttribute("disguise on backstab",1,-1)			// disguise on backstab(TEST)
				weapon.AddAttribute("bleeding duration",3,-1)					// Half Damage
				weapon.AddAttribute("hit self on miss",1,0)						// Hit yourself on a miss
				weapon.AddAttribute("mod_disguise_consumes_cloak",1,0)			// Consume cloak on disguise
		}

			RegisterCustomWeapon("Silent Stabber", "Knife", false, SilentStabber, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------


	//----------------------------------------------------BACKSTABBER'S BACKPACK---------------------------------------------------

		//	script GetListenServerHost().GiveWeapon("Backstabbers Backpack")

		/*

		*/

		function BackstabbersBackpack(weapon, player) {


			// const DAMAGE_RESISTANCE = 0.1	//10%
			weapon.AddAttribute("mult cloak meter regen rate",1.2,-1)						//	+20% cloak regen rate
			weapon.AddAttribute("health regen",4,-1)										//	+X health regenerated per second on wearer


			weapon.AddAttribute("dmg taken from fire reduced",0.7,-1)					//	+X% fire damage resistance on wearer
			weapon.AddAttribute("dmg taken from bullet reduced",0.7,-1)					//	+X% critical hit damage resistance on wearer
			weapon.AddAttribute("dmg taken from blast reduced",0.7,-1)					//	+X% explosive damage resistance on wearer

			if(player.ReturnWeapon("Dead Ringer"))
			{
				weapon.AddAttribute("mod_cloak_no_regen_from_items", 1, -1)

			}
			else
			{
				weapon.AddAttribute("SET BONUS: cloak blink time penalty", 0.2, -1)
			}







		}

			RegisterCustomWeapon("Backstabbers Backpack", "Red-Tape", false, BackstabbersBackpack, null, null)	//register the weapon

	//-----------------------------------------------------------------------------------------------------------------------------







	//------------------------------------------------------------Big Kill-----------------------------------------------------------

		function Big_Kill(weapon, player)
		{
			weapon.AddAttribute("weapon spread bonus", 0.1, -1)
			weapon.AddAttribute("scattergun has knockback", 1, -1)
			weapon.AddAttribute("damage bonus", 5.7, -1)
			weapon.AddAttribute("fire rate penalty", 0.7, -1)

			weapon.AddAttribute("bullets per shot bonus", 0.1, -1)
			weapon.AddAttribute("scattergun no reload single", 1, -1)//0.143
			weapon.AddAttribute("Reload time decreased", 0.5, -1)
			// weapon.AddAttribute("damage penalty", 0.143, -1)
		}
		//models.weapons.c_models.c_ttg_sam_gun.c_ttg_sam_gun.mdl
		RegisterCustomWeapon("BK", "Scattergun", false, Big_Kill, null, null)	//register the weapon






	//----------------------------------------------------Auto update inventory------------------------------------------------------









	function OnGameEvent_post_inventory_application(params)
	//when we update our inventory...
	{
		if ("userid" in params)//and we can confirm a player is resupplying...
		{
			local player = GetPlayerFromUserID(params.userid)
			if (player.GetPlayerClass() == Constants.ETFClass.TF_CLASS_SPY)	//and they are a spy...
			{
				if (player.ReturnWeapon("Dead Ringer"))//If they have the Dead Ringer equipped...
				{
					player.GiveWeapon("Dead Ringer 2")	//give them the new version
				}

				if (player.ReturnWeapon("Ambassador"))//If they have the Ambassador equipped..
				{
					player.GiveWeapon("Ambassador 2")//give them the new version
				}
				if (player.ReturnWeapon("Enforcer"))//If they have the Ambassador equipped..
				{
					player.GiveWeapon("Enforcer 2")//give them the new version
				}
				if (player.ReturnWeapon("Diamondback"))//If they have the Ambassador equipped..
				{
					player.GiveWeapon("BK")//give them the new version
				}

				if (player.ReturnWeapon("Connivers Kunai"))//If they have the Ambassador equipped..
				{
					player.GiveWeapon("Kunai")//give them the new version
				}
				if(player.ReturnWeapon("Red-Tape Recorder") )
				{
					local weapon = player.ReturnWeapon("Red-Tape Recorder")
					weapon.AddAttribute("sapper health bonus",2.5,-1)
					weapon.AddAttribute("sapper damage penalty",3,-1)
					weapon.RemoveAttribute("sapper degenerates buildings")
					weapon.AddAttribute("sapper damage leaches health",3,-1)
				}
				if(player.ReturnWeapon("Sapper"))
				{
				}



			}
		}
	}
	// __CollectEventCallbacks(this, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener)//Hookonto game events



