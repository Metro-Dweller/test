//-------------------------------------------------------
//SNIPER RIFLES
//Keyword rifles. They are subtype of rifles, but still contained here as a specialist weapon.

/obj/item/ammo_magazine/sniper
	name = "\improper M42A marksman magazine (10x28mm Caseless)"
	desc = "A magazine of sniper rifle ammo."
	caliber = "10x28mm"
	icon_state = "m42c" //PLACEHOLDER
	max_rounds = 15
	default_ammo = /datum/ammo/bullet/sniper
	gun_type = /obj/item/weapon/gun/rifle/sniper/M42A

	New()
		..()
		reload_delay = config.low_fire_delay

/obj/item/ammo_magazine/sniper/incendiary
	name = "\improper M42A incendiary magazine (10x28mm)"
	default_ammo = /datum/ammo/bullet/sniper/incendiary

/obj/item/ammo_magazine/sniper/flak
	name = "\improper M42A flak magazine (10x28mm)"
	default_ammo = /datum/ammo/bullet/sniper/flak

//Because this parent type did not exist
//Note that this means that snipers will have a slowdown of 3, due to the scope
/obj/item/weapon/gun/rifle/sniper
	aim_slowdown = SLOWDOWN_ADS_SPECIALIST
	gun_skill_category = GUN_SKILL_SPEC

	able_to_fire(mob/living/user)
		. = ..()
		if(. && istype(user)) //Let's check all that other stuff first.
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.spec_weapons < SKILL_SPEC_TRAINED && user.mind.cm_skills.spec_weapons != SKILL_SPEC_SNIPER)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0

//Pow! Headshot.
/obj/item/weapon/gun/rifle/sniper/M42A
	name = "\improper M42A scoped rifle"
	desc = "A heavy sniper rifle manufactured by Armat Systems. It has a scope system and fires armor penetrating rounds out of a 15-round magazine.\n'Peace Through Superior Firepower'"
	icon_state = "m42a"
	item_state = "m42a"
	origin_tech = "combat=6;materials=5"
	fire_sound = 'sound/weapons/gun_sniper.ogg'
	current_mag = /obj/item/ammo_magazine/sniper
	force = 12
	wield_delay = 12 //Ends up being 1.6 seconds due to scope
	zoomdevicename = "scope"
	attachable_allowed = list(/obj/item/attachable/bipod)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_SPECIALIST

	New()
		select_gamemode_skin(type, list(/datum/game_mode/ice_colony = "s_m42a") )
		..()
		accuracy += config.low_hit_accuracy_mult
		recoil = config.min_recoil_value
		fire_delay = config.high_fire_delay*4
		burst_amount = config.min_burst_value
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 12, "rail_y" = 20, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
		var/obj/item/attachable/scope/S = new(src)
		S.icon_state = "" //Let's make it invisible. The sprite already has one.
		S.flags_attach_features &= ~ATTACH_REMOVABLE
		S.Attach(src)
		var/obj/item/attachable/sniperbarrel/Q = new(src)
		Q.Attach(src)
		update_attachables()

/obj/item/weapon/gun/rifle/sniper/M42A/jungle //These really should just be skins.
	name = "\improper M42A marksman rifle"
	icon_state = "m_m42a" //NO BACK STATE
	item_state = "m_m42a"

/obj/item/ammo_magazine/rifle/marksman
	name = "\improper A19 high velocity magazine (10x24mm)"
	desc = "A magazine of A19 high velocity rounds for use in the M4RA battle rifle. The M4RA battle rifle is the only gun that can chamber these rounds."
	default_ammo = /datum/ammo/bullet/rifle/marksman
	max_rounds = 15
	gun_type = /obj/item/weapon/gun/rifle/m41a/scoped

/obj/item/weapon/gun/rifle/m41a/scoped
	name = "\improper M4RA battle rifle"
	desc = "The M4RA battle rifle is a designated rifle in service with the USCM. Only fielded in small numbers, and sporting a bullpup configuration, the M4RA battle rifle is perfect for reconnaissance and fire support teams.\nIt is equipped with rail scope and can take the 10x24mm marksman magazine in addition to regular MK2 magazines."
	icon_state = "m41b"
	item_state = "m4ra" //PLACEHOLDER
	origin_tech = "combat=5;materials=4"
	fire_sound = list('sound/weapons/gun_m4ra.ogg')
	current_mag = /obj/item/ammo_magazine/rifle/marksman
	force = 16
	attachable_allowed = list(
						/obj/item/attachable/suppressor,
						/obj/item/attachable/foregrip,
						/obj/item/attachable/bipod,
						/obj/item/attachable/compensator,
						/obj/item/attachable/burstfire_assembly)

	flags_gun_features = GUN_SPECIALIST
	gun_skill_category = GUN_SKILL_SPEC

	New()
		..()
		accuracy += config.med_hit_accuracy_mult
		recoil = config.min_recoil_value
		fire_delay = config.high_fire_delay
		var/obj/item/attachable/scope/S = new(src)
		S.icon_state = null //Rifle already has a nice looking scope sprite.
		S.flags_attach_features &= ~ATTACH_REMOVABLE //Don't want it coming off.
		S.Attach(src)
		var/obj/item/attachable/stock/rifle/marksman/Q = new(src) //Already cannot be removed.
		Q.Attach(src)
		var/obj/item/attachable/G = under //We'll need this in a sec.
		G.Detach(src) //This will null the attachment slot.
		cdel(G) //So without a temp variable, this wouldn't work.
		update_attachables()

	able_to_fire(mob/living/user)
		. = ..()
		if (. && istype(user)) //Let's check all that other stuff first.
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.spec_weapons < SKILL_SPEC_TRAINED && user.mind.cm_skills.spec_weapons != SKILL_SPEC_SCOUT)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0

/obj/item/ammo_magazine/sniper/elite
	name = "\improper M42C marksman magazine (10x99mm)"
	default_ammo = /datum/ammo/bullet/sniper/elite
	gun_type = /obj/item/weapon/gun/rifle/sniper/elite
	caliber = "10x99mm"
	icon_state = "m42c"
	max_rounds = 6

/obj/item/weapon/gun/rifle/sniper/elite
	name = "\improper M42C anti-tank sniper rifle"
	desc = "A high end mag-rail heavy sniper rifle from Weyland-Armat chambered in the heaviest ammo available, 10x99mm Caseless."
	icon_state = "m42c"
	item_state = "m42c" //NEEDS A TWOHANDED STATE
	origin_tech = "combat=7;materials=5"
	fire_sound = 'sound/weapons/sniper_heavy.ogg'
	current_mag = /obj/item/ammo_magazine/sniper/elite
	force = 17
	zoomdevicename = "scope"
	attachable_allowed = list()
	flags_gun_features = GUN_AUTO_EJECTOR|GUN_WY_RESTRICTED|GUN_SPECIALIST

	New()
		..()
		accuracy += config.max_hit_accuracy_mult
		recoil = config.max_recoil_value
		fire_delay = config.high_fire_delay*5
		burst_amount = config.min_burst_value
		attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 18,"rail_x" = 15, "rail_y" = 19, "under_x" = 20, "under_y" = 15, "stock_x" = 20, "stock_y" = 15)
		var/obj/item/attachable/scope/S = new(src)
		S.icon_state = "pmcscope"
		S.flags_attach_features &= ~ATTACH_REMOVABLE
		S.Attach(src)
		var/obj/item/attachable/sniperbarrel/Q = new(src)
		Q.Attach(src)
		update_attachables()

	simulate_recoil(total_recoil = 0, mob/user, atom/target)
		. = ..()
		if(.)
			var/mob/living/carbon/human/PMC_sniper = user
			if(PMC_sniper.lying == 0 && !istype(PMC_sniper.wear_suit,/obj/item/clothing/suit/storage/marine/smartgunner/veteran/PMC) && !istype(PMC_sniper.wear_suit,/obj/item/clothing/suit/storage/marine/veteran))
				PMC_sniper.visible_message("<span class='warning'>[PMC_sniper] is blown backwards from the recoil of the [src]!</span>","<span class='highdanger'>You are knocked prone by the blowback!</span>")
				step(PMC_sniper,turn(PMC_sniper.dir,180))
				PMC_sniper.KnockDown(5)

//SVD //Based on the actual Dragunov sniper rifle.
/obj/item/ammo_magazine/rifle/sniper/svd
	name = "\improper SVD magazine (7.62x54mmR)"
	desc = "A large caliber magazine for the SVD sniper rifle."
	caliber = "7.62x54mmR"
	icon_state = "svd003"
	default_ammo = /datum/ammo/bullet/sniper
	max_rounds = 10
	gun_type = /obj/item/weapon/gun/rifle/sniper/svd

/obj/item/weapon/gun/rifle/sniper/svd
	name = "\improper SVD Dragunov-033 sniper rifle"
	desc = "A sniper variant of the MAR-40 rifle, with a new stock, barrel, and scope. It doesn't have the punch of modern sniper rifles, but it's finely crafted in 2133 by someone probably illiterate. Fires 7.62x54mmR rounds."
	icon_state = "svd003"
	item_state = "svd003" //NEEDS A ONE HANDED STATE
	origin_tech = "combat=5;materials=3;syndicate=5"
	fire_sound = 'sound/weapons/gun_kt42.ogg'
	current_mag = /obj/item/ammo_magazine/rifle/sniper/svd
	type_of_casings = "cartridge"
	attachable_allowed = list(
						/obj/item/attachable/reddot,
						/obj/item/attachable/foregrip,
						/obj/item/attachable/gyro,
						/obj/item/attachable/flashlight,
						/obj/item/attachable/bipod,
						/obj/item/attachable/magnetic_harness,
						/obj/item/attachable/scope/slavic)

	flags_gun_features = GUN_AUTO_EJECTOR|GUN_ON_MERCS|GUN_ON_RUSSIANS|GUN_SPECIALIST

	New()
		..()
		accuracy -= config.low_hit_accuracy_mult
		recoil = config.min_recoil_value
		fire_delay = config.mhigh_fire_delay*2
		burst_amount = config.low_burst_value
		attachable_offset = list("muzzle_x" = 32, "muzzle_y" = 17,"rail_x" = 13, "rail_y" = 19, "under_x" = 24, "under_y" = 13, "stock_x" = 24, "stock_y" = 13)
		var/obj/item/attachable/S = new /obj/item/attachable/scope/slavic(src)
		S.Attach(src)
		S = new /obj/item/attachable/slavicbarrel(src)
		S.Attach(src)
		S = new /obj/item/attachable/stock/slavic(src)
		S.flags_attach_features &= ~ATTACH_REMOVABLE
		S.Attach(src)
		update_attachables()

//-------------------------------------------------------
//SMARTGUN
/obj/item/ammo_magazine/internal/smartgun
	name = "integrated smartgun belt"
	caliber = "10x28mm"
	max_rounds = 50 //Should be 500 in total.
	default_ammo = /datum/ammo/bullet/smartgun

//Come get some.
/obj/item/weapon/gun/smartgun
	name = "\improper M56B smartgun"
	desc = "The actual firearm in the 4-piece M56B Smartgun System. Essentially a heavy, mobile machinegun.\nReloading is a cumbersome process requiring a powerpack. Click the powerpack icon in the top left to reload.\nYou may toggle firing restrictions by using a special action."
	icon_state = "m56"
	item_state = "m56"
	origin_tech = "combat=6;materials=5"
	fire_sound = "gun_smartgun"
	current_mag = /obj/item/ammo_magazine/internal/smartgun
	flags_equip_slot = NOFLAGS
	w_class = 5
	force = 20
	wield_delay = 16
	aim_slowdown = SLOWDOWN_ADS_SPECIALIST
	var/datum/ammo/ammo_secondary = /datum/ammo/bullet/smartgun/lethal//Toggled ammo type
	var/shells_fired_max = 20 //Smartgun only; once you fire # of shells, it will attempt to reload automatically. If you start the reload, the counter resets.
	var/shells_fired_now = 0 //The actual counter used. shells_fired_max is what it is compared to.
	var/restriction_toggled = 1 //Begin with the safety on.
	flags_atom = FPRINT|CONDUCT|TWOHANDED
	gun_skill_category = GUN_SKILL_SMARTGUN
	attachable_allowed = list(
						/obj/item/attachable/heavy_barrel,
						/obj/item/attachable/burstfire_assembly)

	flags_gun_features = GUN_INTERNAL_MAG|GUN_SPECIALIST


	New()
		..()
		ammo_secondary = ammo_list[ammo_secondary]
		accuracy += config.min_hit_accuracy_mult
		fire_delay = config.low_fire_delay
		burst_amount = config.med_burst_value
		burst_delay = config.min_fire_delay
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 16,"rail_x" = 17, "rail_y" = 19, "under_x" = 22, "under_y" = 14, "stock_x" = 22, "stock_y" = 14)

	examine(mob/user)
		..()
		user << "[current_mag.current_rounds ? "Ammo counter shows [current_mag.current_rounds] round\s remaining." : "It's dry."]"
		user << "The restriction system is [restriction_toggled ? "<B>on</b>" : "<B>off</b>"]."

	unique_action(mob/user)
		toggle_restriction(user)

	able_to_fire(mob/living/user)
		. = ..()
		if(.)
			if(!ishuman(user)) return 0
			var/mob/living/carbon/human/H = user
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.smartgun < SKILL_SMART_USE)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0
			if ( !istype(H.wear_suit,/obj/item/clothing/suit/storage/marine/smartgunner) || !istype(H.back,/obj/item/smartgun_powerpack))
				click_empty(H)
				return 0


	load_into_chamber(mob/user)
		if(active_attachable) active_attachable = null
		return ready_in_chamber()

	reload_into_chamber(mob/user)
		var/mob/living/carbon/human/smart_gunner = user
		var/obj/item/smartgun_powerpack/power_pack = smart_gunner.back
		if(istype(power_pack)) //I don't know how it would break, but it is possible.
			if(shells_fired_now >= shells_fired_max && power_pack.rounds_remaining > 0) // If shells fired exceeds shells needed to reload, and we have ammo.
				auto_reload(smart_gunner, power_pack)
			else shells_fired_now++

		return current_mag.current_rounds

	delete_bullet(obj/item/projectile/projectile_to_fire, refund = 0)
		cdel(projectile_to_fire)
		if(refund) current_mag.current_rounds++
		return 1

/obj/item/weapon/gun/smartgun/proc/toggle_restriction(mob/user)
	user << "\icon[src] You [restriction_toggled? "<B>disable</b>" : "<B>enable</b>"] the [src]'s fire restriction. You will [restriction_toggled ? "harm anyone in your way" : "target through IFF"]."
	playsound(loc,'sound/machines/click.ogg', 25, 1)
	var/A = ammo
	ammo = ammo_secondary
	ammo_secondary = A
	restriction_toggled = !restriction_toggled

/obj/item/weapon/gun/smartgun/proc/auto_reload(mob/smart_gunner, obj/item/smartgun_powerpack/power_pack)
	set waitfor = 0
	sleep(5)
	if(power_pack && power_pack.loc)
		power_pack.attack_self(smart_gunner)

/obj/item/ammo_magazine/internal/smartgun/dirty
	default_ammo = /datum/ammo/bullet/smartgun/dirty
	gun_type = /obj/item/weapon/gun/smartgun/dirty

/obj/item/weapon/gun/smartgun/dirty
	name = "\improper M56D 'dirty' smartgun"
	desc = "The actual firearm in the 4-piece M56D Smartgun System. If you have this, you're about to bring some serious pain to anyone in your way.\nYou may toggle firing restrictions by using a special action."
	origin_tech = "combat=7;materials=5"
	current_mag = /obj/item/ammo_magazine/internal/smartgun/dirty
	ammo_secondary = /datum/ammo/bullet/smartgun/lethal
	attachable_allowed = list() //Cannot be upgraded.
	flags_gun_features = GUN_INTERNAL_MAG|GUN_WY_RESTRICTED|GUN_SPECIALIST

	New()
		..()
		accuracy += config.min_hit_accuracy_mult

//-------------------------------------------------------
//GRENADE LAUNCHER

/obj/item/weapon/gun/launcher/m92
	name = "\improper M92 grenade launcher"
	desc = "A heavy, 6-shot grenade launcher used by the Colonial Marines for area denial and big explosions."
	icon_state = "m92"
	item_state = "m92" //NEED TWO HANDED SPRITE
	origin_tech = "combat=5;materials=5"
	matter = list("metal" = 6000)
	w_class = 4.0
	throw_speed = 2
	throw_range = 10
	force = 5.0
	wield_delay = 8
	fire_sound = 'sound/weapons/armbomb.ogg'
	cocked_sound = 'sound/weapons/gun_m92_cocked.ogg'
	var/list/grenades = new/list()
	var/max_grenades = 6
	aim_slowdown = SLOWDOWN_ADS_SPECIALIST
	attachable_allowed = list(/obj/item/attachable/magnetic_harness)

	flags_atom = FPRINT|CONDUCT|TWOHANDED
	flags_gun_features = GUN_UNUSUAL_DESIGN|GUN_SPECIALIST
	gun_skill_category = GUN_SKILL_SPEC

	New()
		set waitfor = 0
		..()
		fire_delay = config.max_fire_delay*3
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 22, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
		sleep(1)
		grenades += new /obj/item/explosive/grenade/frag(src)
		grenades += new /obj/item/explosive/grenade/frag(src)
		grenades += new /obj/item/explosive/grenade/incendiary(src)
		grenades += new /obj/item/explosive/grenade/frag(src)
		grenades += new /obj/item/explosive/grenade/frag(src)

	examine(mob/user)
		..()
		if(grenades.len)
			if (get_dist(user, src) > 2 && user != loc) return
			user << "\blue It is loaded with <b>[grenades.len] / [max_grenades]</b> grenades."

	attackby(obj/item/I, mob/user)
		if((istype(I, /obj/item/explosive/grenade)))
			if(grenades.len < max_grenades)
				if(user.drop_inv_item_to_loc(I, src))
					grenades += I
					user << "<span class='notice'>You put [I] in the grenade launcher.</span>"
					user << "<span class='info'>Now storing: [grenades.len] / [max_grenades] grenades.</span>"
			else
				user << "<span class='warning'>The grenade launcher cannot hold more grenades!</span>"

		else if(istype(I,/obj/item/attachable))
			if(check_inactive_hand(user)) attach_to_gun(user,I)

	afterattack(atom/target, mob/user, flag)
		if(able_to_fire(user))
			if(get_dist(target,user) <= 2)
				user << "<span class='warning'>The grenade launcher beeps a warning noise. You are too close!</span>"
				return
			if(grenades.len)
				fire_grenade(target,user)
				playsound(user.loc, cocked_sound, 25, 1)
			else user << "<span class='warning'>The grenade launcher is empty.</span>"

	//Doesn't use most of any of these. Listed for reference.
	load_into_chamber()
		return

	reload_into_chamber()
		return

	unload(mob/user)
		if(grenades.len)
			var/obj/item/explosive/grenade/nade = grenades[grenades.len] //Grab the last one.
			if(user)
				user.put_in_hands(nade)
				playsound(user, unload_sound, 25, 1)
			else nade.loc = get_turf(src)
			grenades -= nade
		else user << "<span class='warning'>It's empty!</span>"

	able_to_fire(mob/living/user)
		. = ..()
		if (. && istype(user)) //Let's check all that other stuff first.
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.spec_weapons < SKILL_SPEC_TRAINED && user.mind.cm_skills.spec_weapons != SKILL_SPEC_ROCKET)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0

/obj/item/weapon/gun/launcher/m92/proc/fire_grenade(atom/target, mob/user)
	set waitfor = 0
	for(var/mob/O in viewers(world.view, user))
		O.show_message(text("<span class='danger'>[] fired a grenade!</span>", user), 1)
	user << "<span class='warning'>You fire the grenade launcher!</span>"
	var/obj/item/explosive/grenade/F = grenades[1]
	grenades -= F
	F.loc = user.loc
	F.throw_range = 20
	F.throw_at(target, 20, 2, user)
	if(F && F.loc) //Apparently it can get deleted before the next thing takes place, so it runtimes.
		message_admins("[key_name_admin(user)] fired a grenade ([F.name]) from \a ([name]).")
		log_game("[key_name_admin(user)] used a grenade ([name]).")
		F.icon_state = initial(F.icon_state) + "_active"
		F.active = 1
		F.updateicon()
		playsound(F.loc, fire_sound, 50, 1)
		sleep(10)
		if(F && F.loc) F.prime()

/obj/item/weapon/gun/launcher/m81
	name = "\improper M81 grenade launcher"
	desc = "A lightweight, single-shot grenade launcher used by the Colonial Marines for area denial and big explosions."
	icon_state = "m81"
	item_state = "m81"
	origin_tech = "combat=5;materials=5"
	matter = list("metal" = 7000)
	w_class = 4.0
	throw_speed = 2
	throw_range = 10
	force = 5.0
	wield_delay = WIELD_DELAY_VERY_FAST
	fire_sound = 'sound/weapons/armbomb.ogg'
	cocked_sound = 'sound/weapons/gun_m92_cocked.ogg'
	var/grenade
	aim_slowdown = SLOWDOWN_ADS_SPECIALIST

	flags_atom = FPRINT|CONDUCT
	flags_gun_features = GUN_UNUSUAL_DESIGN|GUN_SPECIALIST
	gun_skill_category = GUN_SKILL_SPEC

	New()
		set waitfor = 0
		..()
		fire_delay = config.max_fire_delay * 1.5
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 14, "rail_y" = 22, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
		sleep(1)
		grenade = new /obj/item/explosive/grenade/frag(src)

	examine(mob/user)
		..()
		if(grenade)
			if (get_dist(user, src) > 2 && user != loc) return
			user << "\blue It is loaded with a grenade."

	attackby(obj/item/I, mob/user)
		if((istype(I, /obj/item/explosive/grenade)))
			if(!grenade)
				if(user.drop_inv_item_to_loc(I, src))
					grenade = I
					user << "<span class='notice'>You put [I] in the grenade launcher.</span>"
			else
				user << "<span class='warning'>The grenade launcher cannot hold more grenades!</span>"

		else if(istype(I,/obj/item/attachable))
			if(check_inactive_hand(user)) attach_to_gun(user,I)

	afterattack(atom/target, mob/user, flag)
		if(able_to_fire(user))
			if(get_dist(target,user) <= 2)
				user << "<span class='warning'>The grenade launcher beeps a warning noise. You are too close!</span>"
				return
			if(grenade)
				fire_grenade(target,user)
				playsound(user.loc, cocked_sound, 25, 1)
			else user << "<span class='warning'>The grenade launcher is empty.</span>"

	//Doesn't use most of any of these. Listed for reference.
	load_into_chamber()
		return

	reload_into_chamber()
		return

	unload(mob/user)
		if(grenade)
			var/obj/item/explosive/grenade/nade = grenade
			if(user)
				user.put_in_hands(nade)
				playsound(user, unload_sound, 25, 1)
			else nade.loc = get_turf(src)
			grenade = null
		else user << "<span class='warning'>It's empty!</span>"

	able_to_fire(mob/living/user)
		. = ..()
		if (. && istype(user)) //Let's check all that other stuff first.
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.spec_weapons < SKILL_SPEC_TRAINED && user.mind.cm_skills.spec_weapons != SKILL_SPEC_GRENADIER)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0

/obj/item/weapon/gun/launcher/m81/proc/fire_grenade(atom/target, mob/user)
	set waitfor = 0
	for(var/mob/O in viewers(world.view, user))
		O.show_message(text("<span class='danger'>[] fired a grenade!</span>", user), 1)
	user << "<span class='warning'>You fire the grenade launcher!</span>"
	var/obj/item/explosive/grenade/F = grenade
	grenade = null
	F.loc = user.loc
	F.throw_range = 20
	F.throw_at(target, 20, 2, user)
	if(F && F.loc) //Apparently it can get deleted before the next thing takes place, so it runtimes.
		message_admins("[key_name_admin(user)] fired a grenade ([F.name]) from \a ([name]).")
		log_game("[key_name_admin(user)] used a grenade ([name]).")
		F.icon_state = initial(F.icon_state) + "_active"
		F.active = 1
		F.updateicon()
		playsound(F.loc, fire_sound, 50, 1)
		sleep(10)
		if(F && F.loc) F.prime()

//-------------------------------------------------------
//M5 RPG

/obj/item/ammo_magazine/rocket
	name = "\improper 84mm high-explosive rocket"
	desc = "A rocket tube for an M5 RPG rocket."
	caliber = "rocket"
	icon_state = "rocket"
	origin_tech = "combat=3;materials=3"
	matter = list("metal" = 10000)
	w_class = 3.0
	max_rounds = 1
	default_ammo = /datum/ammo/rocket
	gun_type = /obj/item/weapon/gun/launcher/rocket
	flags_magazine = NOFLAGS

	attack_self(mob/user)
		if(current_rounds <= 0)
			user << "<span class='notice'>You begin taking apart the empty tube frame...</span>"
			if(do_after(user,10, TRUE, 5, BUSY_ICON_CLOCK))
				user.visible_message("[user] deconstructs the rocket tube frame.","<span class='notice'>You take apart the empty frame.</span>")
				var/obj/item/stack/sheet/metal/M = new(get_turf(user))
				M.amount = 2
				user.drop_held_item()
				cdel(src)
		else user << "Not with a missile inside!"

	update_icon()
		overlays.Cut()
		if(current_rounds <= 0)
			name = "empty rocket frame"
			desc = "A spent rocket rube. Activate it to deconstruct it and receive some materials."
			icon_state = type == /obj/item/ammo_magazine/rocket/m57a4? "quad_rocket_e" : "rocket_e"

/obj/item/ammo_magazine/rocket/ap
	name = "\improper 84mm anti-armor rocket"
	icon_state = "ap_rocket"
	default_ammo = /datum/ammo/rocket/ap
	desc = "A tube for an AP rocket, the warhead of which is extremely dense and turns molten on impact. When empty, use this frame to deconstruct it."

/obj/item/ammo_magazine/rocket/wp
	name = "\improper 84mm white-phosphorus rocket"
	icon_state = "wp_rocket"
	default_ammo = /datum/ammo/rocket/wp
	desc = "A highly destructive warhead that bursts into deadly flames on impact. Use this in hand to deconstruct it."

/obj/item/ammo_magazine/internal/launcher/rocket
	name = "\improper 84mm internal tube"
	desc = "The internal tube of a M5 RPG."
	caliber = "rocket"
	default_ammo = /datum/ammo/rocket
	max_rounds = 1
	reload_delay = 60

/obj/item/weapon/gun/launcher/rocket
	name = "\improper M5 RPG"
	desc = "The M5 RPG is the primary anti-armor weapon of the USCM. Used to take out light-tanks and enemy structures, the M5 RPG is a dangerous weapon with a variety of combat uses."
	icon_state = "m5"
	item_state = "m5"
	origin_tech = "combat=6;materials=5"
	matter = list("metal" = 10000)
	current_mag = /obj/item/ammo_magazine/internal/launcher/rocket
	flags_equip_slot = NOFLAGS
	w_class = 5
	force = 15
	wield_delay = 12
	aim_slowdown = SLOWDOWN_ADS_SPECIALIST
	attachable_allowed = list(
						/obj/item/attachable/magnetic_harness)

	flags_atom = FPRINT|CONDUCT|TWOHANDED
	flags_gun_features = GUN_INTERNAL_MAG|GUN_SPECIALIST
	gun_skill_category = GUN_SKILL_SPEC
	var/datum/effect_system/smoke_spread/smoke

	New()
		..()
		recoil = config.med_recoil_value
		fire_delay = config.high_fire_delay*2
		attachable_offset = list("muzzle_x" = 33, "muzzle_y" = 18,"rail_x" = 6, "rail_y" = 19, "under_x" = 19, "under_y" = 14, "stock_x" = 19, "stock_y" = 14)
		smoke = new()
		smoke.attach(src)

	examine(mob/user)
		..()

		if(current_mag.current_rounds)  user << "It's ready to rocket."
		else 							user << "It's empty."


	able_to_fire(mob/living/user)
		. = ..()
		if (. && istype(user)) //Let's check all that other stuff first.
			var/turf/current_turf = get_turf(user)
			if (current_turf.z == 3 || current_turf.z == 4) //Can't fire on the Almayer, bub.
				click_empty(user)
				user << "<span class='warning'>You can't fire that here!</span>"
				return 0
			if(user.mind && user.mind.cm_skills && user.mind.cm_skills.spec_weapons < SKILL_SPEC_TRAINED && user.mind.cm_skills.spec_weapons != SKILL_SPEC_ROCKET)
				user << "<span class='warning'>You don't seem to know how to use [src]...</span>"
				return 0

	load_into_chamber(mob/user)
		if(active_attachable) active_attachable = null
		return ready_in_chamber()

	//No such thing
	reload_into_chamber(mob/user)
		return 1

	delete_bullet(obj/item/projectile/projectile_to_fire, refund = 0)
		cdel(projectile_to_fire)
		if(refund) current_mag.current_rounds++
		return 1

	reload(mob/user, obj/item/ammo_magazine/rocket)
		if((flags_gun_features|GUN_BURST_ON|GUN_BURST_FIRING) == flags_gun_features) return

		if(!rocket || !istype(rocket) || rocket.caliber != current_mag.caliber)
			user << "<span class='warning'>That's not going to fit!</span>"
			return

		if(current_mag.current_rounds > 0)
			user << "<span class='warning'>[src] is already loaded!</span>"
			return

		if(rocket.current_rounds <= 0)
			user << "<span class='warning'>That frame is empty!</span>"
			return

		if(user)
			user << "<span class='notice'>You begin reloading [src]. Hold still...</span>"
			if(do_after(user,current_mag.reload_delay, TRUE, 5, BUSY_ICON_CLOCK))
				user.drop_inv_item_on_ground(rocket)
				replace_ammo(user,rocket)
				current_mag.current_rounds = current_mag.max_rounds
				rocket.current_rounds = 0
				user << "<span class='notice'>You load [rocket] into [src].</span>"
				if(reload_sound) playsound(user, reload_sound, 25, 1)
				else playsound(user,'sound/machines/click.ogg', 25, 1)
			else
				user << "<span class='warning'>Your reload was interrupted!</span>"
				return
		else
			rocket.loc = get_turf(src)
			replace_ammo(,rocket)
			current_mag.current_rounds = current_mag.max_rounds
			rocket.current_rounds = 0
		rocket.update_icon()
		return 1

	unload(mob/user)
		if(user)
			if(!current_mag.current_rounds) user << "<span class='warning'>[src] is already empty!</span>"
			else 							user << "<span class='warning'>It would be too much trouble to unload [src] now. Should have thought ahead!</span>"

//Adding in the rocket backblast. The tile behind the specialist gets blasted hard enough to down and slightly wound anyone
/obj/item/weapon/gun/launcher/rocket/apply_bullet_effects(obj/item/projectile/projectile_to_fire, mob/user, i = 1, reflex = 0)

	var/backblast_loc = get_turf(get_step(user.loc, turn(user.dir, 180)))
	smoke.set_up(1, 0, backblast_loc, turn(user.dir, 180))
	smoke.start()
	for(var/mob/living/carbon/C in backblast_loc)
		if(!C.lying) //Have to be standing up to get the fun stuff
			C.adjustBruteLoss(15) //The shockwave hurts, quite a bit. It can knock unarmored targets unconscious in real life
			C.Stun(4) //For good measure
			C.emote("scream")

		..()

//-------------------------------------------------------
//M5 RPG'S MEAN FUCKING COUSIN

/obj/item/ammo_magazine/rocket/m57a4
	name = "\improper 84mm thermobaric rocket array"
	desc = "A thermobaric rocket tube for an M83AM quad launcher. Activate in hand to receive some metal when it's used up."
	caliber = "rocket array"
	icon_state = "quad_rocket"
	origin_tech = "combat=4;materials=4"
	max_rounds = 4
	default_ammo = /datum/ammo/rocket/wp/quad
	gun_type = /obj/item/weapon/gun/launcher/rocket/m57a4
	reload_delay = 200

/obj/item/ammo_magazine/internal/launcher/rocket/m57a4
	desc = "The internal tube of an M83AM Thermobaric Launcher."
	caliber = "rocket array"
	default_ammo = /datum/ammo/rocket/wp/quad
	max_rounds = 4

/obj/item/weapon/gun/launcher/rocket/m57a4
	name = "\improper M57-A4 'Lightning Bolt' quad thermobaric launcher"
	desc = "The M57-A4 'Lightning Bolt' is posssibly the most destructive man-portable weapon ever made. It is a 4-barreled missile launcher capable of burst-firing 4 thermobaric missiles. Enough said."
	icon_state = "m57a4"
	item_state = "m57a4"
	origin_tech = "combat=7;materials=5"
	current_mag = /obj/item/ammo_magazine/internal/launcher/rocket/m57a4
	aim_slowdown = SLOWDOWN_ADS_SUPERWEAPON
	attachable_allowed = list()
	flags_gun_features = GUN_INTERNAL_MAG|GUN_WY_RESTRICTED|GUN_SPECIALIST

	New()
		..()
		accuracy -= config.med_hit_accuracy_mult
		fire_delay = config.mhigh_fire_delay
		burst_delay = config.med_fire_delay
		burst_amount = config.high_burst_value

