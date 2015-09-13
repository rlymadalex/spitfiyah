mob/var/Frozen
mob/var/tmp/Moving
mob/var/tmp/Knockbacked
mob/var/Decimals=0

proc
	PlanetEnterBump(var/A,var/Q)
		if(istype(A,/obj/Planets))
			if(istype(A,/obj/Planets/Alien))
				var/obj/Planets/LOL=A
				var/Wtf=LOL.Zz
				var/randy=1
				var/randx=Wtf
				while(randx>5)
					randx-=5
					randy++
				Q:loc=locate(rand(randx*100-99,randx*100+99),rand(randy*100-99,randy*100-1),14)
			else
				var/obj/Planets/LOL=A
				var/Wtf=LOL.Zz
				Q:loc=locate(rand(1,500),rand(1,500),Wtf)

mob/Move()
	if(!client&&!Knockbacked&&!Move_Requirements()) return
	var/Former_Location=loc
	Moving=1
	var/Delay=3/SpeedMod
	Delay*=(100/(sqrt(max(1,Health))*sqrt(max(1,Health))))
	Delay*=EnergyMax/max((sqrt(max(1,Energy))*sqrt(max(1,Energy))),EnergyMax/100)/2
	if(Shocked)
		Delay*=(Shocked+1)
	if(Flying)
		density=0
		Delay*=0.5
	if(Swim)
		Delay*=2
	Decimals+=Delay-round(Delay)
	if(round(Decimals)>1)
		Delay+=round(Decimals)
		Decimals-=round(Decimals)
	if(Knockbacked) Delay=0
	spawn(Delay) Moving=0
	..()
	density=1
	Edge_Check(Former_Location)
	if(!Knockbacked&&Target&&istype(Target,/obj/Others/Build)) Build_Lay(Target,src)
	if(Grab) Grab_Update()
mob/proc/Edge_Check(turf/Former_Location)
	for(var/mob/A in loc) if(A!=src&&A.Flying&&Flying)
		loc=Former_Location
		break
	for(var/obj/Turfs/Door/A in loc) if(A.density)
		loc=Former_Location
		Bump(A)
		break
	if(!Flying)
		var/turf/T=get_step(Former_Location,dir)
		if(T&&!T.Enter(src)) return
		for(var/obj/Turfs/Edges/A in loc)
			if(!(A.dir in list(dir,turn(dir,90),turn(dir,-90),turn(dir,45),turn(dir,-45))))
				loc=Former_Location
				break
		for(var/obj/Turfs/Edges/A in Former_Location) if(A.dir in list(dir,turn(dir,45),turn(dir,-45)))
			loc=Former_Location
			break


