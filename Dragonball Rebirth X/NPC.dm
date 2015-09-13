mob/proc/AI()
	set background =1
	spawn()src.Available_Power()
	while(src)
		var/mob/Players/P
		if(Health<=0&&!KO) Unconscious(null,"?!?!")
		if(!KO)
			if(istype(src,/mob/Animals/Predators)||Health<=80) for(P in oview(Sight_Range,src)) break
			var/atom/O //Potential Obstacles
			for(O in get_step(src,dir)) if(O.density&&!ismob(O)) break
			if(!Knockbacked)
				if(P&&!O) step_towards(src,P)
				else step_rand(src)
		if(P) sleep(1)
		else sleep(rand(20,40))
mob/Animals
	icon='Animals.dmi'
	New()
		spawn if(src) AI()
	Peaceful

		Bump(mob/A)
			if(Health<100||isturf(A)) Melee()
		Frog
			icon_state="Frog"
		Dino_Bird
			icon_state="DinoBird"
		Cat
			icon_state="Cat"
		Bat
			icon_state="Bat"
		Cow
			icon_state="Cow"
		Turtle
			icon_state="Turtle"
		Horse
			icon_state="Horse"
		Sheep
			icon_state="Sheep"
		Dog
			icon_state="Dog"
		Fly
			icon_state="Fly"

	Special
		icon='Special.dmi'
		Skill=1000
		Bump(mob/A)Melee()

		DragonKing
			icon='SpecialBig.dmi'
			icon_state="King"
			pixel_x=-110
			pixel_y=-35
		DragonQueen
			icon='SpecialBig.dmi'
			icon_state="Queen"
			pixel_x=-110
			pixel_y=-35
		DragonLord
			icon='SpecialBig.dmi'
			icon_state="Lord"
			pixel_x=-110
			pixel_y=-35

		Owl//nonhostile
			icon='SpecialBig.dmi'
			icon_state="Owl"
			pixel_x=-40
			pixel_y=-16
		TigerSeel//nonhostile
			icon='SpecialBig.dmi'
			icon_state="Tig"
			pixel_x=-40
			pixel_y=-30
		EleSeel//nonhostile?
			icon='SpecialBig.dmi'
			icon_state="Ele"
			pixel_x=-70
			pixel_y=-30
		SuperBat
			icon='SpecialBig.dmi'
			icon_state="Bat"
			pixel_x=-50
			pixel_y=-50
		LionWhite
			icon='SpecialBig.dmi'
			icon_state="WhiteL"
			pixel_x=-66
			pixel_y=-20
		LionYellow
			icon='SpecialBig.dmi'
			icon_state="YellowL"
			pixel_x=-66
			pixel_y=-20



	Predators
		Skill=100
		Bump(mob/A) Melee()


		Dino_Munky
			icon_state="OozaruDino"
		Robot
			icon_state="Bot1"
		Big_Robot
			icon_state="Bot2"
		Hover_Robot
			icon_state="Bot3"
		Gremlin
			icon_state="Gremlin"
		Evil_Entity
			icon_state="EvilMan"
		Bandit
			icon_state="Bandit"
		Tiger_Bandit
			icon_state="TigerMan"
		Wolf
			icon_state="Wolf"
		Giant_Robot
			icon_state="Robot"
		Ice_Dragon
			icon_state="IceDragon"
		Ice_Flame
			icon_state="IceFlame"
		Saibaman
			icon_state="Saibaman"
		Small_Saibaman
			icon_state="SaibamanSmall"
		Black_Saibaman
			icon_state="SaibamanBlack"
		Mutated_Saibaman
			icon_state="SaibamanGreen"
