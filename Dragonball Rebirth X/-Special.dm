//Vampire and Lycan
mob/var/tmp/Shocked=0

obj/Skills

	//Vamp
	SendEnergy
		Teachable=0
		Level=100
		desc="Can continually tranfer energy to someone at the cost of your own energy."
		verb/TransferEnergy()
			set category="Skills"
			if(usr.Transfering)
				usr<<"You stop transfering"
				usr.Transfering=null
				return
			var/list/who=list("Cancel")
			for(var/mob/Players/M in oview(5,usr))
				who.Add(M)
			var/mob/blah=input("Who do you want to transfer energy to?","Energy Transfer")in who
			if(blah=="Cancel")return
			if(blah)
				usr.Transfering=blah
	VampireAbsorb
		Teachable=0
		Level=100
		desc="While active, for each hit that you land you drain a % of the victims energy. While active it decreases the effiency of energy abilities."
		verb/Vampire_Absorb()
			set category="Skills"
			usr.SkillX("VAbsorb",src)
	VampireFrenzy
		Teachable=0
		Level=0
		var/oldicon
		desc="While active it increases speed but decreases general skill. Not recommended for combat."
		verb/Vampire_Frenzy()
			set category="Skills"
			usr.SkillX("VFrenzy",src)
			sleep(10)
	VampireInfect
		Teachable=0
		Level=100
		desc="Infects someone with a vampire's skills."
		verb/Infect()
			set category="Skills"
			if(usr.Dead)
				usr<<"You're dead!"
				return
			var/list/who=list("Cancel")
			for(var/mob/Players/M in oview(1,usr))
				if(M.Class!="Vampire"&&!M.Dead)
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
					if(!(locate(/obj/Skills/VampireAbsorb,blah.contents)))
						blah.contents+=new/obj/Skills/VampireAbsorb
					if(!(locate(/obj/Skills/VampireFrenzy,blah.contents)))
						blah.contents+=new/obj/Skills/VampireFrenzy
