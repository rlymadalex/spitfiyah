obj/Money
	Level=0
	icon='Misc.dmi'
	icon_state="ZenniBag"
	Savable=1
	Stealable=1
	Click()
		if(src in usr)
			var/Amount=input("Drop how much money?") as num
			Amount=round(Amount)
			if(Amount>Level) Amount=Level
			if(Amount<1) return
			var/obj/Money/M=new(get_step(usr,usr.dir))
			M.Level=Amount
			M.name="[Commas(Amount)] Resources"
			Level-=Amount

obj
	Click()
		if(!(src in usr))
			if(istype(src.loc,/mob))
				var/mob/Q=src.loc
				if(Q.KO||istype(Q,/mob/Body))
					if(src.Stealable)
						if(istype(src,/obj/Money))
							for(var/obj/Money/X in usr)
								X.Level+=src.Level
							src.Level=0
							oview(10,usr)<<"[usr] stole [src] from [Q]"
						else
							if(src.suffix=="Equipped")
								src.Equip(Q)
								spawn(5) src.suffix=null
							src.loc=usr.contents
							oview(10,usr)<<"[usr] stole [src] from [Q]"
		..()



obj/proc/Equip(mob/A,var/show=1)
	if(suffix)
		suffix=null
		A.overlays-=icon
	else
		suffix="Equipped"
		if(show)
			A.overlays+=icon


obj/proc/ObjectUse() if(src in usr)
	if(istype(src,/obj/Items/Senzu)) src:Senzu_Eat()
	if(istype(src,/obj/Items/Wearables)) Equip(usr)
	if(istype(src,/obj/Items/Weights))
		var/numz=0
		var/weight=0
		for(var/obj/Items/Weights/M in usr.contents)
			if(M.suffix&&M!=src)
				numz++
				weight+=M.Level
		if(numz>2)
			usr<<"You cannot wear more than 3 weights."
			return
		var/lawl=weight+Level
		if(lawl>usr.WeightFormula(2))
			usr<<"Too heavy!"
			return
		usr<<"Max weight is [usr.WeightFormula(2)]."
		Equip(usr)
	if(istype(src,/obj/Items/Sword))
		for(var/obj/Items/Sword/S in usr) if(S.suffix&&S!=src)
			usr<<"You already have a weapon equipped"
			return
		Equip(usr)
	if(istype(src,/obj/Items/Tech/Scouter))
		for(var/obj/Items/Tech/Scouter/S in usr) if(S.suffix&&S!=src)
			usr<<"You already have a Scouter equipped"
			return
		Equip(usr)
	if(istype(src,/obj/Items/Tech/SpaceMask))
		for(var/obj/Items/Tech/SpaceMask/S in usr) if(S.suffix&&S!=src)
			usr<<"You already have a Space Mask equipped"
			return
		Equip(usr)
	if(istype(src,/obj/Items/Tech/EnhanceDigger))
		for(var/obj/Items/Tech/EnhanceDigger/S in usr) if(S.suffix&&S!=src)
			usr<<"You already have a dig enhancement equipped."
			return
		Equip(usr,0)
	if(istype(src,/obj/Items/Ammo)) usr.Reload(src)
	if(istype(src,/obj/Items/Gun)) src:Gun_Fire()

obj/Items
	Stealable=1
	Savable=1
	var/list/Creator=new
	proc/Drop()
		if(suffix=="Equipped") Equip(usr)
		loc=get_step(usr,usr.dir)
	Click()
		if(src in Technology_List)
			var/heh
			var/list/already=new
			if(Can_Afford_Technology(usr,src))
				if(istype(src,/obj/Items/Tech/SpaceTravel/Ship))
					for(var/obj/Items/Tech/SpaceTravel/Ship/W in world)
						already.Add(W.Password)
					for(var/i=1, i<12, i++)
						if(already.Find(i))
							continue
						else
							heh=i
							break
					if(!heh)
						usr<<"There are too many of them!"
						return
				for(var/obj/Money/M in usr)
					M.Level-=Technology_Price(usr,src)
					var/obj/Items/Q=new type(usr.loc)
					if(heh)Q.Password=heh
					Q.Creator.Add(usr.key,usr.client.address,usr.client.computer_id)
					//new type(usr.loc)
		else if(src in Clothes_List)
			if(usr.IconClicked==0)
				usr.IconClicked=1
				var/Color=input("Choose color") as color|null
				if(Color) icon+=Color
				usr.IconClicked=0
				var/obj/A=new type
				A.icon=icon
				usr.contents+=A

				icon=initial(icon)
		else
			spawn(5) ObjectUse()
	DblClick() if(src in usr) Drop()
	Wearables
		Icon_1 icon='Clothes1.dmi'
		Icon_2 icon='Clothes2.dmi'
		Icon_3 icon='Clothes3.dmi'
		Icon_4 icon='Clothes4.dmi'
		Icon_5 icon='Clothes5.dmi'
		Icon_6 icon='Clothes6.dmi'
		Icon_7 icon='Clothes7.dmi'
		Icon_8 icon='Clothes8.dmi'
		Icon_9 icon='Clothes9.dmi'
		Icon_10 icon='Clothes10.dmi'
		Icon_11 icon='Clothes11.dmi'
		Icon_12 icon='Clothes12.dmi'
		Icon_13 icon='Clothes13.dmi'
		Icon_14 icon='Clothes14.dmi'
		Icon_15 icon='Clothes15.dmi'
		Icon_16 icon='Clothes16.dmi'
		Icon_17 icon='Clothes17.dmi'
		Icon_18 icon='Clothes18.dmi'
		Icon_19 icon='Clothes19.dmi'
		Icon_20 icon='Clothes20.dmi'
		Icon_21 icon='Clothes21.dmi'
		Icon_22 icon='Clothes22.dmi'
		Icon_23 icon='Clothes23.dmi'
		Icon_24 icon='Clothes24.dmi'
		Icon_25 icon='Clothes25.dmi'
		Icon_26 icon='Clothes26.dmi'
		Icon_27 icon='Clothes27.dmi'
		Icon_28 icon='Clothes28.dmi'
		Icon_29 icon='Clothes29.dmi'
		Icon_30 icon='Clothes30.dmi'
		Icon_31 icon='Clothes31.dmi'
		Icon_32 icon='Clothes32.dmi'
		Icon_33 icon='Clothes33.dmi'
		Icon_34 icon='Clothes34.dmi'
		Icon_35 icon='Clothes35.dmi'
		Icon_36 icon='Clothes36.dmi'
		Icon_37 icon='Clothes37.dmi'
		Icon_38 icon='Clothes38.dmi'
		Icon_39 icon='Clothes39.dmi'
		Icon_40 icon='Clothes40.dmi'
		Icon_41 icon='Clothes41.dmi'
		Icon_42 icon='Clothes42.dmi'
		Icon_43 icon='Clothes43.dmi'
		Icon_44 icon='Clothes44.dmi'
		Icon_45 icon='Clothes45.dmi'
		Icon_46 icon='Clothes46.dmi'
		Icon_47 icon='Clothes47.dmi'
		Icon_48 icon='Clothes48.dmi'
		Icon_49 icon='Clothes49.dmi'
		Icon_50 icon='Clothes50.dmi'
		Icon_51 icon='Clothes51.dmi'
		Icon_52 icon='Clothes52.dmi'
		Icon_53 icon='Clothes52.dmi'
	Weights
		desc="Enhancements for training purposes."
	Senzu
		icon='Misc.dmi'
		icon_state="Senzu"
		desc="You can eat this and it will accelerate regeneration temporarily. You can also throw it to others. \
		You can use it on yourself, or you can use it on an unconscious person by stepping next to them and \
		facing them and using this. You can also split it, which will half its effect but give you two of them. \
		Each senzu is also a seed, so if you drop it on the ground, it will grow into a bigger senzu (Unless it \
		already is a big senzu)."
		Level=4
		New() spawn if(src) Senzu_Grow()
		proc/Senzu_Grow()
			if(Level>=4) return
			while(src)
				if(z)
					var/Old_Name=name
					Level*=2
					Senzu_Name()
					view(src)<<"The [Old_Name] grows into a [src]!"
				sleep(rand(2000,4000))
		proc/Senzu_Eat()
			for(var/mob/Players/P in get_step(usr,usr.dir)) if(P.KO)
				view(usr)<<"[usr] gives a [src] to [P]"
				P.Senzu_Heal(Level)
				del(src)
				break
			if(src)
				view(usr)<<"[usr] eats a [src]"
				usr.Senzu_Heal(Level)
				del(src)
		verb/Throw()
			var/list/Choices=new
			Choices+="Cancel"
			for(var/mob/Players/P in oview(10,usr)) Choices+=P
			var/mob/Choice=input("Throw to who?") in Choices
			if(Choice=="Cancel") return
			var/obj/S
			S.icon='Misc.dmi'
			S.icon_state="Senzu"
			view(usr)<<"[usr] throws a [src] to [Choice]"
			missile(S,usr,Choice)
			Choice.contents+=src
		verb/Split()
			if(Level>=2)
				var/obj/Items/Senzu/A=new(usr)
				var/obj/Items/Senzu/B=new(usr)
				A.Level=Level*0.5
				B.Level=Level*0.5
				A.Senzu_Name()
				B.Senzu_Name()
				del(src)
			else usr<<"You cannot split it any further."
		proc/Senzu_Name() name="Senzu ([Level]x)"
mob/proc/Senzu_Heal(Amount)
	var/Time=60
	while(Time)
		Time-=1
		var/Effect=Amount
		while(Effect)
			Effect-=1
			Recover("Health",1)
			Recover("Energy",1)
		sleep(10)


obj/Items/Ammo
	Level=3
	Cost=100
	desc="Click this to reload whichever gun you want."
	icon='Guns.dmi'
	icon_state="Ammo 1"
	Stealable=1
	var/Ammo=1000
	var/tmp/Reloading
	New() suffix="[Commas(Ammo)]"
obj/Items/Gun
	Cost=1000
	Level=3
	Handgun
		icon_state="Handgun"
		Ammo=100
		Max_Ammo=100
		Power=5
		Delay=5
		Velocity=1
		Precision=1000
		Knockbacks=0
		Explodes=0
		Spread=0
		Deviation=4
		Bullet_Icon='Bullet.dmi'
		verb/Handgun()
			Gun_Fire()
	Rifle
		icon_state="Rifle"
		Ammo=16
		Max_Ammo=16
		Power=20
		Delay=20
		Velocity=1
		Precision=1000
		Knockbacks=2
		Explodes=0
		Spread=0
		Deviation=4
		Bullet_Icon='Bullet.dmi'
		verb/Rifle()
			Gun_Fire()
	SMG
		icon_state="SMG"
		Ammo=500
		Max_Ammo=500
		Power=1
		Delay=1
		Velocity=1
		Precision=1000
		Knockbacks=0
		Explodes=0
		Spread=1
		Deviation=4
		Bullet_Icon='Bullet.dmi'
		verb/SMG()
			Gun_Fire()
	/*
	Default Ammo is 500, divided by the power of the gun.
	Each Knockback is x0.8 ammo
	Each explosion level is x0.8 ammo
	Damage is multiplied by the square root of the movement speed.
	(x2 movement = x1.42 damage)
	(x3 movement = 1.73x damage)
	(x4 movement = 2x damage)
	(x5 movement = 2.24x damage)
	(x10 movement = 3.17x damage)
	*/
	desc="Guns are a bit weak per shot, but they have a greater effect against non-players. Guns are very \
	accurate and rarely miss their target, and they drain no energy."
	icon='Guns.dmi'
	Power=1
	var/Ammo=500
	var/Max_Ammo=500
	var/Delay=5
	var/Velocity=1
	var/Precision=1000
	var/Knockbacks=0
	var/Explodes=0
	var/Spread=0
	var/Deviation=4
	var/Bullet_Icon='Bullet.dmi'
	var/tmp/Firing
	New()
		suffix="[Commas(Ammo)]"
		Gun_Description_Update()
	proc/Gun_Fire()
		if((usr.icon_state in list("Meditate","Train","KO","KB"))||usr.Frozen) return
		if(Firing) return
		if(Ammo<=0) return
		/*if(usr.key in Noobs)
			usr<<"Noobed people cannot use Guns"
			return*/
		Ammo-=1
		if(Spread) Ammo-=2
		if(Ammo<0) Ammo=0
		suffix="[Commas(Ammo)]"
		Firing=1
		spawn(Delay) Firing=0
		var/obj/Projectiles/Mystical/A=new
		A.Owner=usr
		A.Damage_Multiplier=Power
		A.Offense=Offense
		A.Knockback=Knockbacks
		A.Explosive=Explodes
		A.icon=Bullet_Icon
		A.pixel_x=rand(-Deviation,Deviation)
		A.pixel_y=rand(-Deviation,Deviation)
		A.loc=get_step(usr,turn(usr.dir,90))
		A.dir=usr.dir
		A.loc=usr.loc
		walk(A,A.dir,Velocity)
		if(Spread)
			spawn(2) if(src)
				var/obj/Projectiles/Mystical/B=new
				B.Owner=usr
				B.Damage_Multiplier=Power
				B.Offense=Offense
				B.Knockback=Knockbacks
				B.Explosive=Explodes
				B.icon=Bullet_Icon
				B.pixel_x=rand(-Deviation,Deviation)
				B.pixel_y=rand(-Deviation,Deviation)
				B.loc=get_step(usr,turn(usr.dir,90))
				B.dir=usr.dir
				walk(B,B.dir,Velocity)
			spawn(4) if(src)
				var/obj/Projectiles/Mystical/C=new
				C.Owner=usr
				C.Damage_Multiplier=Power
				C.Offense=Offense
				C.Knockback=Knockbacks
				C.Explosive=Explodes
				C.icon=Bullet_Icon
				C.pixel_x=rand(-Deviation,Deviation)
				C.pixel_y=rand(-Deviation,Deviation)
				C.loc=get_step(usr,turn(usr.dir,-90))
				C.dir=usr.dir
				walk(C,C.dir,Velocity)
	proc/Gun_Description_Update()
		desc="*[src]*<br>\
		Ammo Capacity: [Commas(Max_Ammo)]<br>\
		Refire Delay: [Delay]<br>\
		Shot Precision: [Commas(Precision*0.01)]<br>\
		Damage: [Power]<br>\
		Projectile Velocity: [Commas(1000/Velocity)]<br>\
		Knockback Effect: [Knockbacks+Explodes]<br>\
		Explosion Radius: [Explodes]<br>"
		if(Spread) desc+="Fires 3 shots at once.<br>"
mob/proc/Reload(obj/Items/Ammo/O)
	for(var/obj/Items/Ammo/A in usr) if(A.Reloading)
		src<<"You are busy reloading already."
		return
	var/list/Guns=new
	for(var/obj/Items/Gun/A in src) if(A.Ammo<A.Max_Ammo) Guns+=A
	if(!Guns) return
	//Guns+="Cancel"
	var/obj/Items/Gun/A=input(src,"Which gun do you want to reload?") in Guns
	if(A=="Cancel") return
	O.Reloading=1
	view(src)<<"[src] is reloading their weapon"
	spawn(50) if(O&&A&&src)
		O.Reloading=0
		view(src)<<"[src] is done reloading their weapon"
		var/Needed_Amount=A.Max_Ammo-A.Ammo
		if(Needed_Amount>O.Ammo) Needed_Amount=O.Ammo
		A.Ammo+=Needed_Amount
		O.Ammo-=Needed_Amount
		A.suffix="[Commas(A.Ammo)]"
		O.suffix="[Commas(O.Ammo)]"
		if(O.Ammo<=0) del(O)


obj/Items/Sword
	Level=7
	Cost=35000
	icon='TechSword.dmi'
	var/Points=35
	Damage_Multiplier=0.1
	var/Accuracy_Multiplier=0.1
	var/Delay_Multiplier=0.1
	var/Drain_Multiplier=0.1
	var/Explosive=0
	var/Homing=0
	desc="Swords alter the effects of melee combat and have their own advantages and disadvantages."
	New()
		..()
		spawn()src.Update_Description()
	proc/Update_Description()
		desc="[src]<br>\
		Damage Multiplier: [Damage_Multiplier]<br>\
		Accuracy Multiplier: [Accuracy_Multiplier]<br>\
		Delay Multiplier: [Delay_Multiplier]<br>\
		Drain Multiplier: [Drain_Multiplier]<br>\
		Explosive:[Explosive]<br>\
		Homing:[Homing]<br>"
	//Katana icon='Item - Katana 2.dmi'
	//Great_Sword icon='Item, Great Sword.dmi'
	verb/Customize_Sword()
		set src in usr
		winshow(usr,"SwordCustom",0)
		if(src in usr.contents)
			winshow(usr,"SwordCustom",1)
			usr.Customizing=src
			usr.UpdateSwordWindow(src)

mob/proc
	UpdateSwordWindow(var/obj/Items/Sword/I)
		if(I)
			if(istype(I,/obj/Items/Sword))
				winset(usr,"SwordPoints","text=[I.Points]")
				var/list/changes=list("LabelDamage","LabelAccuracy","LabelDelay","LabelDrain","LabelExplosive","LabelHoming")
				for(var/x in changes)
					var/blah
					switch(x)
						if("LabelDamage")blah="[I.Damage_Multiplier]"
						if("LabelAccuracy")blah="[I.Accuracy_Multiplier]"
						if("LabelDelay")blah="[I.Delay_Multiplier]"
						if("LabelDrain")blah="[I.Drain_Multiplier]"
						if("LabelExplosive")blah="[I.Explosive]"
						if("LabelHoming")blah="[I.Homing]"
					winset(usr,x,"text=[blah]")


mob/var/tmp/Customizing
mob/Players/verb/CustomizeSword(type as text)
	set name=".SwordCustom"
	set hidden=1
	var/obj/Items/Sword/Q=usr.Customizing
	if(Q)
		if(istype(Q,/obj/Items/Sword))
			if(Q.Points>0)
				if(type in list("Damage","Accuracy","Drain","Delay"))
					Q.vars["[type]_Multiplier"]+=0.1
					Q.Points--
				else
					if(Q.Points>=10)
						if(type in list("Explosive","Homing"))
							if(!Q.vars["[type]"])
								Q.vars["[type]"]=1
								Q.Points-=10
				UpdateSwordWindow(Q)
				Q.Update_Description()
				sleep(1)

