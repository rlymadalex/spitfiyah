mob/Click()
	if(usr.Target!=src)
		usr.Target=src
		usr<<"<font color=green>Now targeting [src]!"
	else
		usr.Target=null
		usr<<"<font color=red>Targeting disabled."
	..()


proc/Observify(mob/P,atom/A) if(A) P.client.eye=A
mob/proc/Percent(A)
	//return "[round(100*(A/(Strength+Endurance+Force+Resistance+Speed+Offense+Defense+Regeneration+Recovery)),0.1)]%"
	return "[round(100*(A/(Strength+Endurance+Force+Resistance+Offense+Defense+Speed)),0.1)]%"
proc/Crater(turf/A) new/obj/Effects/Crater(A.loc)
proc/Purge_Old_Saves() for(var/File in flist("Saves/"))
	var/savefile/F=new("Saves/Players/[File]")
	if(F["Last_Used"]<=world.realtime-864000*7) fdel("Saves/Players/[File]")
proc/Players_In_Range(atom/A,Range)
	var/Start_X=A.x-Range
	var/Start_Y=A.y-Range
	var/End_X=A.x+Range
	var/End_Y=A.y+Range
	if(Start_X<1) Start_X=1
	if(Start_Y<1) Start_Y=1
	if(End_X>world.maxx) Start_X=world.maxx
	if(End_Y>world.maxy) Start_Y=world.maxy
	var/list/Mobs=new
	for(var/mob/Players/P) if(P.z==A.z&&P.x>=Start_X&&P.x<=End_X&&P.y>=Start_Y&&P.y<=End_Y) Mobs+=P
	return Mobs
proc/Turf_Range(atom/A,Distance)
	var/list/Turfs=new
	var/Start=locate(A.x-Distance,A.y-Distance,A.z)
	var/End=locate(A.x+Distance,A.y+Distance,A.z)
	for(var/turf/Turf in block(Start,End)) Turfs+=Turf
	return Turfs
proc/Turf_Circle(turf/center,radius)
	. = list()
	while(center&&!isturf(center)) center=center.loc
	if(!center) return list()
	var/x=center.x,y=center.y,z=center.z
	var/dx,dy,rsq
	var/x1,x2,y1,y2
	rsq=radius*(radius+1)
	for(dy=0,dy<=radius,++dy)
		dx=round(sqrt(rsq-dy*dy))
		y1=y-dy
		y2=y+dy
		x1=max(x-dx,1)
		x2=min(x+dx,world.maxx)
		if(x1>x2) continue  // this should never happen, but just in case...
		if(y1>0)
			. +=block(locate(x1,y1,z),locate(x2,y1,z))
		if(y2 <= world.maxy)
			. +=block(locate(x1,y2,z),locate(x2,y2,z))
mob/proc/File_Size(file)
	var/size=length(file)
	if(!size||!isnum(size)) return
	var/ending="Byte"
	if(size>=1024)
		size/=1024
		ending="KB"
		if(size>=1024)
			size/=1024
			ending="MB"
			if(size>=1024)
				size/=1024
				ending="GB"
	var/end=round(size)
	return "[Commas(end)] [ending]\s"
proc/Commas(A)
	var/Number=num2text(round(A,1),20)
	for(var/i=lentext(Number)-2,i>1,i-=3) Number="[copytext(Number,1,i)]'[copytext(Number,i)]"
	return Number
proc/Direction(A)
	switch(A)
		if(1) return "North"
		if(2) return "South"
		if(4) return "East"
		if(5) return "Northeast"
		if(6) return "Southeast"
		if(8) return "West"
		if(9) return "Northwest"
		if(10) return "Southwest"
		if("North") return 1
		if("South") return 2
		if("East") return 4
		if("Northeast") return 5
		if("Southeast") return 6
		if("West") return 8
		if("Northwest") return 9
		if("Southwest") return 10