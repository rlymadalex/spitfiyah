obj/Projectiles
	layer=5
	density=0
	//glide_size=2
	var/Knockback
	var/Explosive
	var/Pierce
	var/Paralysis
	var/Deflectable=1
	var/Radius=0
	Distance=15 //Tiles before deletion.
	proc/Deflect(mob/P)
		flick("Attack",P)
		src.dir=pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST)
		spawn(100)if(src)del(src)
	Mystical
		Move()
			..()
			AttackDamage()
		New()
			spawn(200)if(src)del(src)
			spawn src.AttackDamage()
			spawn src.SetPixels()
		Del()
			for(var/obj/Projectiles/P in get_step(src,turn(dir,180))) P.icon_state="struggle"
			..()
		proc/SetPixels()
			var/icon/b=new(src.icon)
			if(b.Width()>32)
				src.pixel_x=(b.Width()-32)/-2
			if(b.Height()>32)
				src.pixel_y=(b.Height()-32)/-2
		proc/Beam_Graphics() while(src)
			spawn if(src) if(icon_state!="struggle")
				if(!(locate(/obj/Projectiles) in get_step(src,dir))) icon_state="head"
				else if(!(locate(/obj/Projectiles) in get_step(src,turn(dir,180)))) icon_state="end"
				else icon_state="tail"
			for(var/mob/P in get_step(src,turn(dir,180))) del(src)
			sleep(1)
		proc/AttackDamage()
			for(var/mob/P in view(Radius,src))
				if(P!=Owner)
					spawn()Bump(P)
				//return
			for(var/obj/O in view(Radius,src))
				if(O!=src&&O.Owner!=src.Owner)
					spawn()Bump(O)
					//return
			for(var/turf/T in view(Radius,src))
				if(T.density)
					spawn()Bump(T)
		proc/Damage(mob/P,Damage)
			Damage/=(P.Power*P.Resistance)
			P.Health-=Damage
			if(P.Health<=0)
				if(P.KO) P.Death(Owner,null,Damage)
				else P.Unconscious(Owner)

			else if(Knockback) P.Knockback(Knockback,Owner)
		proc/Damage_Formula()
			if(istype(Owner,/mob))
				return Damage_Multiplier*Owner.Power*Owner.Force
			else
				return Damage_Multiplier
		Bump(mob/P)
			var/Damage=Damage_Formula()
			if(ismob(P))
				Damage*=P.Shielded()
				var/Accuracy=50
				if(prob(Accuracy_Formula(Owner,P,Accuracy))||!Deflectable)
					if(Explosive)
						Explosion(src,Explosive,Damage*0.2,1)
					Damage(P,Damage)
					if(!src.Pierce)
						if(src)del(src)
				else Deflect(P)
			else
				if(P&&src)
					if(P.type==type)
						if(P.dir!=dir)
							Distance=10 //Renew its distance so it doesn't delete mid-struggle.
							if(Damage*rand(0.2,2)<(P.Damage_Multiplier*P.Owner.Power*P.Owner.Force)*rand(0.2,2))
								del(src)
					else
						var/delete=0
						if(isobj(P)||isturf(P))
							P.Health-=Damage
							if(!src.Pierce)
								if(src)
									if(P.density)
										delete=1
							if(P.Health<=0)
								if(Explosive&&P.density)
									Explosion(src,Explosive,Damage*0.2)
								Destroy(P)
							//if(P)
							//	if(src)del(src)
							if(delete)
								if(src)del(src)

	Move()
		if(Distance<=0) del(src)
		Distance-=1
		..()

mob/proc/Beam_Charge(obj/Skills/Attacks/A)
	src.Attacking=1
	A.Charging=1
	src.Chargez("Add")
	while(A.Charging)
		src.Beaming=1
		A.Charging+=A.ChargeRate/10
		sleep(10)

mob/proc/Beam_Go(obj/Skills/Attacks/A,var/Z)
	src.Chargez("Remove")
	var/Charged=A.Charging
	A.Charging=0
	Attacking=1
	icon_state="Blast"
	A.Using=1
	if(1==1)
		while(A.Using)
			EXP+=(EXPGains/100)*0.00007
			var/L=A.Distance*(A.Level/100)
			if(L>A.Distance)
				L=A.Distance
			if(L<1)
				L=1
			var/Drain=5/A.Efficiency
			Energy-=Drain/A.Speed
			A.Skill_Increase((1/A.Speed)/3)
			Beaming=1
			var/obj/Projectiles/Mystical/B=new
			B.Damage_Multiplier=A.Power*Charged
			B.Offense=Offense*Skill
			B.Distance=L
			B.Owner=src
			B.icon=A.sicon
			B.density=0
			B.dir=dir
			B.loc=get_step(src,dir)
			B.layer+=1
			B.animate_movement=0
			B.icon_state="origin"
			B.Deflectable=0
			if(A.Big)
				B.Radius=1
			walk(B,dir,round(10/A.Speed))
			//spawn if(B) B.Beam_Damage()
			spawn(round(10/A.Speed)) if(B)
				B.layer-=1
				B.Beam_Graphics()
			if(!usr.CanBlast(Drain)) Beam_Stop(A)
			sleep(round(10/A.Speed))
mob/proc/Beam_Stop(obj/Skills/Attacks/A)
	A.Using=0
	Attacking=0
	Beaming=0
	if(icon_state=="Blast")
		if(Flying) icon_state="Flight"
		else icon_state=""



proc/Explosion(var/obj/Projectiles/Mystical/Origin,Range,Damage,var/buh=0)
	for(var/turf/A in oview(Origin,Range))
		if(!buh)
			A.Health-=Damage
			if(A.Health<=0) Destroy(A)
		for(var/mob/P in A)
			if(!Origin)break
			Origin.Damage(P,Damage/2)
		for(var/obj/P in A)
			if(P!=Origin)
				P.Health-=Damage
				if(P.Health<=0) Destroy(P)
		new/obj/Effects/Explosion(A)