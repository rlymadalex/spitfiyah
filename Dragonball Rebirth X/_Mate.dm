obj/Child
	Click()
		if(istype(usr,/mob/Creation))
			winshow(usr,"Baby",0)
			usr.Race=src.Race
			usr.EnergyMax=src.EnergyMax
			usr.Base=src.Base
			usr.icon=src.icon
			usr.Parents=src.Parents
			usr.GenRaces=src.GenRaces
			if(usr.Race=="Saiyan")
				usr.Class="Normal"
			if(usr.Race=="Half Saiyan")
				usr.Class="Goten"
			usr:NextStep()
			spawn del(src)
	icon='Baby.dmi'
	var
		Race
		list/Parents=new
		EnergyMax
		Base
		list/GenRaces=new
	Mate
		var/Last
		verb/Mate(mob/Players/M in oview(1))
			set category="Other"
			for(var/obj/Child/Mate/Q in M)
				if(usr.asexual)
					if(src.Last)
						if(abs(Year-src.Last)<1)return
					src.Last=Year
					var/obj/Child/E=new /obj/Child
					E.Race=usr.Race
					E.EnergyMax=usr.EnergyMax/usr.EnergyMod
					E.Base=usr.Base/usr.BaseMod
					E.Parents.Add(usr.key)
					E.name="Egg([usr])"
					usr.contents+=E
					Q.Last=Year
					src.Last=Year
				else
					if(M.Gender=="Female"&&usr.Gender=="Male"||M.Gender=="Male"&&usr.Gender=="Female")
						if(src.Last)
							if(abs(Year-src.Last)<1)return
						if(Q.Last)
							if(abs(Year-Q.Last)<1)return
						var/blah=input(M,"[usr] wants to mate with you!","Sex?") in list("Deny","Consent")
						if(blah=="Consent")
							if(M&&Q)
								if(src.Last)
									if(abs(Year-src.Last)<1)return
								if(Q.Last)
									if(abs(Year-Q.Last)<1)return
								var/obj/Child/E=new /obj/Child
								var/Racee=pick(M.Race,usr.Race)

								var/list/heh=new
								heh.Add(usr.Race,M.Race)
								for(var/x in usr.GenRaces)
									heh.Add(x)
								for(var/w in Q.GenRaces)
									heh.Add(w)
								for(var/m in heh)
									E.GenRaces.Add(m)
								if(usr.Race=="Saiyan"&&M.Race=="Human"||Q.Race=="Saiyan"&&usr.Race=="Human")
									Racee="Half Saiyan"
								else if(usr.Race=="Saiyan"&&M.Race=="Demon"||Q.Race=="Saiyan"&&usr.Race=="Demon")
									Racee="Half Saiyan"
								else if(usr.Race=="Demon"&&M.Race=="Human"||Q.Race=="Demon"&&usr.Race=="Human")
									Racee="Half Demon"
								E.Race=Racee
								E.EnergyMax=((M.EnergyMax/M.EnergyMod)+(usr.EnergyMax/usr.EnergyMod))/2
								E.Base=((M.Base/M.BaseMod)+(usr.Base/usr.BaseMod))/2
								E.Parents.Add(M.key,usr.key)
								E.name="Baby([usr]&[M])"
								if(usr.Gender=="Female")
									M<<"Mission success!"
									usr<<"You're pregnant!"
									usr.contents+=E
								else if(M.Gender=="Female")
									usr<<"Misson success!"
									M<<"You're pregnant!"
									M.contents+=E
								Q.Last=Year
								src.Last=Year
					break