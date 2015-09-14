mob/var/list/ssj=list(\
"1req"=1000000,"1mastery"=0,"1give"=12000000,"1multi"=1.25,
"2req"=200000000,"2mastery"=5,"2give"=60000000,"2multi"=2,
"3req"=550000000,"3mastery"=10,"3give"=0,"3multi"=1.65,
"active"=0,"unlocked"=0,"transing"=0)
mob/var/list/scl=list(\
"active"=0,"unlocked"=0,"transing"=0)



mob/proc/SetVars()
	if(src.Race=="Saiyan")
		if(src.Class=="Low-Class")
			src.ssj["1req"]=800000
			src.ssj["1give"]=10000000
			src.ssj["1multi"]=1.25

			src.ssj["2req"]=200000000
			src.ssj["2give"]=50000000
			src.ssj["2multi"]=2

			src.ssj["3req"]=440000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65

		else if(src.Class=="Elite")
			src.ssj["1req"]=1500000
			src.ssj["1give"]=12500000
			src.ssj["1multi"]=1.25

			src.ssj["2req"]=200000000
			src.ssj["2give"]=62500000
			src.ssj["2multi"]=2

			src.ssj["3req"]=550000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65
		else if(src.Class=="Legendary")
			src.ssj["1req"]=10000
			src.ssj["1give"]=12500000
			src.ssj["1multi"]=1.25

			src.ssj["2req"]=100000000
			src.ssj["2give"]=62500000
			src.ssj["2multi"]=3

			src.ssj["3req"]=550000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65

	else if(src.Race=="Half Saiyan")
		if(src.Class=="Gohan")
			src.ssj["1req"]=1000000
			src.ssj["1give"]=7000000
			src.ssj["1multi"]=1.25

			src.ssj["2req"]=200000000
			src.ssj["2give"]=30000000
			src.ssj["2multi"]=2

			src.ssj["3req"]=500000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65

		else if(src.Class=="Trunks")
			src.ssj["1req"]=1500000
			src.ssj["1give"]=15000000
			src.ssj["1multi"]=2

			src.ssj["2req"]=150000000
			src.ssj["2give"]=62500000
			src.ssj["2multi"]=1.25

			src.ssj["3req"]=600000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65

		else if(src.Class=="Hellspawn")
			src.ssj["1req"]=1500000
			src.ssj["1give"]=15000000
			src.ssj["1multi"]=3

			src.ssj["2req"]=150000000
			src.ssj["2give"]=62500000
			src.ssj["2multi"]=1.25

			src.ssj["3req"]=600000000
			src.ssj["3give"]=0
			src.ssj["3multi"]=1.65

	else if(src.Race=="Changling")
		if(src.Class=="Frieza")
			src.SCLForm_1='ChangelingFrieza.dmi'
			src.SCLForm_2='ChangelingFriezaForm2.dmi'
			src.SCLForm_3='ChangelingFriezaForm3.dmi'
			src.SCLForm_4='ChangelingFriezaForm4.dmi'
			src.SCLForm_6='ChangelingFriezaForm6.dmi'
			src.icon=src.SCLForm_1
			src.scl["1req"]=10000
			src.scl["1give"]=100000
			src.scl["1multi"]=1.15
			src.scl["2req"]=250000
			src.scl["2give"]=1000000
			src.scl["2multi"]=1.20
			src.scl["3req"]=10000000
			src.scl["3give"]=0
			src.scl["3multi"]=1.3
			src.scl["5req"]=80000000
			src.scl["5give"]=0
			src.scl["5multi"]=12
		else if(src.Class=="Cooler")
			src.SCLForm_1='Cooler1.dmi'
			SCLForm_2='Cooler2.dmi'
			SCLForm_3='Cooler3.dmi'
			SCLForm_4='Cooler4.dmi'
			SCLForm_5='Cooler5.dmi'
			src.icon=src.SCLForm_1
			src.scl["1req"]=2500
			src.scl["1give"]=10000
			src.scl["1multi"]=1.05
			src.scl["2req"]=25000
			src.scl["2give"]=100000
			src.scl["2multi"]=1.15
			src.scl["3req"]=500000
			src.scl["3give"]=2500000
			src.scl["3multi"]=1.25
			src.scl["4req"]=25000000
			src.scl["4give"]=0
			src.scl["4multi"]=1.5
		else if(src.Class=="King Kold")
			SCLForm_1='KingKold1.dmi'
			SCLForm_2='KingKold2.dmi'
			src.icon=src.SCLForm_1
			src.scl["1req"]=1000000
			src.scl["1give"]=20000000
			src.scl["1multi"]=2.5


mob/var/PlusPower=0


proc/DarknessFlash(var/mob/Z)
	set background=1
	for(var/area/L in view(0,Z))
		var/blah=L.icon_state
		if(blah!="Super Darkness")
			L.icon_state="Super Darkness"
			spawn(rand(600,3000))L.icon_state=blah


mob/proc/SCL(var/x)
	var/icon/E=icon('Effects.dmi',"Shock")
	E.Blend(rgb(rand(50,200),rand(50,200),rand(50,200)),ICON_ADD)
	var/mastery=scl["[x]mastery"]
	if(mastery<1)
		spawn()for(var/turf/e in range(20,src))
			if(prob(60))continue
			if(prob(50))
				e.overlays+=image('Weather.dmi',"Rising Rocks")
				spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
			//if(prob(5))spawn()new/obj/Effects/Lightning(e)
			if(prob(50))sleep(0.3)
		sleep()
		spawn()Shockwave(E,1)
		Quake(10)
		spawn()Shockwave(E,1)
		Quake(20)
		spawn()Shockwave(E,1.5)
		spawn()Shockwave(E,1.5)
		spawn()Crater(src)
		scl["[x]mastery"]=1
	src.PlusPower+=scl["[x]give"]
	src.Base*=scl["[x]multi"]
	src.BaseMod*=scl["[x]multi"]
	src.Recovery*=0.70
	scl["active"]=x
	if(x==1&&src.SCLForm_2)src.icon=src.SCLForm_2
	if(x==2&&src.SCLForm_3)src.icon=src.SCLForm_3
	if(x==3&&src.SCLForm_4)src.icon=src.SCLForm_4
	if(x==4&&src.SCLForm_5)src.icon=src.SCLForm_5
	if(x==5&&src.SCLForm_6)src.icon=src.SCLForm_6



mob/proc/SSj(var/x)
	for(var/obj/Oozaru/O in src)
		if(O.icon)
			src<<"You cannot transform while in oozaru!"
			return
	for(var/obj/Lycan/O in src)
		if(O.icon)
			src<<"You cannot transform while in Lycan!"
			return

	var/icon/E=icon('Effects.dmi',"Shock")//'Effect.dmi')


	if(x==1)
		E.Blend(rgb(50,50,-10),ICON_ADD)
	if(x==2)
		E.Blend(rgb(-10,-10,50),ICON_ADD)
	if(x==3)
		E.Blend(rgb(-10,50,40),ICON_ADD)

	var/mastery=ssj["[x]mastery"]
	if(x==1)
		if(src.BaseMod<50)
			src.BaseMod*=50
		if(mastery==100)
			..()
		else if(mastery>80)
			spawn()for(var/turf/e in range(2,src))
				if(prob(60))continue
				if(prob(75))
					e.overlays+=image('Weather.dmi',"Rising Rocks")
					spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
				if(prob(50))sleep(0.3)
			sleep()
			spawn()Shockwave(E,1)
			spawn()Crater(src)

		else if(mastery>50)
			spawn()for(var/turf/e in range(5,src))
				if(prob(60))continue
				if(prob(40))
					e.overlays+=image('Weather.dmi',"Rising Rocks")
					spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
				if(prob(50))sleep(0.3)
			sleep()
			spawn()Shockwave(E,1)
			Quake(10)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			spawn()Crater(src)
		else if(mastery>20)
			spawn()for(var/turf/e in range(8,src))
				if(prob(60))continue
				if(prob(30))
					e.overlays+=image('Weather.dmi',"Rising Rocks")
					spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
				if(prob(50))sleep(0.3)
			sleep()
			spawn()Shockwave(E,1)
			Quake(10)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			Quake(20)
			spawn()Crater(src)

		else if(mastery>=1)
			spawn()for(var/turf/e in range(13,src))
				if(prob(60))continue
				if(prob(30))
					e.overlays+=image('Weather.dmi',"Rising Rocks")
					spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
				if(prob(50))sleep(0.3)
			sleep()
			spawn()Shockwave(E,1)
			Quake(10)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			Quake(20)
			spawn()Shockwave(E,1.5)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			Quake(30)
			spawn()Crater(src)


		else
			spawn()for(var/i=200, i>0, i--)
				new/obj/Effects/Lightning(locate(rand(1,500),rand(1,500),src.z))
				if(prob(50))sleep(1)
			spawn()DarknessFlash(src)
			spawn()for(var/turf/e in range(20,src))
				if(prob(60))continue
				if(prob(50))
					e.overlays+=image('Weather.dmi',"Rising Rocks")
					spawn(rand(100,5000))e.overlays-=image('Weather.dmi',"Rising Rocks")
				if(prob(5))spawn()new/obj/Effects/Lightning(e)
				if(prob(50))sleep(0.3)
			sleep()
			spawn()Shockwave(E,1)
			spawn()LightningFlash(src)
			Quake(10)
			sleep(20)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			Quake(20)
			sleep(30)
			spawn()Shockwave(E,1.5)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			Quake(30)
			sleep(10)
			spawn()LightningFlash(src)
			spawn()Shockwave(E,2)
			spawn()Shockwave(E,1.5)
			spawn()Shockwave(E,1.2)
			spawn()Shockwave(E,1)
			spawn()Crater(src)
			Quake(80)
			spawn()LightningFlash(src)
			ssj["[x]mastery"]=1
	//if(x==1)
	if(x==2)
		src.overlays-=image('Auras.dmi',"SSJ2")
		src.overlays+=image('Auras.dmi',"SSJ2")
	//if(x==3)
	src.PlusPower+=ssj["[x]give"]
	src.Base*=ssj["[x]multi"]
	src.BaseMod*=ssj["[x]multi"]
	src.Recovery*=0.75
	ssj["active"]=x
	src.Hairz("Add")
	src.Auraz("Add")



mob/proc/Transform()
	if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
		if(ssj["transing"]==1)return
		if(ssj["active"]==0||ssj["active"]==null)
			if(ssj["unlocked"]>0)
				if(ssj["1req"]<=src.Power)
					ssj["transing"]=1
					src.SSj(1)
					ssj["transing"]=0
		else if(ssj["active"]==1)
			if(ssj["1mastery"]<99)return
			if(ssj["unlocked"]>1)
				if(ssj["2req"]<=src.Power)
					ssj["transing"]=1
					src.SSj(2)
					ssj["transing"]=0
		else if(ssj["active"]==2)
			if(ssj["2mastery"]<99)return
			if(ssj["unlocked"]>2)
				if(ssj["3req"]<=src.Power)
					ssj["transing"]=1
					src.SSj(3)
					ssj["transing"]=0
	if(src.Race=="Changling")
		if(scl["transing"]==1)return
		if(scl["active"]==0||scl["active"]==null)
			if(scl["unlocked"]>0)
				if(!(scl["1req"]))return
				if(scl["1req"]<=src.Power)
					scl["transing"]=1
					src.SCL(1)
					scl["transing"]=0
		else if(scl["active"]==1)
			if(scl["unlocked"]>1)
				if(scl["1mastery"]<99)return
				if(!(scl["2req"]))return
				if(scl["2req"]<=src.Power)
					scl["transing"]=1
					src.SCL(2)
					scl["transing"]=0
		else if(scl["active"]==2)
			if(scl["unlocked"]>2)
				if(!(scl["3req"]))return
				if(scl["2mastery"]<99)return
				if(scl["3req"]<=src.Power)
					scl["transing"]=1
					src.SCL(3)
					scl["transing"]=0
		else if(scl["active"]==3)
			if(Class=="Cooler")
				if(scl["unlocked"]>3)
					if(!(scl["4req"]))return
					if(scl["3mastery"]<99)return
					if(scl["4req"]<=src.Power)
						scl["transing"]=1
						src.SCL(4)
						scl["transing"]=0
			else if(scl["unlocked"]>3)
				if(!(scl["5req"]))return
				if(scl["3mastery"]<99)return
				if(scl["5req"]<src.Power)
					scl["transing"]=1
					src.SCL(5)
					scl["transing"]=0

mob/proc/Revert()
	if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
		if(ssj["active"]==0||ssj["active"]==null)return
		src.overlays-=image('Auras.dmi',"SSJ2")
		while(ssj["active"]>0)
			src.PlusPower-=ssj["[ssj["active"]]give"]
			src.Base/=ssj["[ssj["active"]]multi"]
			src.BaseMod/=ssj["[ssj["active"]]multi"]
			src.Recovery/=0.75
			ssj["active"]--
		src.Hairz("Add")
	if(src.Race=="Changling")
		if(scl["active"]==0||scl["active"]==null)return
		src.overlays-=image('Auras.dmi',"SCL")
		while(scl["active"]>0)
			src.PlusPower-=scl["[scl["active"]]give"]
			src.Base/=scl["[scl["active"]]multi"]
			src.BaseMod/=scl["[scl["active"]]multi"]
			src.Recovery/=0.70
			scl["active"]--
		if(src.SCLForm_1)src.icon=src.SCLForm_1







mob/proc/Shockwave(var/icon/E,var/Q=1)
	set background=1
	//b.Scale(96,96)
	var/y1=0
	var/x1=0
	//if(E.Width()>32)
	//	y1=(E.Width()-32)/64
	//if(E.Height()>32)
	//	x1=(E.Height()-32)/64
	spawn()new/shockwave(\
	locate(src.x-x1,src.y-y1,src.z),
	E,
	Ticks=10*sqrt(Q),
	Speed=20*Q,
	Amount=20*Q,
	StopAtObj=1,
	Source=src)