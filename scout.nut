function smugSlugger(weapon, player)
{
weapon.AddAttribute("weapon spread bonus", 0.5, -1)
weapon.AddAttribute("bullets per shot bonus", 0.1, -1)
weapon.AddAttribute("damage bonus", 11, -1)
weapon.AddAttribute("mult_spread_scales_consecutive", 11, -1)


}
RegisterCustomWeapon("SmugSlugger", "Scattergun", false, smugSlugger, null, null)	//register the weapon
