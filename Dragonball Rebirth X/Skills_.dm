mob/var/tmp/Beaming //If true when a direction is pressed, do not move, but change directions.
mob/proc/CanBlast(Drain)
	if(Drain>Energy) return
	if(!Knockbacked&&!Frozen&&!KO&&src.icon_state!="Meditate"&&src.icon_state!="Train"&&src.icon_state!="KO"&&src.icon_state!="KB") return 1
obj
	Taiyoken
		icon='Taiyoken.dmi'
		layer=999
obj
	Curse
mob/proc/Blind(var/duration=100)
	var/obj/x=new/obj/Taiyoken
	x.screen_loc="1,1 to 20,20"
	src.client.screen+=x
	spawn(20)src.client.screen-=x
	spawn(30)src.client.screen-=x
	while(prob(90))
		x.icon_state=pick("1","2","3","4")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("5","6","7","8")
		if(prob(40))sleep(0.1)
	while(prob(70))
		x.icon_state=pick("9","10","11","12")
		if(prob(40))sleep(0.1)
	while(prob(80))
		x.icon_state=pick("13","14","15","16")
		if(prob(40))sleep(0.1)
	while(prob(90))
		x.icon_state=pick("17","18","19","20")
		if(prob(40))sleep(0.1)
	src.client.eye=null
	spawn(duration)src.client.eye=src

mob/proc/SkillLeech(obj/Skills/x)
	if(!x)return
	if(src.icon_state=="Train"||src.icon_state=="Meditate")return
	for(var/mob/Players/M in viewers(10,src))
		if(M==src)continue
		if(prob(75))
			if(!locate(x,M.contents))
				if(x.Learn["energyreq"])
					if(!(M.EnergyMax>text2num(x.Learn["energyreq"])/4))
						continue
				var/probz=1
				if(x.Learn["difficulty"])
					probz=text2num(x.Learn["difficulty"])
				var/chance=(sqrt(sqrt(EnergyMax)))/probz
				chance/=LeechHard
				chance=min(chance,75)
				if(prob(chance))
					M.OMessage(15,"[M] learned [x.name] from watching [src]!","[M]([M.key]) learned [x.name]([x.type]) from watching [src]([src.key])!")
					var/obj/q=new x.type
					M.contents+=q

mob/proc/Teach(obj/Skills/A)
	if(A.Teachable==0)
		usr<<"Not teachable."
		return
	if(A.Level<100)
		usr<<"You must fully master this to teach it."
		return
	if(Energy<EnergyMax)
		usr<<"You need full energy to teach this."
		return
	var/list/Choices=new
	Choices+="Cancel"
	for(var/mob/Players/P in get_step(src,dir)) Choices+=P
	var/mob/Choice=input(src,"Teach who") in Choices
	if(Choice=="Cancel") return
	if(Energy<EnergyMax) return
	if(A.Learn["energyreq"]>Choice.EnergyMax)
		src<<"They dont have enough energy!"
		return
	Energy=0
	Choice.OMessage(15,"[src] psychically transfers the [A] skill to [Choice]!","[ExtractInfo(src)] psychically transfers the [A] skill to [ExtractInfo(Choice)]!")
	var/obj/q=new A.type
	Choice.contents+=q

mob/Players/verb
	Meditate()
		set category="Skills"
		usr.SkillX("Meditate",null,1)
	Train()
		set category="Skills"
		usr.SkillX("Train",null,1)
	Attack()
		set category="Skills"
		usr.SkillX("Attack",null,1)
	Grabz()
		set name="Grab"
		set category="Skills"
		usr.SkillX("Grab",null,1)
	Dig()
		set category="Skills"
		usr.SkillX("Dig",null,1)



mob/proc/SkillX(var/Wut,var/obj/Skills/Z,var/bypass=0)
	if(Z)
		if(!locate(Z) in src)
			return
	if(bypass||Z)
		switch(Wut)
			if("WolfFangFist")
				if(Z.Using||src.Attacking)return
				var/image/LOL=image('WolfFangFist.dmi',dir=src.dir)
				Z.Using=1
				spawn(600)
					if(src)
						Z.Using=0
						src<<"Delay finished."
				src.Melee(10,2,LOL,1)
				//mob/proc/Melee(var/damagemulti,var/speedmulti,var/iconoverlay,1)

			if("VAbsorb")
				if(src.Package["Vampire"]==1)
					src.Package["Vampire"]=null
					src<<"Disabled Vampire absorb."
					src.ForceMod/=0.5
					src.Force/=0.5
					src.Resistance/=0.5
					src.ResistanceMod/=0.5
				else
					src.Package["Vampire"]=1
					src<<"Enabled Vampire Absorb."
					src.ForceMod*=0.5
					src.Force*=0.5
					src.Resistance*=0.5
					src.ResistanceMod*=0.5
			if("VFrenzy")
				if(Z.Using)
					Z.Using=0
					src.SpeedMod/=3
					src.Speed/=3
					src.OffenseMod/=0.25
					src.Offense/=0.25
					src.DefenseMod/=0.25
					src.Defense/=0.25
					src.OMessage(10,"[src] returns to normal as his frenzy ends.","<font color=red>[src]([src.key]) de-activated VampireFrenzy.")
					src.icon=Z:oldicon
					Z:oldicon=null
				else
					Z.Using=1
					src.SpeedMod*=3
					src.Speed*=3
					src.OffenseMod*=0.25
					src.Offense*=0.25
					src.DefenseMod*=0.25
					src.Defense*=0.25
					src.OMessage(10,"[src] thirsts for blood as his skin tone begins to blend in with his backgrounds entering a frenzy!.","<font color=red>[src]([src.key]) activated VampireFrenzy.")
					Z:oldicon=src.icon
					var/icon/Heh=new(src.icon)
					Heh.Blend(rgb(0,0,0,80),ICON_ADD)
					src.icon=Heh




			if("Dig")
				if(src.KO||src.icon_state=="Meditate"||src.icon_state=="Train"||src.icon_state=="Flight"||src.Beaming||src.Attacking) return
				if(src.icon_state!="KB")
					src.Digging=1
					src.icon_state="KB"
					src.Frozen=1
				else
					src.icon_state=""
					src.Digging=0
					src.Frozen=0

			if("Meditate")
				if(src.KO||src.icon_state=="KB"||src.icon_state=="Train"||src.icon_state=="Flight"||src.Beaming||src.Attacking) return
				if(src.icon_state!="Meditate")
					src.dir=SOUTH
					src.icon_state="Meditate"
				else
					//src.dir=SOUTH
					src.icon_state=""
				sleep(10)
			if("Train")
				if(src.KO||src.icon_state=="KB"||src.icon_state=="Meditate"||src.icon_state=="Flight"||src.Beaming||src.Attacking) return
				if(src.icon_state!="Train") src.icon_state="Train"
				else src.icon_state=""
				sleep(1)
			if("Attack")
				src.Melee()
			if("Grab")
				src.Grab()
			if("Heal")
				if(src.KO)return
				for(var/mob/Players/P in get_step(src,src.dir))
					view(src)<<"[src] heals [P]"
					if(src.Class!="Healer")
						src.Health-=100/(1+(Z.Level*0.02))
					src.Energy-=100/(1+(Z.Level*0.02))
					Z.Level++
					if(P.KO) P.Conscious()
					P.Health=100
					P.Energy=P.EnergyMax
					src.SkillLeech(Z)
					return
			if("Fly")
				if(src.KO||src.icon_state=="Meditate"||src.icon_state=="Train"||src.icon_state=="KB") return
				if(src.Flying)
					src.Flying=0
					src.icon_state=""
				else if(src.Energy>(src.EnergyMax/Level/src.Efficiency/10))
					src.Flying=1
					src.icon_state="Flight"
				else
					src<<"You do not have enough energy to fly."
			if("Observe")
				var/list/PeopleX=new
				for(var/mob/M in world)
					if(M.client)
						PeopleX+=M
				var/mob/A=input(src,"Observe who?") in PeopleX||null
				if(A)
					Observify(src,A)
					if(A==src)
						src.Observing=0
					else
						src.Observing=1
			if("Makosen")
				var/Drain=5/Z.Efficiency
				if(!src.CanBlast(Drain)) return
				if(src.Attacking)return
				src.Attacking=1
				spawn(src.Refire/Z.Speed*10) src.Attacking=0
				var/Blasts=rand(2*sqrt(Z.Level),5*sqrt(Z.Level))
				Z.Skill_Increase(3)
				while(Blasts>1)
					Blasts-=1
					if(!src.CanBlast(Drain)) return
					flick("Blast",src)
					src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
					var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
					A.Distance=Distance
					A.pixel_y=rand(-24,24)
					A.pixel_x=rand(-24,24)
					A.x+=rand(-1,1)
					A.y+=rand(-1,1)
					A.dir=src.dir
					A.icon=Z.sicon
					A.icon_state=Z.sicon_state
					A.Owner=src
					A.Damage_Multiplier=0.3
					A.Offense=src.Offense*src.Skill
					spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("Kienzan")
				var/Drain=100/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				src.Attacking=1
				src.Beaming=1
				src.overlays+=image(icon=Z.sicon,icon_state=Z.sicon_state,pixel_y=28)
				sleep(src.Refire/(Z.Speed*(sqrt(Z.Level)/30)))
				src.overlays-=image(icon=Z.sicon,icon_state=Z.sicon_state,pixel_y=28)
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)+(src.EnergyMax/10)
				src.Attacking=0
				src.Beaming=0
				Z.Skill_Increase(2.15)
				flick("Blast",src)
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.dir=src.dir
				A.icon=Z.sicon
				A.Pierce=1
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=25
				A.Deflectable=0
				spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("Charge")
				var/Drain=50/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				src.Attacking=1
				src.Beaming=1
				src.Chargez("Add")
				sleep(src.Refire/(Z.Speed*(sqrt(Z.Level)/10)))
				src.Chargez("Remove")
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
				src.Attacking=0
				src.Beaming=0
				Z.Skill_Increase(2.5)
				flick("Blast",src)
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.Explosive=1
				A.Knockback=1
				A.dir=src.dir
				A.icon=Z.sicon
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=3
				A.Offense=src.Offense*src.Skill*45
				spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("Sokidan")
				var/Drain=75/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				src.Attacking=1
				src.Beaming=1
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)+(src.EnergyMax/10)
				Z.Skill_Increase(1.75)
				flick("Blast",src)
				var/obj/Projectiles/Mystical/A=new(get_step(src,turn(src.dir,180)))
				A.Distance=sqrt(Z.Level)*3
				A.dir=src.dir
				A.icon=Z.sicon
				A.Explosive=1
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=8
				A.Offense=src.Offense*src.Skill*50
				src.SkillLeech(Z)
				src.Control=A
				while(A)
					if(!src)break
					step(A,src.dir)
					if(prob(20))src.SkillLeech(Z)
					sleep(10/(sqrt(Z.Level)*sqrt(Z.Level)))
				src.Attacking=0
				src.Beaming=0
			if("Kikoho")
				var/Drain=100/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				src.Attacking=1
				src.Beaming=1
				src.Chargez("Add")
				sleep(src.Refire/(Z.Speed*(sqrt(Z.Level)/10)))
				src.Chargez("Remove")
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
				src.Health-=50/sqrt(Z.Level)
				src.Attacking=0
				src.Beaming=0
				Z.Skill_Increase(3)
				flick("Blast",src)
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.Radius=1
				A.Explosive=1
				A.Deflectable=0
				A.Knockback=1
				A.dir=src.dir
				A.icon=Z.sicon
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=50
				A.Offense=src.Offense*src.Skill*120
				spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("Blast")
				EXP+=(EXPGains/100)*0.00004
				var/Drain=5/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				flick("Blast",src)
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
				src.Attacking=1
				spawn(src.Refire/Z.Speed*(1/sqrt(Z.Level*Z.Level))*100) src.Attacking=0
				Z.Skill_Increase()
				//if(!prob(Z.Level)) return
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.pixel_y=rand(-16,16)
				A.pixel_x=rand(-16,16)
				A.dir=src.dir
				A.icon=Z.sicon
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=0.1
				A.Offense=src.Offense*src.Skill
				spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("Barrage")
				EXP+=(EXPGains/100)*0.00004
				var/Drain=5/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				flick("Blast",src)
				src.Energy-=Drain/src.Efficiency*300*(1/Z.Level)
				src.Attacking=1
				spawn(src.Refire/Z.Speed*(1/sqrt(Z.Level*Z.Level))*100) src.Attacking=0
				Z.Skill_Increase()
				//if(!prob(Z.Level)) return
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.pixel_y=rand(-10,10)
				A.pixel_x=rand(-10,10)
				A.dir=src.dir
				A.icon=Z.sicon
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=0.1
				A.Offense=src.Offense*src.Skill
				var/obj/Projectiles/Mystical/B=new(get_step(src,src.dir))
				B.Distance=Distance
				B.pixel_y=rand(-10,10)
				B.pixel_x=rand(-10,10)
				B.dir=src.dir
				B.icon=Z.sicon
				B.icon_state=Z.sicon_state
				B.Owner=src
				B.Damage_Multiplier=0.1
				B.Offense=src.Offense*src.Skill
				var/obj/Projectiles/Mystical/C=new(get_step(src,src.dir))
				C.Distance=Distance
				C.pixel_y=rand(-10,10)
				C.pixel_x=rand(-10,10)
				C.dir=src.dir
				C.icon=Z.sicon
				C.icon_state=Z.sicon_state
				C.Owner=src
				C.Damage_Multiplier=0.1
				C.Offense=src.Offense*src.Skill
				spawn
					if(B)
						step(B,turn(B.dir,90))
					if(C)
						step(C,turn(C.dir,-90))
						//step(B,A.dir)
						//step(D,A.dir)
					if(A)
						walk(A,A.dir)
						if(B)walk(B,A.dir)
						if(C)walk(C,A.dir)
				src.SkillLeech(Z)
			if("Beam")
				if(src.KO)return
				var/Drain=5/Z.Efficiency
				if(!src.CanBlast(Drain)) return
				if(!Z:Charging&&!Z.Using&&!src.Attacking)
					src.Beam_Charge(Z)
				else if(Z:Charging&&!Z.Using)
					src.Beam_Go(Z)
				else if(Z.Using)
					src.Beam_Stop(Z)
			if("Taiyoken")
				if(src.KO)return
				if(src.Energy>=min(src.EnergyMax*(25/sqrt(Z.Level)*sqrt(Z.Level)),src.EnergyMax))
					src.Energy-=min(src.EnergyMax*(25/(sqrt(Z.Level)*sqrt(Z.Level))),src.EnergyMax)
					Z.Skill_Increase(2.5)
					src.SkillLeech(Z)
					var/obj/x=new /obj/Taiyoken


					for(var/turf/M in Turf_Circle(src,max(sqrt(Z.Level)*sqrt(Z.Level)/15,1)))
						if(prob(20))continue
						x.icon_state="4"
						M.overlays+=x
						for(var/mob/Q in view(0,M))
							if(Q==src)continue
							Q<<"You are blinded!"
							var/duration=sqrt(src.EnergyMax)/sqrt(Q.EnergyMax)+(sqrt(src.Power)/sqrt(Q.Power))
							duration=max(min(duration,2000),1)
							spawn Q.Blind(duration*sqrt(Z.Level))
						spawn(rand(1,2))M.overlays+=x
						spawn(rand(2,3))M.overlays+=x
						spawn(rand(3,4))M.overlays+=x
						spawn(rand(4,5))M.overlays-=x
						spawn(rand(5,6))M.overlays-=x
						spawn(rand(6,7))M.overlays-=x
						spawn(rand(7,8))M.overlays-=x
						spawn(rand(9,10))M.overlays-=x
						if(prob(10))sleep(0.1)

			if("Telepath")
				var/list/PeopleX=list("Cancel")
				for(var/mob/Players/M in world)
					if(M.client)
						PeopleX+=M
				var/mob/A=input(src,"Telepath who?") in PeopleX
				if(A=="Cancel")return
				var/message=input(src,"What do you want to telepath?") as text
				message=copytext(message,1,500)
				if(A)
					A<<"<font face=Old English Text MT><font color=red>[src] says in telepathy, '[html_encode(message)]'"
					A.OMessage(0,null,"<font color=purple>[A]([A.key]) recieved the telepath '[html_encode(message)]' from [src]([src.key])")
				if(src)
					src<<"<font face=Old English Text MT><font color=red>You telepathed [A], '[html_encode(message)]'"
					src.OMessage(0,null,"<font color=purple>[src]([src.key]) telepathed '[html_encode(message)]' to [A]([A.key])")
			if("PowerUp")
				if(src.KO)return
				if(src.PowerUp)
					src.Transform()
					return
				if(!src.PowerUp&&!src.PowerDown)
					src.PowerUp=1
					src<<"You begin powering up."
					src.Auraz("Add")
				if(src.PowerDown&&!src.PowerUp)
					src<<"You stop powering down."
					src.Auraz("Remove")
					src.PowerDown=0
			if("PowerDown")
				if(src.KO)return
				if(src.PowerDown)
					src.Revert()
					src.Auraz("Add")
					return
				if(!src.PowerDown&&!src.PowerUp)
					src.PowerDown=1
					src<<"You begin powering down."
					src.Auraz("Add")
				if(src.PowerUp)
					src.PowerUp=0
					src<<"You stop powering up."
					src.Auraz("Remove")
			if("RestoreYouth")
				var/list/PeopleX=new
				for(var/mob/Players/M in get_step(src,dir))
					PeopleX+=M
				var/mob/A=input(src,"Restore the Youth of who?") in PeopleX||null
				if(A)
					var/amount=input(src,"To what age?","(0-20)")as num
					amount=max(min(amount,20),0.1)
					A.Age=amount
					src.OMessage(10,"[src] restored the youth of [A].","<font color=red>[src]([src.key]) restored the youth of [A]([A.key]) to [amount]")

			if("Revive")
				if(src.KO)return
				if(!src.Dead)
					if(Z:LastTime)
						if(Year<Z:LastTime+1)
							src<<"You cannot use this until year [Z:LastTime+1]."
							return
					var/list/PeopleX=new
					for(var/mob/Players/M in get_step(src,dir))
						if(M.Dead)
							PeopleX+=M
					var/mob/A=input(src,"Revive who?") in PeopleX||null
					if(A)
						Z:LastTime=Year
						src.OMessage(10,"[A] was revived by [src].","<font color=red>[src]([src.key]) revived [A]([A.key])")
						src.Energy=1
						A.Dead=0
						A.overlays-='Halo.dmi'
			if("Ressurect")
				if(src.KO)return
				if(!src.Dead)
					if(Z:LastTime)
						if(Year<Z:LastTime+1)
							src<<"You cannot use this until year [Z:LastTime+1]."
							return
					var/list/PeopleX=new
					for(var/mob/Players/M in get_step(src,dir))
						if(M.Dead)
							PeopleX+=M
					var/mob/A=input(src,"Revive who?") in PeopleX||null
					if(A)
						Z:LastTime=Year
						src.OMessage(10,"[A] was ressurected by [src]'s Outer Path!","<font color=red>[src]([src.key]) revived [A]([A.key])")
						src.Energy=1
						src.Health/=4
						A.Dead=0
						A.overlays-='Halo.dmi'
			if("Condemn")
				if(!Z.Using)
					Z.Using=1
					usr.OMessage(20,"[usr] opens a portal to the Dead Zone using the Naraka Path!!","[usr]([usr.key]) opened the deadzone.")
					new/obj/Effects/DeadZone(locate(usr.x,usr.y+4,usr.z))
					spawn(300) Z.Using=0
			if("UnBind")
				if(Z:LastTime)
					if(Year<Z:LastTime+1)
						src<<"You cannot use this until year [Z:LastTime+1]."
						return

				var/list/PeopleX=new
				for(var/mob/Players/M in get_step(src,dir))
					PeopleX+=M
				var/mob/A=input(src,"UnBind who?") in PeopleX||null
				if(A)
					for(var/obj/Curse/Q in A)
						Z:LastTime=Year
						Q.Power-=src.Power*src.Energy
						if(Q.Power<=0)
							src.OMessage(10,"[A] was unbinded from hell by [src].","<font color=red>[src]([src.key]) unbinded(broke bind) [A]([A.key])")
							del(Q)
						else
							src.OMessage(10,"[src] was lessened the bind on [A].","<font color=red>[src]([src.key]) unbinded(failed, lessened) [A]([A.key])")
						src.Energy=1

			if("Bind")
				var/list/PeopleX=new
				for(var/mob/Players/M in get_step(src,dir))
					PeopleX+=M
				var/mob/A=input(src,"Bind who?") in PeopleX||null
				if(A)
					if(src.Power*src.Energy<A.Power*A.Energy)
						src.OMessage(10,"[A] deflected [src]'s bind!","<font color=red>[src]([src.key]) bind was failed and deflecte by [A]([A.key])")
						return
					for(var/obj/Curse/Q in A)
						Q.Power+=src.Power*src.Energy
						src.OMessage(10,"[src] increased the power of the current bind on [A].","<font color=red>[src]([src.key]) binded(to hell strengethened) [A]([A.key])")
						src.Energy=1
						return
					src.OMessage(10,"[A] was binded to hell by [src].","<font color=red>[src]([src.key]) binded(to hell) [A]([A.key])")
					var/obj/Curse/L=new
					L.Power=src.Power*src.Energy
					A.contents+=L
					src.Energy=1
			if("FalseMoon")
				if(src.KO)return
				src.OMessage(10,"[src] conjures up a ball of energy into his palm and chucks it into the sky!.","[src]([src.key]) made a false moon!")
				var/obj/ProjectionMoon/Q=new(src.loc)
				Q.Skill=15000
			if("Shield")
				if(src.KO)return
				if(!Z.Using)
					src.overlays+=image(icon='Shield.dmi')
					Z.Using=1
				else if(Z.Using)
					src.overlays-=image(icon='Shield.dmi')
					Z.Using=0
			if("Zanzoken")
				if(Z.Using==1)
					src<<"Zanzoken is disabled."
					Z.Using=0
				else
					Z.Using=1
					src<<"Zanzoken is enabled."
			if("Mysticize")
				var/list/PeopleX=new
				for(var/mob/M in get_step(src,dir))
					if(!locate(/obj/Skills/Buffs/Majin,M.contents)&&!locate(/obj/Skills/Buffs/Mystic,M.contents))
						PeopleX+=M
				var/mob/A=input(src,"Mystize who?") in PeopleX||null
				if(A)
					src.OMessage(10,"[A] was Mysticized by [src]..","<font color=red>[src]([src.key]) Mysticized [A]([A.key])")
					A.contents+=new/obj/Skills/Buffs/Mystic
			if("Majinize")
				var/list/PeopleX=new
				for(var/mob/M in get_step(src,dir))
					if(!locate(/obj/Skills/Buffs/Majin,M.contents)&&!locate(/obj/Skills/Buffs/Mystic,M.contents))
						PeopleX+=M
				var/mob/A=input(src,"Majinize who?") in PeopleX||null
				if(A)
					src.OMessage(10,"[A] was Majinized by [src]..","<font color=red>[src]([src.key]) Majinized [A]([A.key])")
					A.contents+=new/obj/Skills/Buffs/Majin
			if("CurseEyes")
				var/list/PeopleX=new
				for(var/mob/M in get_step(src,dir))
					if(!locate(/obj/Skills/Buffs/Sharingan,M.contents))
						PeopleX+=M
				var/mob/A=input(src,"Curse the eyes of whom?") in PeopleX||null
				if(A)
					src.OMessage(10,"[A]'s eyes were cursed by [src]..","<font color=red>[src]([src.key]) cursed [A]([A.key])'s eyes.")
					A.contents+=new/obj/Skills/Buffs/Sharingan
			if("MakeAmulet")
				if(src.Energy>src.EnergyMax/10)
					var/obj/A=new/obj/Items/Amulet
					src.contents+=A
					src.OMessage(10,"[src] made an Amulet.","<font color=red>[src]([src.key]) made an Amulet.")
					src.Energy-=src.EnergyMax/10

			if("ThirdEye")
				if(!Z.Using)
					src.see_invisible=1
					src.AngerMax/=1.3
					src.Regeneration*=1.3
					src.Speed*=1.3
					src.BaseMod*=1.2
					src.Base*=1.2
					src.overlays+='Third Eye.dmi'
					src.OMessage(10,"[src] concentrates the power of their mind and unlocks their Third Eye.","<font color=red>[src]([src.key]) activated Third-Eye.")
					Z.Using=1
				else
					src.AngerMax*=1.3
					src.Regeneration/=1.3
					src.Speed/=1.3
					src.BaseMod/=1.2
					src.Base/=1.2
					src.overlays-='Third Eye.dmi'
					src.OMessage(10,"[src] represses the power of their Third Eye.","<font color=red>[src]([src.key]) deactivated Third-Eye.")
					Z.Using=0
				sleep(10)

			if("Sharingan")
				if(!Z.Using)
					src.see_invisible=1
					src.BaseMod*=1.3
					src.Base*=1.3
					src.Offense*=1.3
					src.OffenseMod*=1.3
					src.Defense*=1.3
					src.DefenseMod*=1.3
					src.overlays+='Sharingan.dmi'
					src.OMessage(10,"[src]'s pupils dilate and turn red as they activate their Sharingan!")
					Z.Using=1
				else
					src.see_invisible=0
					src.BaseMod/=1.3
					src.Base/=1.3
					src.Offense/=1.3
					src.OffenseMod/=1.3
					src.Defense/=1.3
					src.DefenseMod/=1.3
					src.overlays-='Sharingan.dmi'
					src.OMessage(10,"[src]'s pupils revert as they deactivate their Sharingan.")
					Z.Using=0
				sleep(10)

			if("Rinnegan")//Give Ressurect, AlmightyPush, KeepBody, Condemn
				if(!Z.Using)
					src.see_invisible=1
					src.BaseMod*=1.5
					src.Base*=1.5
					src.Energy*=1.5
					src.EnergyMax*=1.5
					src.overlays+='Rinnegan.dmi'
					src.OMessage(10,"[src]'s pupils spiral as their Rinnegan activates!")
					Z.Using=1
				else
					src.see_invisible=0
					src.BaseMod/=1.5
					src.Base/=1.5
					src.EnergyMax/=1.5
					src.overlays-='Rinnegan.dmi'
					src.OMessage(10,"[src]'s pupils fade to their normal state as their Rinnegan recedes.")
					Z.Using=0

			if("Focus")
				if(!Z.Using)
					if(src.Energy<src.EnergyMax/10)return
					src.Power_Multiplier+=0.4
					src.Regeneration*=1.3
					src.Force*=1.5
					src.Speed*=1.4
					src.OMessage(10,"[src] heightens their senses and alertness to focus.","<font color=red>[src]([src.key]) activated Focus.")
					Z.Using=1
				else
					src.Power_Multiplier-=0.4
					src.Regeneration/=1.3
					src.Force/=1.5
					src.Speed/=1.4
					src.OMessage(10,"[src] begins to relax as their focus returns to normal..","<font color=red>[src]([src.key]) deactivated Focus.")
					Z.Using=0
				sleep(10)
			if("Expand")
				var/expand=0
				if(!Z.Using)
					var/expandmax=max(1,round(Z.Level/25))
					expand=input("Choose an expand level","(1-[expandmax])")as num
					if(expand==0)return
					expand=max(min(expand,expandmax),1)

					if(src.Race in list("Namekian","Demi","Makyo"))
						Z:Iconz=src.icon
						if(src.overlays)Z:Overlayz.Add(src.overlays)
						src.overlays-=src.overlays
						var/icon/Heh=new(src.icon)
						src.icon=null
						if(src.Hair)Heh.Blend(Hair,ICON_OVERLAY)
						var/lolol=2*expand*expand+32
						Heh.Scale(lolol,lolol)
						src.overlays+=image(Heh,pixel_x=-(lolol-32)/2,pixel_y=-(lolol-32)/2)
				else
					if(src.Race in list("Namekian","Demi","Makyo"))
						src.overlays-=src.overlays
						src.icon=Z:Iconz
						src.overlays.Add(Z:Overlayz)
						Z:Iconz=null
						Z:Overlayz-=Z:Overlayz
				if(Z.Using>expand)
					src.OMessage(10,"[src] slinks back down to size as their power lessens.","<font color=red>[src]([src.key]) deactivated Expand.")
					while(Z.Using>expand)
						Z.Using--
						usr.Power_Multiplier-=0.25
						usr.Strength/=1.3
						usr.StrengthMod/=1.3
						usr.Endurance/=1.1
						usr.EnduranceMod/=1.1
						if(!(src.Race in list("Namekian","Demi","Makyo")))
							usr.Speed*=1.2
							usr.SpeedMod*=1.2
						usr.Regeneration/=0.8
						usr.Recovery/=0.8
						if(!(src.Race in list("Makyo")))
							usr.OffenseMod/=0.9
							usr.Offense/=0.9
						if(!(src.Race in list("Namekian")))
							usr.DefenseMod/=0.9
							usr.Defense/=0.9
				else if(Z.Using<expand)
					src.OMessage(10,"[src] expands their muscles as their veins protrude to the surface.([expand]x)","<font color=red>[src]([src.key]) activated Expand([expand]x).")
					while(Z.Using<expand)
						Z.Using++
						usr.Power_Multiplier+=0.25
						usr.Strength*=1.3
						usr.StrengthMod*=1.3
						usr.Endurance*=1.1
						usr.EnduranceMod*=1.1
						if(!(src.Race in list("Namekian","Demi","Makyo")))
							usr.Speed/=1.2
							usr.SpeedMod/=1.2
						usr.Regeneration*=0.8
						usr.Recovery*=0.8
						if(!(src.Race in list("Makyo")))
							usr.OffenseMod*=0.9
							usr.Offense*=0.9
						if(!(src.Race in list("Namekian")))
							usr.DefenseMod*=0.9
							usr.Defense*=0.9
			if("Mystic")
				if(!Z.Using)
					Z.Using=1
					src.Power_Multiplier+=0.25
					src.Speed*=1.5
					src.SpeedMod*=1.5
					src.Recovery*=2
					src.AngerMax*=0.5
					src.overlays-=image(icon='Auras.dmi',icon_state="Mystic")
					src.overlays+=image(icon='Auras.dmi',icon_state="Mystic")
					//src.Hairz("Remove")
					//src.Hairz("Add")
					src<<"You are now in Mystic."
				else
					src.Power_Multiplier-=0.25
					src<<"You stop using your Mystic power."
					src.overlays-=image(icon='Auras.dmi',icon_state="Mystic")
					Z.Using=0
					src.Speed/=1.5
					src.SpeedMod/=1.5
					src.AngerMax*=2
					src.Recovery/=2
				sleep(20)
			if("Majin")
				if(!Z.Using)
					Z.Using=1
					if(AngerMax>=2)
						return Anger()
					else
						Anger=2
					Anger()
					src.overlays-=image(icon='Auras.dmi',icon_state="Majin")
					src.overlays+=image(icon='Auras.dmi',icon_state="Majin")
					src<<"You are now in Majin."
				else
					Anger=0
					src<<"You stop using your Majin power."
					src.overlays-=image(icon='Auras.dmi',icon_state="Majin")
					Z.Using=0
				sleep(20)
			if("OlympianFury")
				if(!Z.Using)
					Z.Using=1
					src.see_invisible=1
					src.Strength*=2
					src.StrengthMod*=2
					src.Speed*=1.5
					src.SpeedMod*=1.5
					src.Defense*=1.2
					src.DefenseMod*=1.2
					src.BaseMod*=2
					src.Base*=2
					src.overlays+='OFAura.dmi'
					src.OMessage(10,"[src] unleashes their Olympian Fury!")
				else
					src.see_invisible=0
					src.Strength/=2
					src.StrengthMod/=2
					src.Speed/=1.5
					src.SpeedMod/=1.5
					src.Defense/=1.2
					src.DefenseMod/=1.2
					src.BaseMod/=2
					src.Base/=2
					src.overlays-='OFAura.dmi'
					src.OMessage(10,"[src] calms their fury down.")
					Z.Using=0

			if("DivineBlessing")
				if(!Z.Using)
					Z.Using=1
					src.Power_Multiplier+=0.5
					src.AngerMax/=1.2
					src.Endurance*=1.2
					src.EnduranceMod*=1.2
					src.Defense*=1.25
					src.DefenseMod*=1.25
					src.overlays-=image(icon='Auras.dmi',icon_state="DB")
					src.overlays+=image(icon='Auras.dmi',icon_state="DB")
					src<<"You are now in Divine Blessing."
				else
					src.Power_Multiplier-=0.5
					src.AngerMax*=1.2
					src.Endurance/=1.2
					src.EnduranceMod/=1.2
					src.Defense/=1.25
					src.DefenseMod/=1.25
					src<<"You stop using your Divine power."
					src.overlays-=image(icon='Auras.dmi',icon_state="DB")
					Z.Using=0
				sleep(20)
			if("DemonicWill")
				if(!Z.Using)
					Z.Using=1
					src.Power_Multiplier+=0.5
					src.AngerMax/=1.2
					src.Strength*=1.2
					src.StrengthMod*=1.2
					src.Offense*=1.25
					src.OffenseMod*=1.25
					src.overlays-=image(icon='Auras.dmi',icon_state="DW")
					src.overlays+=image(icon='Auras.dmi',icon_state="DW")
					src<<"You are now in Demonic Will."
				else
					src.Power_Multiplier-=0.5
					src.AngerMax*=1.2
					src.Strength/=1.2
					src.StrengthMod/=1.2
					src.Offense/=1.25
					src.OffenseMod/=1.25
					src<<"You stop using your Demonic Will power."
					src.overlays-=image(icon='Auras.dmi',icon_state="DW")
					Z.Using=0
				sleep(20)
			if("KeepBody")
				for(var/mob/Players/P in get_step(src,dir))
					if(P.KeepBody)
						P.KeepBody=0
						src.OMessage(10,"[src] takes [P]'s body","[src]([src.key]) took [P]([P.key]) 's body")

					else
						P.KeepBody=1
						src.OMessage(10,"[src] gives [P]'s their body.","[src]([src.key]) gave [P]([P.key]) their body.")
					break
			if("GivePower")
				if(!src.KO)
					if(Energy>EnergyMax/2)
						for(var/mob/P in get_step(src,dir))
							if(!prob(Z.Level/5))
								src.Unconscious(null,"giving power to [P]!")
							src.Health=1
							src.Energy=1
							P.Energy=max(min(P.EnergyMax+src.Energy,P.Energy+src.Energy),P.Energy*1.1)
							src.OMessage(10,null,"[src]([src.key]) gave power to [P]([P.key])")
							Z.Skill_Increase(3)
							src.SkillLeech(Z)
							return

			if("Absorb")
				for(var/mob/Players/P in get_step(src,src.dir))
					if(P.KO)
						if(Z.AdminInviso)
							src.OMessage(13,"[src] killed [P]!","[src]([src.key]) killed [P]([P.key])")
						else
							src.OMessage(13,"[src] absorbed [P]!","[src]([src.key]) absorbed [P]([P.key])")
						src.AbsorbPower=min(src.Base*20,src.AbsorbPower+P.Base*10)
						P.Death(src)
					return

			if("KaioTeleport")
				if(!src.KO&&src.Energy>=src.EnergyMax)
					src.OMessage(10,"[src] seems to be concentrating..")
					var/zz
					var/Where=input(src,"Choose Destination", "", text) in list ("Earth", "Namek", "Vegeta", "Ice", "Arconia", "Kaioshin", "Checkpoint", "Heaven","Nevermind")
					switch(Where)
						if("Earth")
							zz=1
						if("Namek")
							zz=2
						if("Vegeta")
							zz=3
						if("Arconia")
							zz=4
						if("Ice")
							zz=5
						if("Checkpoint")
							zz=8
						if("Heaven")
							zz=6
						if("Nevermind") return
					if(!src.KO&&src.Energy>=src.EnergyMax)
						src.Energy=0
						src.SkillLeech(Z)
						src.OMessage(10,"[src] suddenly vanishes!","<font color=aqua>[src]([src.key]) KaioTeleported to [Where].")
						for(var/mob/V in view(1,src.client.eye))
							if(V.client&&V!=src)
								spawn(20)V.loc=locate(usr.x,usr.y,zz)
								V.x-=1

								V<<"[usr] brings you with them using teleportation."
								V.ChatLog("<font color=aqua>[src]([src.key]) KaioTeleported to [Where]")
								src.ChatLog("<font color=aqua>[src]([src.key]) KaioTeleported to [Where]")
						if(Where=="Kaioshin")
							src.x=87
							src.y=481
							src.z=10
						else
							src.x=rand(1,500)
							src.y=rand(1,500)
							src.z=zz
					else src<<"You need full ki to use this."
				else src<<"You need full ki to use this."
			if("Kiai")
				if(src.KO)return
				if(src.Energy>EnergyMax/8)
					for(var/mob/P in oview(src))
						var/Damage=(src.Power*src.Force)/(P.Power*P.Resistance)*rand(sqrt(Z.Level)/10,sqrt(Z.Level)/5)
						var/Knock_Distance=round((src.Power*src.Force)/(P.Power*P.Resistance)*rand(sqrt(Z.Level)/10,sqrt(Z.Level)/5))
						P.Health-=Damage
						P.Knockback(Knock_Distance,src)
						src.Energy-=src.EnergyMax/8
						Z.Skill_Increase(1.75)
						src.SkillLeech(Z)
					sleep(50)

			if("AlmightyPush")
				if(src.KO)return
				if(src.Energy>EnergyMax/8)
					for(var/mob/P in oview(src))
						var/Damage=(src.Power*src.Force)/(P.Power*P.Resistance)*rand(sqrt(Z.Level)/10,sqrt(Z.Level)/5)*10
						var/Knock_Distance=round((src.Power*src.Force)/(P.Power*P.Resistance)*rand(sqrt(Z.Level)/10,sqrt(Z.Level)/5)*2)
						P.Health-=Damage
						P.Knockback(Knock_Distance,src)
						src.Energy-=src.EnergyMax/8
						Z.Skill_Increase(100)
						src.OMessage(10,null,"[src]([src.key]) pushes everyone away with the Deva Path!")
					sleep(100)
			if("Invisible")
				if(!src.invisibility)
					src.invisibility=1
					src<<"You are now invisible."
					src.OMessage(10,null,"<font color=red>[src]([src.key]) turns invisible.")
				else
					src.invisibility=0
					src<<"You are now visible."
					src.OMessage(10,null,"<font color=red>[src]([src.key]) turns visible.")
			if("Kaioken")
				if(src.KaiokenBP)
					src<<"You stop using Kaioken."
					src.KaiokenBP=0
					src.Speed*=0.5
					src.SpeedMod*=0.5
					src.Defense*=2
					src.DefenseMod*=2
					src.overlays-=image(icon='AurasBig.dmi',icon_state="Kaioken",pixel_x=-32)
				else if(!src.KaiokenBP&&!src.KO)
					var/amount=input(src,"Kaioken multiple. (You have Kaioken x[src.KaiokenMastery] mastered)") as num
					if(amount<1) amount=1
					amount=round(amount)
					if(!usr.KaiokenBP)
						if(amount>=src.KaiokenMastery*0.5)
							src.overlays+=image(icon='AurasBig.dmi',icon_state="Kaioken",pixel_x=-32)
							view(src)<<"A bright red aura bursts all around [src]."
						else src<<"You begin using Kaioken, an aura does not appear because this level of kaioken is effortless to you."
						src.KaiokenBP=2000*src.KaiokenMastery*amount
						src.Speed*=2
						src.SpeedMod*=2
						src.Defense*=0.5
						src.DefenseMod*=0.5
						src.SkillLeech(Z)
						src.OMessage(15,null,"<font color=red>[src]([src.key]) uses Kaioken x[amount].")
			if("Imitate")
				if(src.KO)return
				if(!Z.Using)
					Z.Using=1
					Z:imitatorname=src.name
					Z:imitatoroverlays.Add(src.overlays)
					Z:imitatoricon=src.icon
					var/list/People=new/list
					for(var/mob/A in oview(src)) if(A.client) People.Add(A)
					var/mob/Choice=input(src,"Imitate who?") in People
					if(Choice)
						src.icon=Choice.icon
						src.overlays.Remove(src.overlays)
						src.overlays.Add(Choice.overlays)
						src.name=Choice.name
						src.OMessage(15,null,"<font color=red>[src]([src.key]) imitates [Choice]([Choice.key])")
						src.SkillLeech(Z)
				else
					Z.Using=0
					src.name=Z:imitatorname
					src.overlays.Remove(src.overlays)
					src.overlays.Add(Z:imitatoroverlays)
					src.icon=Z:imitatoricon
					Z:imitatoroverlays.Remove(Z:imitatoroverlays)
					src.OMessage(15,null,"<font color=aqua>[src]([src.key]) stops imitating.")
			if("NamekianFusion")
				if(src.KO)return
				var/list/Choices=new
				Choices+="Cancel"
				for(var/mob/Players/P in get_step(src,dir)) Choices+=P
				var/mob/Choice=input(src,"Fuse with who?") in Choices
				if(Choice=="Cancel") return
				if(Choice.Race=="Namekian")
					var/answer=input(Choice,"[src] wants to fuse with you, do you accept?")in list("Yes","No")
					if(answer=="Yes")
						if(Choice&&src)
							Choice.Base+=src.Base/2
							Choice.EnergyMax+=src.EnergyMax/4
							Choice.FlySkill+=10000
							Choice.ZanzokenSkill+=10000
							Choice.Decline+=100
							src.Death(null,"fusing with [Choice]!")
							src.OMessage(10,"[src] fused with [Choice]!","<font color=red>[src]([src.key]) FUSED with [Choice]([Choice.key])")

			if("UnlockPotentinal")
				if(src.KO)return
				var/list/Choices=new
				Choices+="Cancel"
				for(var/mob/Players/P in get_step(src,dir)) Choices+=P
				var/mob/Choice=input(src,"Unlock the Potentinal of who?") in Choices
				if(Choice=="Cancel") return
				if(Choice.Potential)
					Choice.Base+=Choice.Potential*Year*25*Choice.BaseMod
					Choice.EnergyMax+=Choice.Potential*Year*100*Choice.EnergyMod
					Choice.FlySkill+=Choice.Potential*Year*20*Choice.FlySkillMod
					Choice.ZanzokenSkill+=Choice.Potential*20*Year*Choice.ZanzokenSkillMod
					Choice.Potential=0
					Choice.Decline+=Choice.Potential*10
					src.OMessage(10,"[src] unlocked [Choice]'s Potential.","<font color=red>[src]([src.key]) UNLOCKED THE Potential of [Choice]([Choice.key])")
			if("Regenerate")
				if(!src.Regenerate&&!src.KO&&src.Energy>src.EnergyMax/10)
					src.Regenerate=1
					src.OMessage(10,"[src] starts Regenerating.")
					sleep(30)

				else
					if(src.Regenerate)
						src.Regenerate=0
						src.OMessage(10,"[src] stops Regenerating.")
						sleep(30)
			if("Materialize")
				var/weights=input(src,"How heavy? Between 1 and [src.EnergyMax*2] pounds. You can lift [src.WeightFormula(2)] Pounds.") as num
				if(weights>src.EnergyMax*2) weights=src.EnergyMax*2
				if(weights<1) weights=1
				weights=round(weights)
				var/obj/Items/A=new/obj/Items/Weights
				A.Level=weights
				A.name="Weighted Material([weights] pounds)"
				A.icon='Clothes17.dmi'
				var/Icon_Color=input(A,"Choose color") as color|null
				if(Icon_Color) A.icon+=Icon_Color
				src.contents+=A
			if("SelfDestruct")
				if(src.Dead)return
				if(src.Alert("You sure you want to Self Destruct?"))
					src.Frozen=1
					src.OMessage(20,"[src] begins gathering all the energy around them into their body!","[src]([src.key]) used self destruct!")
					sleep(20)
					src.OMessage(20,"The ground begins to shake fiercely around [src]!",null)
					sleep(30)
					src.OMessage(20,"A huge explosion eminates from [src] and surrounds the area!")
					src.SkillLeech(Z)
					var/obj/x=new/obj/Taiyoken
					for(var/mob/Players/T in view(18))
						spawn()T.Quake(50)

					for(var/turf/T in Turf_Circle(src,18))
						if(prob(10)) sleep(0.1)
						x.layer=MOB_LAYER+1
						x.icon_state=pick("1","2","3","4","5","6","7")
						T.overlays+=x
						spawn(rand(1,2))T.overlays+=x
						spawn(rand(2,3))T.overlays+=x
						spawn(rand(3,4))T.overlays+=x
						spawn(rand(4,5))T.overlays-=x
						spawn(rand(5,6))T.overlays-=x
						spawn(rand(6,7))T.overlays-=x
						spawn(rand(7,8))T.overlays-=x
						spawn(rand(9,10))T.overlays-=x
						spawn(rand(40,80)) new/turf/Dirt(locate(T.x,T.y,T.z))
						if(prob(10))sleep(0.1)
						for(var/mob/M in view(0,T))
							if(M!=src)
								M.Health-=((usr.Force*usr.Power)/(M.Resistance*Power))*1000
								if(M.Health<=0)
									spawn M.Death(src)
					if(prob(99)) spawn src.Death(src)
				usr.Frozen=0
			if("HomingFinisher")
				var/Drain=5/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				var/list/people=list("Cancel")
				for(var/mob/M in oview(12,src))
					people.Add(M)
				var/mob/Choice=input("Home onto who?")in people
				if(Choice=="Cancel")return
				src.Attacking=1
				src.Beaming=1
				src.Chargez("Add")
				sleep(src.Refire/(Z.Speed*(sqrt(Z.Level)/10)))
				src.Chargez("Remove")
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
				src.Attacking=0
				src.Beaming=0
				var/blasts=0
				var/maxblasts=sqrt(Z.Level)*sqrt(Z.Level)
				src.SkillLeech(Z)
				while(blasts<maxblasts)
					Z.Skill_Increase()
					blasts++
					flick("Blast",src)
					var/obj/Projectiles/Mystical/A=new(locate(min(max(Choice.x+rand(-10,10),1),500),min(max(Choice.y+rand(-10,10),1),500),Choice.z))
					A.Distance=Distance
					A.Explosive=1
					A.Knockback=1
					A.dir=rand(1,8)
					A.icon=Z.sicon
					A.icon_state=Z.sicon_state
					A.Owner=src
					A.Damage_Multiplier=1
					A.Offense=src.Offense*src.Skill*45
					if(!(A in view(20,src)))
						spawn del(A)
						continue
					spawn(30) if(A) spawn()Homing(A,Choice)
					if(prob(50))sleep(0.1)
					else if(prob(20))sleep(1)
			if("Splitform")
				var/Drain=src.EnergyMax*(1/sqrt(Z.Level))
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				var/SplitAmount=0
				for(var/mob/Split/e in world)
					if(e.Owner==src.key)
						SplitAmount++
				if(SplitAmount>round(sqrt(Z.Level)))
					src<<"You cannot create anymore splitforms!"
					return
				SplitAmount++
				src.Energy-=Drain
				var/mob/Split/x=new
				x.icon=src.icon
				x.overlays=src.overlays
				x.underlays=x.underlays
				x.Power=src.Power
				x.Base=src.Base
				x.Strength=src.Strength/4
				x.Endurance=src.Endurance/2
				x.Speed=src.Speed/2
				x.SpeedMod=src.SpeedMod/1.5
				x.Offense=src.Offense/4
				x.Defense=src.Defense/2
				x.Force=src.Force/4
				x.Resistance=src.Resistance/2
				x.name="-[src.name]-([SplitAmount])"
				x.Owner=src.key
				x.loc=src.loc
				spawn()step(x,SOUTH)
				src.SkillLeech(Z)
				Z.Skill_Increase()
			if("Spirit Gun")
				var/Drain=500/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				src.Attacking=1
				src.Beaming=1
				src.Chargez("Add")
				sleep(src.Refire/(Z.Speed*(sqrt(Z.Level)/10)))
				src.Chargez("Remove")
				src.Energy-=Drain/src.Efficiency*100*(1/Z.Level)
				src.Attacking=0
				src.Beaming=0
				Z.Skill_Increase(2.5)
				flick("Blast",src)
				var/obj/Projectiles/Mystical/A=new(get_step(src,src.dir))
				A.Distance=Distance
				A.Explosive=1
				A.Knockback=1
				A.dir=src.dir
				A.icon=Z.sicon
				A.icon_state=Z.sicon_state
				A.Owner=src
				A.Damage_Multiplier=50
				A.Offense=src.Offense*src.Skill*45
				spawn if(A) walk(A,A.dir)
				src.SkillLeech(Z)
			if("ShunkanIdo")
				var/Drain=5/Z.Efficiency
				if(src.Attacking) return
				if(!src.CanBlast(Drain)) return
				var/list/people=list("Cancel")
				for(var/mob/Players/M in world)
					var/distance=abs(src.x-M.x)+abs(src.y-M.y)
					if(distance<=Z.Level*sqrt(Z.Level))
						if(M.z!=src.z&&Z.Level<99)
							continue
						people.Add(M)
				var/mob/Choice=input("Shunkan Ido to who?")in people
				if(Choice=="Cancel")return
				src.OMessage(5,"[src] begins to concentrate...","[src]([src.key]) used SI to [Choice]([Choice.key])!")
				src.SkillLeech(Z)
				sleep(1000/(sqrt(Z.Level)*sqrt(Z.Level)*sqrt(Z.Level)))
				if(Choice)
					src.loc=Choice.loc
					usr<<"You appear at [Choice]!"
					Z.Skill_Increase()
					src.SkillLeech(Z)
			if("DBSMake")
				for(var/A in typesof(/obj/Dragonballs))
					var/obj/C=new A(src.loc)
					if(C.type==/obj/Dragonballs)
						del(C)
						break
					for(var/obj/Dragonballs/W in world)
						if(C!=W)
							if(C.type==W.type)
								del(C)
							break
					if(C)
						C.icon_state="i[copytext(C.name,lentext(C.name))]"
				src.OMessage(10,"Materialized up a set of mysterious balls..","[ExtractInfo(src)] created the dragonballs!")
			if("DBSScatter")
				for(var/obj/Dragonballs/Q in src.loc)
					Q.icon_state="[copytext(Q.icon_state,2,3)]"
					sleep(10)
					Q.loc=locate(rand(1,5),rand(1,5),Q.z)
				src.OMessage(10,"Attempted to scatter the dragonballs beneath them....","[ExtractInfo(src)] scattered the dragonballs!")


mob/Split
	Bump(mob/A)
		if(istype(A,/mob))if(src.target!=A)return
		Melee()
	var/acting
	var/target
	Click()
		if(usr.key==src.Owner)
			var/blah=input(usr,"Command your split.","[src]") in list("Nevermind","Stop","Attack Nearest","Attack Target","Destroy","Follow")
			switch(blah)
				if("Nevermind")
					return
				if("Attack Nearest")
					spawn src.AttackNearest()
				if("Stop")
					src.acting=null
				if("Attack Target")
					var/list/e=list("Cancel")
					for(var/mob/q in oview(12,src))
						e.Add(q)
					var/mob/b=input(usr,"Attack who?","[src]") in e
					if(b!="Cancel")
						src.target=b
						src.AttackTarget()
				if("Destroy")
					src.acting=null
					del(src)
				if("Follow")
					spawn src.Follow()
	proc
		AttackTarget()
			set background=1
			src.acting="attacktarget"
			while(src.acting=="attacktarget")
				if(!src.target in world)
					src.acting=null
					break
				//if(Health<=0&&!KO) Unconscious(null,"?!?!")
				if(src.KO)break
				var/atom/O
				for(O in get_step(src,dir)) if(O.density&&!ismob(O)) break
				if(!src.Knockbacked)
					if(!O)
						step_towards(src,src.target)
				sleep((10/src.SpeedMod)/2)


		AttackNearest()
			set background=1
			src.acting="attacknearest"
			while(src.acting=="attacknearest")
				//if(Health<=0&&!KO) Unconscious(null,"?!?!")
				if(src.KO)
					src.acting=null
					break
				var/mob/Players/P
				for(P in oview(Sight_Range,src)) break
				var/atom/O
				for(O in get_step(src,dir)) if(O.density&&!ismob(O)) break
				if(!src.Knockbacked)
					if(P&&!O)
						src.target=P
						step_towards(src,P)
				sleep((10/src.SpeedMod)/2)
		Follow()
			set background=1
			src.target=null
			src.acting="follow"
			var/mob/x
			for(var/mob/Players/M in world)
				if(src.Owner==M.key)
					x=M
			if(!x)return
			while(src.acting=="follow")
				if(src.KO)break
				if(x)
					step_towards(src,x)
					sleep(10)
				else
					sleep(100)


proc/Homing(var/ori,var/pla)
	var/amount=50
	while(ori)
		amount--
		step_towards(ori,pla,4)
		sleep(1)
		if(amount<1)if(ori)del(ori)

mob/proc/Quake(var/duration=30)
	if(client) while(duration)
		duration-=1
		for(var/mob/M in view(src))
			if(M.client)
				M.client.pixel_x=rand(-8,8)
				M.client.pixel_y=rand(-8,8)
			if(!duration) if(M.client)
				M.client.pixel_x=0
				M.client.pixel_y=0
		sleep(1)