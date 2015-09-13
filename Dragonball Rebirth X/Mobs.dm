mob/Players
	Savable=0
	Write(savefile/A)
		..()
		A["x"]<<x
		A["y"]<<y
		A["z"]<<z
	Read(savefile/A)
		..()
		loc=locate(A["x"],A["y"],A["z"])

	Bump(mob/A)
		if(istype(A,/obj/Turfs/Door))
			var/obj/Turfs/Door/B=A
			if(B.Password)
				var/eee
				for(var/obj/Items/Tech/DoorPass/Q in usr)
					if(Q.Password==B.Password)
						B.Open()
						eee=1
				if(!eee)
					var/Guess=input(src,"You must know the password to enter here") as text
					if(Guess==B.Password)
						B.Open()
			else
				B.Open()

		PlanetEnterBump(A,src)

		if(istype(A,/obj/Items/Tech/SpaceTravel/Ship))
			var/obj/Items/Tech/SpaceTravel/Ship/LOL=A
			for(var/obj/ShipConsole/Q)
				if(Q.Password==LOL.Password)
					src.loc=locate(Q.x,Q.y-1,Q.z)
					return
			AdminMessage("[usr]([usr.key]) tried entering a broken ship!")

