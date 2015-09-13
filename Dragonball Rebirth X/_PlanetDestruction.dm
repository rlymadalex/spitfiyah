Effect_Handler
	var
		min_x = 1
		max_x = 1
		min_y = 1
		max_y = 1
		min_z = 1
		max_z = 1
		max_count = 10
		current_count = 0
		simul_count = 1
		effect
		turf_replace = 0
		turf_ref
		duration = 10
		spawn_delay = 0
		anti_dupe_delay = 1
		x_offset = 8
		y_offset = 5
		z_offset = 0


	proc
		Seed()
			set background=1
			var/seed_x = (max_x-min_x)/simul_count
			var/seed_y = (max_y-min_y)/simul_count
			var/loc_age = 0
			var/list/old_locs = new/list()
			var/i
			var/list/x_values = new/list()
			var/list/y_values = new/list()
			var/list/z_values = new/list()
			for(i=min_x,i<max_x,i+=seed_x)
				x_values += round(i)
			for(i=min_y,i<max_y,i+=seed_y)
				y_values += round(i)
			z_values += round(max_z)
			for(current_count=0,current_count<max_count,current_count+=simul_count)
				for(i=0,i<simul_count,i++)
					spawn(spawn_delay*i)
						var/obj/E =new effect
						if(istype(E,/obj/Effects/PDEffect))
							E.icon=pick('PD1.dmi','PD2.dmi','PD3.dmi')
							if(E.icon=='PD3.dmi')
								E.pixel_x=-30
						var/turf/temploc = locate(pick(x_values),pick(y_values),pick(z_values))
						while(temploc in old_locs)
							temploc = locate(pick(x_values),pick(y_values),pick(z_values))
						E.loc = locate(min(max(temploc.x+rand(0-x_offset,x_offset),1),500),min(max(temploc.x+rand(0-y_offset,y_offset),1),500),temploc.z+rand(0-z_offset,z_offset))
						old_locs += temploc
						sleep(duration)
						if(turf_replace)
							var/atom/X= turf_ref
							var/buh=0
							if(E.icon=='PD3.dmi')
								buh=1
							for(var/turf/Q in view(buh,E))
								if(prob(30))continue
								if(istype(X,/turf/Special/Stars))
									new turf_ref(oc=locate(Q.x,Q.y,Q.z),icon_state="[rand(1,2500)]")
								else if(istype(X,/turf/Special/PDTurf))
									new turf_ref(loc=locate(Q.x,Q.y,Q.z),icon_state="[rand(1,5)]")
								else
									new turf_ref(loc=locate(Q.x,Q.y,Q.z))
						if(E)del E
				if(loc_age >= anti_dupe_delay) old_locs = new/list()
				loc_age++
				sleep(duration)



proc
	EX_EffectHandler(var/obj/Effect,totalcount,simultaneouscount,duration,minx,maxx,miny,maxy,minz,maxz,spawn_delay,dupe_delay,var/turf/Debris=null)
		var/Effect_Handler/X = new/Effect_Handler
		X.min_x = minx
		X.max_x = maxx
		X.min_y = miny
		X.max_y = maxy
		X.min_z = maxz
		X.effect = Effect
		X.duration = duration
		X.max_count = totalcount
		X.simul_count = simultaneouscount
		X.anti_dupe_delay = dupe_delay
		if(Debris)
			X.turf_replace = 1
			X.turf_ref = Debris
		X.Seed()



proc/LightningFlash(var/mob/Z)
	set background=1
	if(isnum(Z))
		spawn()for(var/area/L in world)if(L.z==Z)
			sleep(0.1)
			var/blah=L.icon_state
			if(blah!="Lightning")
				L.icon_state="Lightning"
				spawn(rand(4,12))L.icon_state=blah
	else
		spawn()for(var/area/L in view(0,Z))
			var/blah=L.icon_state
			if(blah!="Lightning")
				L.icon_state="Lightning"
				spawn(rand(4,12))L.icon_state=blah

proc/DestroyPlanet(var/Z)
	set background=1
	LightningFlash(Z)
	spawn(150) EX_EffectHandler(/obj/Effects/PDEffect,3000,50,60,1,500,1,5000,Z,30,1,Debris=/turf/Special/PDTurf)
	spawn(25) EX_EffectHandler(/obj/Effects/Lightning,1000,250,100,1,500,1,500,Z,10,1,null)
	spawn(500) EX_EffectHandler(/obj/Effects/Tornado,5000,100,100,1,500,1,500,Z,50,1,null)
	spawn(1000) EX_EffectHandler(/obj/Effects/PDEffect,5000,200,60,1,500,1,5000,Z,30,1,Debris=/turf/Special/PDTurf)
	spawn(5000) EX_EffectHandler(/obj/Effects/PDEffect,5000,250,60,1,500,1,5000,Z,30,1,Debris=/turf/Special/Stars)
	spawn(50) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(10)
	spawn(250) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(30)
	spawn(750) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(50)
	spawn(1050) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(60)
	spawn(1550) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(70)
	spawn(2000) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(80)
	spawn(2500) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(100)
	spawn(3000) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(120)
	spawn(4000) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(140)
	spawn(4500) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(150)
	spawn(5000) for(var/mob/Players/M) if(M.z==Z) M.PDQuake(200)
	spawn(10)for(var/area/L in world)
		if(L.z==Z)
			L.icon_state="Rising Rocks"
			L.WeatherOn=0
		sleep(1)
	spawn(6000)
		for(var/obj/Items/T in world)if(T.z==Z)del(T)
		RemovePlanet(Z)


//	EX_EffectHandler(/obj/Effects/PDEffect,totalcount=100,simultaneouscount=10,duration=100,minx=1,maxx=100,miny=1,maxy=100,minz=Z,maxz=Z,random=1,spawn_delay=15,dupe_delay=1,/turf/Special/Stars)


mob/proc/PlanetDestroyed()
	var/blah
	if(src.z==1)
		blah="Earth"
	if(src.z==2)
		blah="Namek"
	if(src.z==3)
		blah="Vegeta"
	if(src.z==4)
		blah="Ice"
	if(src.z==5)
		blah="Arconia"
	if(blah)
		if(!Planets.Find(blah))
			src<<"The planet you resided on no longer exists. You are now in space."
			src.loc=locate(250,250,9)
proc/RemovePlanet(var/Z)
	if(Z==1)
		Planets.Remove("Earth")
	if(Z==2)
		Planets.Remove("Namek")
	if(Z==3)
		Planets.Remove("Vegeta")
	if(Z==4)
		Planets.Remove("Ice")
	if(Z==5)
		Planets.Remove("Arconia")
	for(var/mob/Players/M in world)
		M.PlanetDestroyed()
	for(var/obj/Planets/P in world)
		if(P.Zz==Z)
			LightningFlash(12)
			del(P)

mob/proc/PDQuake(var/duration=30)
	if(src.client)
		while(duration)
			duration-=1
			src.client.pixel_x=rand(-8,8)
			src.client.pixel_y=rand(-8,8)
			sleep(1)
		if(duration<1)
			src.client.pixel_x=0
			src.client.pixel_y=0