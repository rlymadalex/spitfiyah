mob/var/LastAnger


mob/proc/Anger()
	if(AngerMax>1&&Anger==0)
		if(LastAnger)
			if(abs(src.LastAnger-world.realtime)<3500)
				return
		Anger=AngerMax
		src.OMessage(15,"<font color=red>[src] becomes angry!","<font color=blue>[src]([src.key]) becomes angry!")
		src.LastAnger=world.realtime

mob/proc/Unconscious(mob/P,var/text)
	spawn(2400/src.Regeneration*GetUpVar)if(src)src.Conscious()
	//if(ismob(P)) P.Anger=0
	src.KO=1
	src.icon_state="KO"
	src.Health=1
	src.Energy=1
	src.Flying=0
	if(src.client)
		src.Revert()
		if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
			src.Oozaru(0)
	if(src.Grab) src.Grab_Release()
	if(P)
		src.OMessage(15,"[src] is knocked out by [P]!","<font color=red>[src]([src.key]) is knocked out by [P]([P.key])")
	if(text)
		src.OMessage(15,"[src] is knocked out by [text]!","<font color=red>[src]([src.key]) is knocked out by [text]")
	if(istype(src,/mob/Split))
		del(src)
mob/proc/Conscious()
	if(src.KO)
		src.KO=0
		src.icon_state=""
		src.Health=1
		if(!src.Anger) src.Anger()
		src.OMessage(15,"[src] regains consciousness.","<font color=blue>[src]([src.key]) regains consciousness")

obj/Spirit
	icon='NewObjects.dmi'
	icon_state="35"
	Health=1.#INF
	Grabbable=0
	var/list/who=new
	verb/Use()
		set src in oview(1)
		if(who.Find(usr.key))
			if(who[usr.key]<=Year)
				usr<<"You cannot use this untl next month."
				return
			else
				if(prob(20))
					who.Remove(usr.key)
					usr<<"...Get out of here."
					usr.loc=locate(236,260,8)

				else
					usr<<"...You're out of luck..try again next month."
					who[usr.key]=Year
		else
			usr<<"..Welcome to The Final Realms! You may train, conversate with others...and enjoy the rest of eternity haha! You may talk to me once every month starting next month to see if I qualify you to get out of this dump!"
			who.Add("[usr.key]"=Year)


mob/proc/Death(mob/P,var/text,var/deather=0)
	if(src.z==13)return
	if(text)
		src.OMessage(20,"[src] was just killed by [text]!","<font color=red>[src] was just killed by [text]!")
	if(P)
		src.OMessage(20,"[src] was just killed by [P]!","<font color=red>[src] was just killed by [P]([P.key])!")
	sleep()
	if(Grab) Grab_Release()
	for(var/mob/Players/B) if(B.Grab==src) B.Grab_Release()
	var/obj/Regenerate/A
	for(A in src) break
	if(A)
		if(deather<100*A.Level)
			A.X=x
			A.Y=y
			A.Z=z
			loc=locate(485,458,13)
			Regenerate(A)
			return
	else
		if(!src.client)
			del(src)
			return
		if(!src.Dead)
			src.Leave_Body()
		else
			for(var/obj/Items/I in src)
				if(I.Stealable)
					if(I.suffix=="Equipped")
						spawn(5) I.suffix=null
				I.loc=src.loc

		for(var/obj/Money/Q in src)
			if(Q.Level)
				var/obj/Money/M=new(src.loc)
				M.Level=Q.Level
				M.name="[Commas(M.Level)] Resources"
				Q.Level=0
		if(src.client)
			if(!(locate(/obj/Lycan/Master,src.contents)))
				for(var/obj/Lycan/Q in src.contents)
					del(Q)
			if(!(locate(/obj/Skills/VampireInfect,src.contents)))
				for(var/obj/Skills/VampireAbsorb/Q in src.contents)
					if(src.Package["Vampire"]==1)
						src.SkillX("VAbsorb",Q)
						src.Package["Vampire"]=null
					spawn()del(Q)
				for(var/obj/Skills/VampireFrenzy/Q in src.contents)
					if(Q.Using)
						src.SkillX("VFrenzy",Q)
					spawn()del(Q)
			src.overlays-='Halo.dmi'
			src.overlays+='Halo.dmi'
			src.AbsorbPower=null
			src.CyberPower=null
			if(src.Dead)
				src.loc=locate(487,460,13)
			else
				src.Dead=1
				src.loc=locate(236,260,8)




mob/proc/Revive()
	overlays-='Halo.dmi'
	Dead=0
obj/Regenerate
	var/X
	var/Y
	var/Z
mob/proc/Regenerate(obj/Regenerate/R)
	var/Timer=1200/R.Level
	src<<"You will regenerate in [Timer/600] minutes"
	src.OMessage(10,null,"[src]([src.key]) will regenerate in [Timer/600] minutes.")
	if(KO) Conscious()
	Health=100
	spawn(Timer) if(src&&R) if(R.X&&R.Y&&R.Z)
		loc=locate(R.X,R.Y,R.Z)
		Health=max(50,Health)
		R.X=null
		R.Y=null
		R.Z=null
proc/Accuracy_Formula(mob/Offender,mob/Defender,Chance=50)
	if(Offender&&Defender)
		var/Offense=Offender.Power*Offender.Offense*Offender.Skill
		var/Defense=Defender.Power*Defender.Defense*Defender.Skill
		return Chance*(Offense/max(Defense,0.01))


mob/proc/Comboz(var/mob/M,var/forced)
	if(M==1)return
	if(M)
		var/turf/W=locate(M.x+rand(-1,1),M.y+rand(-1,1),usr.z)
		if(W)
			if(!W.density)
				for(var/atom/x in W)
					if(x.density)
						return
				src.loc=W
				src.dir=ReturnDirection(src,M)
				M.dir=ReturnDirection(M,src)
				if(!forced)
					src.SkillUP("Warp",pick(rand(1,2),0.5))




mob/proc/Melee(var/damagemulti,var/speedmulti,var/iconoverlay,var/forcewarp)
	if(src.Attacking)return
	var/Drain=5/src.Efficiency*DrainHard
	if(!(src.CanBlast(Drain)))return
	var/Delay=SpeedDelay()//Refire
	var/Accuracy=50
	var/Damage=src.Power*src.Strength*rand(2,5)
	var/explode
	for(var/obj/Items/Sword/S in src) if(S.suffix)
		Drain/=S.Drain_Multiplier
		Delay/=S.Delay_Multiplier
		Accuracy*=S.Accuracy_Multiplier
		Damage*=S.Damage_Multiplier
		if(S.Explosive)
			explode=1
		if(!forcewarp&&S.Homing)
			forcewarp=1
	if(forcewarp)
		if(forcewarp==1)
			if(src.Target)
				var/mob/M=usr.Target
				if(M)
					if(M!=src)
						var/lol=abs(src.x-M.x)+abs(src.y-M.y)
						if(lol<5&&lol>2)
							forcewarp=M
		Comboz(forcewarp,1)
	for(var/mob/P in get_step(src,dir))
		if(speedmulti)Delay*=speedmulti

		var/BlahX=P.Power*P.Endurance
		if(BlahX<=0)
			BlahX=0.01
		Damage/=BlahX
		if(damagemulti)Damage*=damagemulti
		var/Knock_Distance=round((Power*Strength)/(P.Power*P.Endurance)*rand(5,7))
		if(prob(90)) Knock_Distance=0
		if(P.icon_state=="Meditate"||P.KO) Accuracy=100
		for(var/obj/Items/Weights/W in src) if(W.suffix) Drain*=3
		if(!prob(Accuracy_Formula(src,P,Accuracy))) Accuracy=0
		Attacking=1
		if(src.client)
			Energy-=Drain
		Melee_Graphics()
		if(Accuracy)
			if(prob(10)&&!P.Anger) P.Anger()
			if(iconoverlay)
				P.overlays+=image(iconoverlay)
				spawn(20)P.overlays-=image(iconoverlay)
			P.Health-=Damage
			if(Damage>=5)
				Crater(P)
				P.Knockback(Knock_Distance,src)
			if(P.Health<=0&&!P.KO) P.Unconscious(src)
			else if(P.KO&&P.Health<=0) P.Death(src)
			if(P)
				if(explode)
					var/obj/Projectiles/Mystical/Q=new(get_step(src,dir))
					Explosion(Q,0,Damage*0.2,1)


				if(src.Warp)
					if(prob(src.Skillz["Warp"]["Level"]))
						src.Comboz(P)
						Delay/=10
				if(src.Package["Vampire"]==1)
					if(prob(50))
						var/amountz=src.EnergyMax/100
						if(P.Energy>amountz)
							P.Energy-=amountz
							src.Energy+=amountz
						else
							P.Energy=0

		else flick('Dodge.dmi',P)
		if(P)
			if(src.SparGuy==P&&P.SparGuy==src)
				if(P.client)
					if(P.EXP>src.EXP)
						if(prob(50/sqrt(src.SpeedMod)))
							src.EXP+=sqrt(abs(P.EXP-src.EXP))/2
					if(prob(Delay*20))
						src.Melee_Gain(2.25)
				else
					src.Melee_Gain(1)
			else
				src.SparGuy=P
				spawn(rand(100,500))if(src)src.SparGuy=null
		spawn(Delay) Attacking=0
		return
	for(var/obj/P in get_step(src,dir))
		Attacking=1
		if(src.client)
			Energy-=Drain
		if(istype(P,/obj/Items/Tech/PunchingBag))
			spawn(SpeedDelay()/1.2) Attacking=0
			if(src.dir==4)
				if(P.icon_state!="Destroyed")
					Melee_Graphics()
					Melee_Gain(0.3)
					flick("Hit",P)
					var/damage=src.Power*src.Strength/1000
					P.Health-=damage
					if(P.Health<1)
						P.icon_state="Destroyed"
					return
			else
				return
		else if(istype(P,/obj/Items/Tech/Log))
			spawn(SpeedDelay()/5) Attacking=0
			if(!P.icon_state)
				spawn(3000) if(P) P.icon_state=""
				P.icon_state="On"
				return
			Melee_Graphics()
			if(P.dir==turn(dir,180))
				Melee_Gain(0.9)
				P.dir=turn(P.dir,pick(90,-90))
			else
				if(prob(50))usr<<"The log cracks as you hit the wrong side! Be careful or it may break!"
				if(prob(10))
					P.icon_state="KO"
					spawn(600) if(P)if(P.icon_state=="KO") del(P)
			var/damage=src.Power*src.Strength/1000
			P.Health-=damage
			if(P.Health<=0)
				P.icon_state="KO"
				spawn(600) if(P) del(P)
			return
		else
			Melee_Graphics()
			spawn(SpeedDelay()/1.5) Attacking=0
		P.Health-=Power*Strength
		if(P.Health<=0) Destroy(P)
		return
	for(var/turf/P in get_step(src,dir))
		if(P.density)
			Attacking=1
			if(src.client)
				Energy-=Drain
			Melee_Graphics()
			spawn(SpeedDelay()/1.5) Attacking=0
			P.Health-=Power*Strength
			if(P.Health<=0) Destroy(P)
			return

mob/proc/SpeedDelay()
	var/WTF=Speed
	var/Lawl=Speed/1000
	if(Lawl>20)
		WTF-=5000
		Lawl=SpeedMod+(WTF/5000)+5
	else
		Lawl=SpeedMod+(WTF/1000)
	if(Lawl>100)
		Lawl=100
	return (100/Lawl)/SpeedEffect




mob/proc/Knockback(Distance,mob/P) spawn if(src)
	if(Distance>20)
		Distance=20
	if(Distance<1)
		Distance=1
	flick("KB",src)
	//icon_state="KB"
	Knockbacked=1
	while(Distance&&P)
		step_away(src,P,50)
		flick("KB",src)
		for(var/atom/A in get_step(src,dir)) if(isobj(A)||isturf(A)) if(A.density)
			A.Health-=P.Power
			if(A.Health<=0) Destroy(A)
		Distance-=1
		sleep(1)
	//if(icon_state=="KB") icon_state=""
	Knockbacked=0
mob/proc/Melee_Graphics()
	if(istype(src,/mob/Animals)) flick("[src.icon_state]Attack",src)
	else flick("Attack",src)
mob/Body
	New()
		..()
		spawn(6000)if(src)Spoil()
	verb/Eat()
		set src in oview(1)
		oview(10,usr)<<"[usr] eats [src]"
		del(src)
	proc/Spoil()
		src.overlays+=image("Misc.dmi","Flies")
	Del()
		for(var/obj/Items/I in src)
			if(I.Stealable)
				if(I.suffix=="Equipped")
					spawn(5) I.suffix=null
			I.loc=src.loc

		if(Target) Target<<"Your body has been destroyed."
		..()
mob/proc/Leave_Body()
	var/mob/Body/A=new(loc)
	A.icon_state="KO"
	A.name="Body of [src]"
	if(prob(20))
		src<<"<font color=red><big>DO NOT LOG OUT!"
		src<<"Your life is on the verge of complete oblivion, you are not completely dead and may still return to your body if it still remains!"
		Target=src //There is a small chance you will come back to life like Bardock
		spawn(3000) if(src&&A) A.Barely_Alive(Target)
	A.Race=Race
	A.Body=Body
	A.EnergyMax=EnergyMax
	A.Energy=Energy
	A.Power=Power
	A.Strength=Strength
	A.Endurance=Endurance
	A.Force=Force
	A.Resistance=Resistance
	A.icon=src.icon
	A.overlays=overlays
	A.overlays+=image('Misc.dmi',"Blood")
	for(var/obj/Items/I in src) if(I.Stealable)
		if(I.suffix=="Equipped")
			I.Equip(src)
			spawn(5)if(I) I.suffix="Equipped"
		A.contents+=I
mob/proc/Barely_Alive(mob/P) if(P)
	P.loc=loc
	P.Conscious()
	P.Health=1
	P.Energy=1
	P.Revive()
	P<<"You have returned to your body, barely alive."
	for(var/obj/Items/I in src)
		if(I.suffix=="Equipped") I.Equip(src)
		P.contents+=I
	del(src)


mob/proc/Grab()
	if(!Grab)
		var/list/Choices=new
		for(var/atom/O in get_step(src,dir))
			if((isobj(O)||ismob(O))&&O.Grabbable)
				if(istype(O,/obj/Items/Tech))
					if(O:Bolt)
						continue
				Choices+=O
		var/mob/P=input(src,"Grab what?") in Choices
		if(!(locate(P) in get_step(src,dir))) return
		if(istype(P,/obj/Items))
			var/obj/Items/buh=P
			if(buh:Pickable==1)
				var/Amount=0
				for(var/obj/Items/I in src) if(!istype(I,/obj/Items/Wearables)) Amount+=1
				if(Amount>=15)
					src<<"You cannot carry any more non-clothing items."
					return
				src.OMessage(10,"[src] picks up [P].","[src]([src.key]) picks up [ExtractInfo(P)].")
				if(istype(P,/obj/Items/Tech/Gravity))
					var/obj/Items/Tech/Gravity/Q=P
					Q.Off()
				P.Move(src)
				return
		if(istype(P,/obj/Money))
			for(var/obj/Money/M in src) M.Level+=P.Level
			src.OMessage(10,"[src] picks up [P].","[src]([src.key]) picks up ([P.Level])[ExtractInfo(P)].")
			del(P)
			return
		Grab=P
		src.OMessage(10,"[src] grabbed [P]!","[src]([src.key]) grabs [ExtractInfo(P)]")
		src.Grab_Update()
	else Grab_Release()

mob/proc/Grab_Release() Grab=null
mob/proc/Grab_Update()
	Grab.loc=loc
	if(KO) Grab_Release()