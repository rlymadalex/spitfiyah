obj/var/Cost
var/list/Technology_List=new
proc/Add_Technology()
	for(var/A in typesof(/obj/Items/Tech))
		//if(!(A in list(/obj/Items/Gun)))
		var/obj/B=new A
		B.suffix=null
		if(B.Cost) Technology_List+=B
		else del(B)
	for(var/C in typesof(/obj/Items/Gun))
		var/obj/D=new C
		D.suffix=null
		if(D.Cost&&D.type!=/obj/Items/Gun) Technology_List+=D
		else del(D)
	for(var/C in typesof(/obj/Items/Sword))
		var/obj/D=new C
		D.suffix=null
		if(D.Cost) Technology_List+=D
		else del(D)

proc/Can_Afford_Technology(mob/P,obj/O) for(var/obj/Money/M in P) if(O.Cost/P.Intelligence<=M.Level) return 1
proc/Technology_Price(mob/P,obj/O) return O.Cost/P.Intelligence

obj/Planet_Money
	Level=0
	Grabbable=0
	Health=1.#INF
proc/Add_Planet_Money()
	for(var/area/Outside/Planet/P)
		if(P.Drillable)
			P.Level+=250000*P.Rate

mob/var/CyberPower=0
obj/Cyberize
	verb
		Cyberize(var/mob/M in view(1))
			set src in usr
			set category="Skills"
			if(Year<30)
				usr<<"You cannot use this until Year 30!"
				return
			if(usr.Dead)
				usr<<"You are dead!"
				return
			if(M.client)
				var/amount=usr.IntelligenceLevel*usr.IntelligenceLevel*10000
				var/blah=input("Cyberize [M] to how much BP? (Each BP is [40/usr.Intelligence] resources.)","[Commas(amount)] Max")as num
				if(M.CyberPower>=blah)
					usr<<"They are stronger than that already!"
					return
				else
					for(var/obj/Money/Q in usr)
						if(Q.Level>=(blah-M.CyberPower)*40/usr.Intelligence)
							Q.Level-=(blah-M.CyberPower)*40/usr.Intelligence
							M.CyberPower=amount
							oview(10,usr)<<"[M] has been cybered by [usr]!"

						else
							usr<<"You do not have enough resources!"
							return
						break



obj/Items/Tech/verb
	Bolt()
		set src in oview(1)
		set category=null
		if(!src.Grabbable)
			usr<<"You cannot unbolt this."
			return
		if(src.Bolt)
			if(usr.IntelligenceLevel>=src.Bolt)
				src.Bolt=0
				view(10,usr)<<"[usr] unbolted [src]"
			else
				usr<<"This is too advanced for you to mess with!"
		else
			src.Bolt=usr.IntelligenceLevel
			view(10,usr)<<"[usr] bolted [src]"

	Upgrade()
		set src in oview(1)
		set category=null
		if(!(usr.client.mob in range(1,src))) return
		if(istype(src,/obj/Items/Tech/PunchingBag)||istype(src,/obj/Items/Tech/Log))
			var/Amount=input("Reinforce the [src] by how much?","Upgrade") as num
			if(Amount>0)
				for(var/obj/Money/M in usr)
					if(M.Level>=Amount)
						src.icon_state=""
						M.Level-=Amount
						src.Health+=Amount*usr.Intelligence
						usr<<"[Amount*usr.Intelligence] added to [src]"
		if(istype(src,/obj/Items/Tech/Drill)||istype(src,/obj/Items/Tech/CloakControls)||istype(src,/obj/Items/Tech/Regenerator)||istype(src,/obj/Items/Tech/Turret)||istype(src,/obj/Items/Tech/Gravity)||istype(src,/obj/Items/Tech/Scouter)||istype(src,/obj/Items/Tech/SpaceTravel/SpacePod)||istype(src,/obj/Items/Tech/SpaceTravel/Ship))
			var/Price
			if(UpgradePrice)
				Price=src.UpgradePrice/usr.Intelligence
			else
				Price=src.Cost/usr.Intelligence
			var/Amount=input("Reinforce the [src] by how much?([Price] per upgrade)","([usr.IntelligenceLevel] max)") as num
			Amount=min(Amount,usr.IntelligenceLevel)
			if(Amount<=src.Lvl)
				return
			Price*=(Amount-src.Lvl)
			for(var/obj/Money/M in usr)
				if(M.Level>=Price)
					M.Level-=Price
					src.Lvl=Amount
					src.desc="[src] (Level [Amount])"
					usr<<"[usr] upgraded [src] to level [Amount]."

		if(istype(src,/obj/Items/Tech/TeleportWatch)||istype(src,/obj/Items/Tech/TeleportPad))
			if(src:Uni!=1)
				var/Price=UpgradePrice/usr.Intelligence
				for(var/obj/Money/M in usr)
					if(M.Level>=Price)
						M.Level-=Price
						src:Uni=1
						usr<<"[usr] upgraded [src] to Universal standards."

proc/ReturnDirection(var/mob/buh,var/mob/M)
	if(M.x > buh.x)
		if(M.y>buh.y)
			return NORTHEAST
		if(M.y<buh.y)
			return SOUTHEAST
		if(M.y==buh.y)
			return EAST
	if(M.x < buh.x)
		if(M.y>buh.y)
			return NORTHWEST
		if(M.y<buh.y)
			return SOUTHWEST
		if(M.y==buh.y)
			return WEST
	if(M.x == buh.x)
		if(M.y>buh.y)
			return NORTH
		if(M.y<buh.y)
			return SOUTH
obj/var/CloakPasscode

obj/Items
	var/Pickable=1

proc/GetPlanetGravity(var/q)
	switch(q)
		if(1)//Earth
			return 1
		if(2)//Namek
			return 2
		if(3)//Vegeta
			return 5
		if(11)//Vegeta Cave
			return 5
		if(4)//Ice
			return 10
		if(5)//Arconia
			return 3
		if(6)//Heaven
			return 1
		if(7)//Hell
			return 10
		if(8)//Afterlife
			return 1
		if(14)//Alien Planets
			return 1
	return 1

obj/ShipConsole
	var/Launching
	Health=1.#INF
	Grabbable=0
	icon='Tech.dmi'
	icon_state="ShipConsole"
	var/YearReq
	verb/Leave()
		set src in oview(1)
		if(YearReq)
			if(YearReq>Year)
				usr<<"You cannot use this at this year!"
				return
		for(var/obj/Items/Tech/SpaceTravel/Ship/Q in world)
			if(Q.z)
				if(Q.Password==src.Password)
					view(10,usr)<<"[usr] leaves the ship."
					usr.loc=Q.loc
					return
		AdminMessage("[usr]([usr.key]) is trapped on a ship that blew up!(Sent to spawn)")
		usr.SendToSpawn()
	verb/Launch()
		set src in oview(1)
		if(usr.z==12)return
		for(var/obj/Items/Tech/SpaceTravel/Ship/Q in world)
			if(Q.z)
				if(Q.z==1||Q.z==2||Q.z==3||Q.z==4||Q.z==5)
					if(Q.Password==src.Password)
						if(src.Launching)return
						src.Launching=1
						usr<<"You will launch in 60 seconds!"
						sleep(600)
						src.Launching=0

						if(src.z==14)
							var/placement=0
							for(var/i=src.x, i>100, i-=100)
								placement++
							for(var/q=src.y, q>100, q-=100)
								placement+=5
							for(var/obj/Planets/Alien/x in world)
								if(x.Zz==placement)
									Q.loc=x.loc
									return


						else
							for(var/obj/Planets/x in world)
								if(!istype(x,/obj/Planets/Alien))
									if(x.Zz==Q.z)
										Q.loc=x.loc
										return
						Q.loc=locate(250,250,12)
	verb/Use()
		set src in oview(1)
		if(YearReq)
			if(YearReq>Year)
				usr<<"You cannot use this at this year!"
				return
		for(var/obj/Items/Tech/SpaceTravel/Ship/Q in world)
			if(Q.z)
				if(Q.Password==src.Password)
					if(!Q.who)
						usr.Control=Q
						usr.client.eye=Q
						Q.who=usr
					else
						usr<<"Someone else is driving!"
	verb/View()
		set src in oview(1)
		for(var/obj/Items/Tech/SpaceTravel/Ship/Q in world)
			if(Q.z)
				if(Q.Password==src.Password)
					usr.client.eye=Q

obj/Items/Tech
	var/Lvl=1
	var/UpgradePrice
	var/Bolt
	Drill
		Pickable=0
		Level=10
		Cost=10000
		New()
			var/image/A=image(icon='Space.dmi',icon_state="1",pixel_y=16,pixel_x=-16)
			var/image/Z=image(icon='Space.dmi',icon_state="2",pixel_y=16,pixel_x=16)
			var/image/C=image(icon='Space.dmi',icon_state="3",pixel_y=-16,pixel_x=-16)
			var/image/D=image(icon='Space.dmi',icon_state="4",pixel_y=-16,pixel_x=16)
			overlays.Remove(A,Z,C,D)
			overlays.Add(A,Z,C,D)
			spawn if(src) Drill()
		proc/Drill() while(src)
			set background=1
			for(var/area/Outside/Planet/P) if(P.z==z&&P.Drillable==1)
				if(P.Level>0)
					Level+=10*Lvl
					P.Level-=10*Lvl
					if(P.Level<0)
						Level+=P.Level
						P.Level=0
			sleep(rand(300,500))
		Click()
			..()
			if(!(usr.client.mob in range(1,src))) return
			view(src)<<"[usr] withdraws [Commas(Level)] Resources from the [src]"
			for(var/obj/Money/M in usr)
				M.Level+=Level
				Level=0

	PunchingBag
		Pickable=0
		Level=3
		Health=10000
		icon='PunchingBag.dmi'
		Cost=10000
		density=1
	Log
		Pickable=0
		Level=4
		Health=10000
		icon='Dummy.dmi'
		Cost=10000
		density=1
	Regenerator
		Level=12
		icon='Lab.dmi'
		icon_state="Tube 1"
		density=1
		Cost=1000000
		UpgradePrice=250000
		New()
			var/image/A=image(icon='Lab.dmi',icon_state="Tube 2",layer=5,pixel_y=32)
			overlays-=A
			overlays+=A
			spawn() if(src) Regenerator()
		proc/Regenerator()
			set background=1
			while(src)
				for(var/mob/A in get_step(src,NORTH))
					A.Recover("Health",sqrt(Lvl))
					A.Recover("Energy",sqrt(Lvl))
				sleep(10)
	Scouter
		Level=25
		icon='Scouter.dmi'
		Cost=100000
		UpgradePrice=25000
		var/Frequency=1
		verb/ScouterSpeak(Z as text)
			set src in usr
			for(var/mob/Players/M in world)
				for(var/obj/Items/Tech/Scouter/Q in M)
					if(Q.Frequency==src.Frequency)
						M<<"<font color=green><b>(Scouter)</b> [usr.name]: [html_encode(Z)]"
		verb/ScouterFrequency()
			set src in usr
			Frequency=input(usr,"Change your Scouter frequency to what?","Frequency",Frequency)as num

	SpaceMask
		Level=22
		Cost=25000
		icon='AirMask.dmi'

	EnhanceDigger
		icon='Tech.dmi'
		var/DigMulti=1
		Shovel
			icon_state="Shovel"
			Level=5
			Cost=100000
			DigMulti=10
		HandDrill
			icon_state="HandDrill"
			Level=8
			Cost=250000
			DigMulti=25
	DoorPass
		Level=6
		Cost=1000
		icon='Tech.dmi'
		icon_state="DoorPass"
		Click()
			..()
			if(!(usr.client.mob in view(1,src))) return
			if(!Password)
				Password=input("What passcode?")as text
			else usr<<"Already programmed!"
	PDA
		Level=7
		Cost=40000
		var/htmlq={"<html><head><title>PDA Title!</title></head><body><body bgcolor=black text=white><h1>Heading!</h1><p>Paragraph!</body></html>"}
		icon='Tech.dmi'
		icon_state="PDA"
		verb/EditPDA()
			set src in usr
			htmlq=input(usr,"Edit!","Edit Notes",htmlq) as message
		verb/View()
			set src in view(1)
			usr<<browse(htmlq,"window=PDA;size=400x400")
	Turret
		Level=23
		Cost=500000
		UpgradePrice=25000
		icon='Tech.dmi'
		icon_state="TurretBase"
		density=1
		Grabbable=0
		Pickable=0
		var/On=0
		New()
			if(src)spawn() Guard()
		Click()
			..()
			if(!(usr.client.mob in range(1,src))) return
			if(src.Creator.Find(usr.key))
				if(src.On)
					src.icon_state="TurretBase"
					src.On=0
				else
					if(!Password)
						usr<<"Set a passcode before setting the turret on!"
						return
					src.icon_state="Turret"
					src.On=1
			else
				usr<<"Only the creator can turn this on or off!"
		proc/Fire(var/mob/M)
			var/obj/Projectiles/Mystical/A=new
			A.Owner=src
			A.Damage_Multiplier=100*Lvl*Lvl*Lvl
			//A.Offense=Lvl*Lvl*100*Lvl*Lvl*Lvl
			A.icon='Bullet.dmi'
			A.pixel_x=rand(-16,16)
			A.pixel_y=rand(-16,16)
			A.dir=src.dir
			A.loc=get_step(src,turn(src.dir,90))
			//A.loc=src.loc
			spawn(0.5)if(A)step_towards(A,M)
			spawn(0.6)if(A)walk(A,A.dir)
			spawn(0.7)if(A)step_towards(A,M)
			spawn(0.8)if(A)walk(A,A.dir)
			if(A)walk(A,A.dir)
		proc/Guard()
			set background=1
			while(src)
				if(On)
					src.Offense=Lvl*Lvl*100*Lvl*Lvl
					var/yes
					for(var/mob/P in oview(10,src))
						for(var/obj/Items/Tech/DoorPass/Q in P)
							if(P.Password!=Q.Password)
								continue
							else
								yes=1
								break
						if(yes)
							continue
						src.dir=ReturnDirection(src,P)
						spawn()flick("TurretFiring",src)
						spawn()Fire(P)
						sleep(rand(10,20))
						continue
					if(!yes)sleep(rand(50,70))
				else
					sleep(rand(80,100))



		verb/SetPassword()
			set src in oview(1)
			if(Password)
				usr<<"Password already set!"
				return
			else
				Password=input("Set a password.")as text

	Cloak
		icon='Tech.dmi'
		icon_state="Cloak"
		Level=70
		Cost=10000000
		verb/SetPasscode()
			set src in usr
			if(Password)
				usr<<"Password already set!"
				return
			else
				Password=input("Set a password.")as text
		verb/Use()
			set src in usr
			if(!Password)
				usr<<"Set a passcode first!"
				return
			for(var/obj/P in get_step(usr,usr.dir))
				P.CloakPasscode=src.Password
				oview(10)<<"[usr] installed the [src] onto the [P]."
				del(src)
				break

	CloakControls
		icon='Tech.dmi'
		icon_state="CloakControls"
		Level=70
		Cost=100000000
		UpgradePrice=10000000
		verb/CloakSelf()
			set src in usr
			if(usr.invisibility)
				usr.invisibility=0
				usr.see_invisible=0
				usr<<"You render yourself visible!"
			else
				usr.invisibility=max(min(round(Lvl/2),99),1)
				usr.see_invisible=max(min(round(Lvl/2),99),1)
				usr<<"You render yourself into [max(min(round(Lvl/2),99),1)] level(s) of invisibility."
		verb/SetPasscode()
			set src in usr
			Password=input("Set a password.")as text
		verb/CloakObjects()
			set src in usr
			for(var/obj/Q in world)
				if(Q.CloakPasscode)
					if(Q.CloakPasscode==Password)
						Q.invisibility=min(round(Lvl/2),99)
						usr<<"[Q] cloaked!"

		verb/UnCloakObjects()
			set src in usr
			for(var/obj/Q in world)
				if(Q.CloakPasscode)
					if(Q.CloakPasscode==Password)
						Q.invisibility=0
						usr<<"[Q] un-cloaked!"
		verb/Uninstall()
			set src in usr
			for(var/obj/P in get_step(src,dir))
				if(P.CloakPasscode)
					P.invisibility=0
					var/obj/Items/Tech/e=new /obj/Items/Tech/Cloak(usr.contents)
					e.Password=P.CloakPasscode
					P.CloakPasscode=null
					oview(10)<<"[usr] uninstalled the [src] from the [P]."


	Gravity
		Del()
			src.Off()
			..()
		icon='Tech.dmi'
		icon_state="Gravity"
		Level=40
		Cost=25000000
		UpgradePrice=5000000
		proc/On(var/e)
			if(e>GetPlanetGravity(src.z))
				for(var/turf/z in Turf_Circle(src,sqrt(Lvl)))
					z.overlays-=image('Tech.dmi',"GravityField")
					z.overlays+=image('Tech.dmi',"GravityField")
					z.Gravity=e
		proc/Off()
			for(var/turf/e in Turf_Circle(src,sqrt(Lvl)))
				e.overlays-=image('Tech.dmi',"GravityField")
				e.overlays-=image('Tech.dmi',"GravityField")
				e.Gravity=null
		Click()
			..()
			if(!(usr.client.mob in oview(1,src))) return
			var/eh=input("Adjust gravity to what level?","[(Lvl*2)+10] max")as num
			if(eh<=0)
				src.Off()
				view(10,usr)<<"[usr] turns off the machine."
			else
				src.On(min(eh,(Lvl*2)+10))
				view(10,usr)<<"[usr] turns on the machine to ([min(eh,(Lvl*2)+10)])"


	Moon
		Level=33
		Cost=100000
		icon='Moon.dmi'
		verb/Use()
			set src in oview(1)
			var/obj/ProjectionMoon/Q=new(src.loc)
			Q.Skill=15000/4
			del(src)


	TeleportPad
		var/Uni
		icon='Tech.dmi'
		icon_state="TeleportPad"
		Level=50
		Cost=2000000
		UpgradePrice=20000000
		verb/SetPasscode()
			set src in oview(1)
			if(Password)
				usr<<"This is already programmed!"
				return
			else
				Password=input("Input a passcode for this specific pad.")as text
		verb/Use()
			set src in oview(1)
			var/list/blah=list("Nevermind")
			for(var/obj/Items/Tech/TeleportPad/E in world)
				if(E.Password==src.Password)
					if(E.z!=src.z&&!src.Uni)continue
					blah.Add(E)
			var/obj/e=input("")in blah
			usr.loc=e.loc

	TeleportWatch
		var/Uni
		icon='Tech.dmi'
		icon_state="TeleportWatch"
		Level=50
		Cost=50000000
		UpgradePrice=20000000
		verb/SetPasscode()
			set src in usr
			Password=input("Input a password for this watch to link up with other teleporter pads")as text
		verb/Use()
			set src in usr
			var/list/blah=list("Nevermind")
			for(var/obj/Items/Tech/TeleportPad/E in world)
				if(E.Password==src.Password)
					if(E.z!=src.z&&!src.Uni)continue
					blah.Add(E)
			var/obj/e=input("")in blah
			usr.loc=e.loc

	SpacePodRemote
		icon='Tech.dmi'
		icon_state="SPR"
		Level=40
		Cost=10000000
		var/LastTime
		verb/SetPassword()
			set src in usr
			Password=input("Set a password.")as text

		verb/ProgramPod()
			set src in usr
			for(var/obj/Items/Tech/SpaceTravel/SpacePod/P in get_step(usr,usr.dir))
				if(!P.Password)
					P.Password=input(usr,"What passcode?")as text
					view(10)<<"[usr] programmed the spacepod."
				else
					usr<<"This pod is already programmed!"
		verb/Use()
			set src in usr
			if(src.LastTime)
				if(src.LastTime>world.realtime+300)
					usr<<"You must wait 30 seconds before using this again!"
					return
			if(!src.Password)
				usr<<"You have to set a passcode first!"
				return
			src.LastTime=world.realtime
			for(var/obj/Items/Tech/SpaceTravel/SpacePod/Q in world)
				if(Q.Password==src.Password)
					if(Q.Remoting)
						usr<<"[Q] is already being called!"
						continue
					if(Q.z!=usr.z)
						usr<<"...[Q] is not on this planet."
						break
					if(Q.x==usr.x)
						if(Q.y==usr.y-1)
							usr<<"[Q] is already here!"
							break
					usr<<"Attemping to call: [Q]....this will only work if there is open space between you and the pod."
					Q.Remoting=1

					var/turf/destination = locate(usr.x,usr.y-1,usr.z)
					if(destination)
						Q.move_to(destination, 3)
					else
						usr<<"Your signal has failed! Go outside or somewhere where your pod can reach you!"
				Q.Remoting = null



	SpaceTravel
		Bump(mob/A)
			..()
			PlanetEnterBump(A,src)


		var/Navigation=0
		var/Launching=0
		var/mob/who
		//var/Speed=0
		Del()
			if(src.who)
				var/mob/M=src.who
				if(M in world)
					M.loc=src.loc
					src.who=null
					M.Control=null
					M.client.eye=M
			..()

		Ship
			AndroidShip
				Health=1.#INF
				Level=0
				Cost=0
				Password="Androidz"
				icon='AndroidShip.dmi'
				pixel_x=-32
				pixel_y=-32
				//icon=''
			ChanglingShip
				Health=999999999999999999999
				Level=0
				Cost=0
				icon='ChanglingShip.dmi'
				pixel_y=-50
				pixel_x=-113
				Password="Changlingz"
			Health=999999999
			density=1
			icon='Shipz.dmi'
			Grabbable=0
			pixel_y=-32
			pixel_x=-48
			Cost=100000000
			UpgradePrice=1000000
			Level=50
			Click()
				..()
				if(who==usr)
					usr.Control=null
					usr.client.eye=usr
					src.who=null
				if(usr.client.eye==src)
					usr.client.eye=usr

		SpacePod
			Pickable=0
			UpgradePrice=250000
			icon='Tech.dmi'
			icon_state="PodRegular"
			Level=40
			Cost=10000000
			var/Remoting=0
			density=1
			Click()
				..()
				if(who==usr)
					usr.loc=src.loc
					usr.Control=null
					usr.client.eye=usr
					src.who=null
			verb/Use()
				set src in view(1)

				if(usr.Grab)
					usr<<"You cannot use this while grabbing something!"
					return
				if(!who)
					usr.loc=src.contents
					usr.Control=src
					usr.client.eye=src
					src.who=usr
				else
					usr<<"Theres someone else in there!"
			verb/Launch()
				set src in view(1)
				if(usr.z==12)return
				if(usr.Grab)
					usr<<"You cannot use this while grabbing something!"
					return
				if(src.Launching)return
				if(src.z==1||src.z==2||src.z==3||src.z==4||src.z==5)
					if(!who)
						usr.loc=src.contents
						usr.Control=src
						usr.client.eye=src
						src.who=usr
						Launching=1
						src.icon_state="PodRegularLaunching"
						usr<<"You will launch in 30 seconds!"
						sleep(300)
						Launching=0
						src.icon_state="PodRegular"
						if(src.z==14)
							var/placement=0
							for(var/i=src.x, i>100, i-=100)
								placement++
							for(var/q=src.y, q>100, q-=100)
								placement+=5

							for(var/obj/Planets/Alien/x in world)
								if(x.Zz==placement)
									src.loc=x.loc
									return


						else
							for(var/obj/Planets/x in world)
								if(!istype(x,/obj/Planets/Alien))
									if(x.Zz==src.z)
										src.loc=x.loc
										return
						src.loc=locate(250,250,12)
					else
						usr<<"Theres someone else in there!"
				else
					usr<<"You cannot launch here!"






