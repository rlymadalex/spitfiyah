mob/proc/Tail(Add_Tail=1)
	if(Add_Tail) Tail(0)
	var/image/T=image(icon='Tail.dmi',layer=layer+1)
	if(Hair_Color) T.icon+=Hair_Color
	else T.icon+=rgb(40,0,10)
	if(Add_Tail)
		Tail=1
		overlays+=T
	else
		Tail=0
		overlays-=T
		Oozaru(0)



mob/proc/Oozaru(Go_Oozaru=1,var/revert)
	for(var/obj/Oozaru/O in src)
		var/image/Head=image(icon='Oozaru, Head.dmi',pixel_y=32)
		var/image/Body=image(icon='Oozaru, Body.dmi')
		if(Hair_Color)
			Head.icon+=Hair_Color
			Body.icon+=Hair_Color
		if(Go_Oozaru)
			if(!src.Tail)return
			if(src.Dead)return
			if(src.ssj["Active"]>0)return
			Oozaru(0)
			O.icon=icon
			O.overlays=overlays
			icon=Body
			src.overlays-=src.overlays
			overlays+=Head
			Anger()
			Efficiency*=0.5
			Strength*=2
			StrengthMod*=2
			Endurance*=2
			EnduranceMod*=2
			Defense*=0.1
			DefenseMod*=0.1
			Speed*=0.5
			src.Power_Multiplier+=5
			if(revert)
				spawn(revert)Oozaru(0)
			else
				spawn(rand(3000,5000))Oozaru(0)
			spawn(rand(0,100)) for(var/mob/P in view(20,src)) P<<sound('Roar.wav')
		else if(O.icon)
			icon=O.icon
			overlays=O.overlays
			O.icon=null
			O.overlays=null
			Efficiency*=2
			Strength*=0.5
			StrengthMod*=0.5
			Endurance*=0.5
			EnduranceMod*=0.5
			Defense/=0.1
			DefenseMod/=0.1
			Speed*=2
			src.Power_Multiplier-=5
obj/Oozaru
	var/Looking=1
	var/list/Haha=new
	verb/Oozaru()
		set category="Other"
		Looking=!Looking
		if(Looking)
			usr<<"You will look at the moon"
			if(usr.Tail)
				usr.Tail(0)
				usr.Tail(1)
		else
			usr<<"You will not look at the moon"
			usr.Oozaru(0)
			if(usr.Tail)
				usr.Tail(0)
				usr.Tail=1

obj/Lycan
	var/Transed=0
	var/list/Haha=new

	var/tmp
		Delay
		HowlDelay

	Master
		verb/Bite()
			set category="Skills"
			if(usr.Dead)
				usr<<"You're dead!"
				return
			var/list/who=list("Cancel")
			for(var/mob/Players/M in oview(1,usr))
				if(!M.Dead)
					who.Add(M)
			var/mob/blah=input("Who do you want to bite?","Infect")in who
			if(blah=="Cancel")return
			if(blah)
				if(!blah.KO)
					var/buh=input(blah,"Do you want to let [usr] bite you?")in list("No","Yes")
					if(buh=="No")return
				usr.OMessage(13,"[usr] bites [blah]....","[usr]([usr.key]) bit and killed [usr]([usr.key])")
				if(locate(/obj/Skills/VampireAbsorb,blah.contents)||locate(/obj/Lycan,blah.contents))
					blah.Death(usr)
				else
					blah.contents+=new/obj/Lycan



	verb
		Shred()
			set category="Skills"
			if(!src.Transed)
				usr<<"You cannot use this in your normal form!"
				return
			if(src.Delay||usr.Attacking)return
			var/image/LOL=image('Effects.dmi',"Shred")
			src.Delay=1
			spawn(600)
				if(usr)
					src.Delay=0
					usr<<"Delay finished."
			usr.Melee(5,0.5,LOL)
		Howl()
			set category="Skills"
			if(!src.Transed)
				usr<<"You cannot use this in your normal form!"
				return
			if(src.Delay||usr.Attacking||src.HowlDelay)return
			src.HowlDelay=1
			spawn(1200)
				if(usr)
					src.HowlDelay=0
					usr<<"You can howl again!"
			var/icon/E=icon('Effects.dmi',"Howl")
			spawn()usr.Shockwave(E,0.5)
			for(var/mob/Players/M in oview(4,usr))
				if(!(locate(/obj/Lycan) in M.contents))
					M.Shocked++
					spawn(600)M.Shocked--
					view(10,M)<<"[M] is affected by [usr]'s howl!"


		Leap(var/mob/Z in oview(10))
			set category="Skills"
			if(src.Delay||usr.Attacking)return
			var/image/LOL=image('Effects.dmi',"Leap")
			src.Delay=1
			view(10,Z)<<"[usr] leaps to [Z]!"
			spawn(600)
				if(usr)
					src.Delay=0
					usr<<"Delay finished."
			usr.Melee(2,0.5,LOL,Z)



		Transform()
			set category="Skills"
			for(var/obj/Lycan/Q in usr)
				var/image/Lycan=image('Lycan.dmi',pixel_x=-20)
				if(!Q.Transed)
					if(usr.ssj["active"])
						if(usr.ssj["active"]>0)
							usr<<"You cannot turn into a beast while in a transformed stae."
							return
					if(usr.scl["active"])
						if(usr.scl["active"]>0)
							usr<<"You cannot turn into a beast while in a transformed stae."
							return
					for(var/obj/Oozaru/O in usr)
						if(O.icon)
							usr<<"You cannot transform while in oozaru!"
							return

					var/icon/E=icon('Effects.dmi',"Shock")

					spawn()for(var/turf/e in range(1,usr))
						if(prob(60))continue
						if(prob(75))
							e.overlays+=image('Weather.dmi',"Rising Rocks")
							spawn(rand(50,1000))e.overlays-=image('Weather.dmi',"Rising Rocks")
						if(prob(50))sleep(0.3)
					spawn()usr.Shockwave(E,1)
					spawn()Crater(usr)

					usr.PlusPower+=10000
					usr.Power_Multiplier+=2
					usr.Base*=1.15
					usr.BaseMod*=1.15
					usr.Recovery*=0.75
					usr.Regeneration*=1.25

					usr.Efficiency*=0.3
					usr.Strength*=1.7
					usr.StrengthMod*=1.7
					usr.Endurance*=1.3
					usr.EnduranceMod*=1.3
					usr.SpeedMod*=2
					usr.Speed*=2
					usr.ForceMod*=0.1
					usr.Force*=0.1
					usr.ResistanceMod*=3
					usr.Resistance*=3
					usr.Defense*=0.3
					usr.DefenseMod*=0.3

					Q.Transed=1

					Q.icon=usr.icon
					Q.overlays=usr.overlays
					usr.icon=null
					usr.overlays+=Lycan
					src.overlays-=src.overlays
					usr.Anger()

				else
					usr.PlusPower-=10000
					usr.Power_Multiplier-=2
					usr.Base/=1.15
					usr.BaseMod/=1.15
					usr.Recovery/=0.75

					usr.Efficiency/=0.3
					usr.Strength/=1.7
					usr.StrengthMod/=1.7
					usr.Endurance/=1.3
					usr.EnduranceMod/=1.3
					usr.SpeedMod/=2
					usr.Speed/=2
					usr.ForceMod/=0.1
					usr.Force/=0.1
					usr.ResistanceMod/=3
					usr.Resistance/=3
					usr.Defense/=0.3
					usr.DefenseMod/=0.3
					Q.Transed=0
					usr.icon=Q.icon
					usr.overlays-=usr.overlays
					spawn()usr.overlays=Q.overlays






obj/ProjectionMoon
	icon='Moon.dmi'
	New()
		spawn() src.Project()
	proc/Project()
		spawn(100)if(src)del(src)
		src.icon_state="Other On"
		step(src,NORTH,10)
		sleep(10)
		step(src,NORTH,10)
		sleep(10)
		step(src,NORTH,10)
		sleep(10)
		step(src,NORTH,10)
		sleep(10)
		src.icon_state="On"
		sleep(20)
		view(10,src)<<"<font color=red><small>The moon emits an odd glow.."
		if(src)
			for(var/mob/Players/P in view(10))
				if(src.Skill>1)
					P.Oozaru(1,src.Skill)
				else
					P.Oozaru(1)