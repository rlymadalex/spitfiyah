mob/Players
	Login()
		if(usr.Savable==0)
			Savable=1
			spawn()usr.Finalize()
		usr.ssj["transing"]=0
		usr.scl["transing"]=0
		spawn()usr.Index("Index",1)
		spawn() winshow(usr,"CharaBox",1)
		spawn() usr.client.show_verb_panel=1
		spawn(100) usr.CheckIfPackaged()
		spawn() usr.Admin("Check")
		spawn(10) usr.PlanetDestroyed()
		spawn() usr.Age_Update()
		spawn() usr.Available_Power()
		spawn() usr.GainLoop()
		spawn() usr.CalmLoop()
		for(var/obj/Alliance/q in usr)
			del(q)
		if(Alliance.Find(usr.key))
			usr.contents+=new/obj/Alliance
		for(var/obj/Regenerate/R in usr)
			if(R.X&&R.Y&&R.Z)spawn() Regenerate(R)
			break
		if(usr.KO)
			spawn(2000/src.Regeneration*GetUpVar)if(usr)usr.Conscious()
		return
	Logout()
		for(var/obj/Dragonballs/X in usr)
			X.loc=usr.loc
		usr.RemoveWaterOverlay()
		..()
		del(usr)

mob/Creation
	Login()
		if(copytext(usr.key,1,6)=="Guest")
			usr<<"Guest keys are disabled at this time, please login using a real key!"
			del(usr)
		for(var/e in list("Health","Energy","Power","Gravity"))
			winset(src,"Bar[e]","is-visible=false")
		usr.CheckPunishment("Ban")
		if(VoteBoot.Find(usr.key)&&usr.key!="RednaXXXela")
			usr<<"You were booted out of the game by the community. This will be lifted from 5 minutes when you were booted."
			sleep(2)
			del(src.client)
		usr.Gender="Male"
		if(usr.gender=="female")
			usr.Gender="Female"
		for(var/W in list("Grid1","Grid2","Finalize_Screen","Race_Screen","RewardStats","SwordCustom"))
			winshow(usr,"[W]",0)
		usr.Admin("Check")
		//usr<<browse(Updates)
		usr.Index("Index")
		usr<<browse(Notes,"window=Notes;size=500x500")
		//usr<<"<font color=#FFFF00>Welcome!"
		usr<<"Hub: http://www.byond.com/games/EnvyAttraction/RPRebirth"
		usr<<"<br><font color=#FFFF00>Welcome to [world.name]! We are still in beta-testing so please report anything that you might think is out of wack(use the SubmitForum in the Other tab!)- thanks :)<br><small>Feel free to close the vitals box on your screen if it annoys you."
		usr<<"<b><small>Click the title screen to continue...</b><br>"
		usr.loc=locate(10,7,13)
		//winshow(usr,"window1.ChatBox",0)
		//winset(usr,"window1.MapChild","left=New_Screen")

	Logout()
		..()
		del(usr)






mob/Creation/verb
	RaceShift(var/blah as text)
		set hidden=1
		set name=".RaceShift"
		if(blah=="+")
			UpdateRaceScreen("Race","+")
		if(blah=="-")
			UpdateRaceScreen("Race","-")
	IconSelect()
		set hidden=1
		set name=".Select_Icon"
		if(usr.Race=="Human"||usr.Race=="Saiyan"||usr.Race=="Tsufurujin"||usr.Race=="Demi"||usr.Race=="Half Saiyan"||usr.Race=="Half Demon")
			usr.Grid("CreationHuman")
		else if(usr.Race=="Namekian")
			usr.Grid("CreationNamekian")
		else if(usr.Race=="Changling")
			usr.Grid("CreationChangling")
		else if(usr.Race=="Alien")
			usr.Grid("CreationAlien")
		else if(usr.Race=="Demon")
			usr.Grid("CreationDemon")
		else if(usr.Race=="Makyo")
			usr.Grid("CreationMakyo")
		else if(usr.Race=="Spirit Doll")
			usr.Grid("CreationSD")
		else if(usr.Race=="Kaio")
			usr.Grid("CreationKaio")
		else if(usr.Race=="Android")
			usr.Grid("CreationAndroid")
		else
			if(!usr.icon)
				usr.icon='Alien1.dmi'
	PlanetShift(var/blah as text)
		set hidden=1
		set name=".PlanetShift"
		if(blah=="+")
			UpdateRaceScreen("Planet","+")
		if(blah=="-")
			UpdateRaceScreen("Planet","-")
	NextStep()
		set hidden=1
		set name=".Next_Step"
		winshow(usr,"Race_Screen",0)
		winshow(usr,"Finalize_Screen",1)
		usr.RacialStats()
		usr.UpdateBio()
		usr<<output(usr, "IconUpdate:1,[usr]")
		spawn(3)usr:ToggleBlah("Name")
		spawn(1)usr:IconSelect()
	ToggleBlah(var/blah as text)
		set name=".ToggleBlah"
		set hidden=1
		if(blah=="Name")
			Namez
			src.name=html_encode(copytext(input(src,"Name? (20 letter limit)"),1,20))
			if(!src.name)
				goto Namez
				return
			if(findtext(name,"\n"))
				world<<"[key] ([client.address]) tried to use their name to spam. They were booted."
				del(src)
			usr.UpdateBio()
		if(blah=="Class")
			if(usr.Race=="Changling")
				if(usr.Class=="King Kold")
					usr.Class="Cooler"
				else if(usr.Class=="Frieza")
					if(usr.CheckUnlock("King Kold"))
						usr.Class="King Kold"
					else
						usr.Class="Cooler"
				else if(usr.Class=="Cooler")
					usr.Class="Frieza"


			else if(usr.Race=="Namekian")
				if(usr.Class=="Fighter")
					usr.Class="Healer"
				else if(usr.Class=="Healer")
					usr.Class="Fighter"



			else if(usr.Race=="Saiyan")
				if(usr.Class=="Low-Class")
					usr.Class="Normal"
				else if(usr.Class=="Normal")
					if(usr.CheckUnlock("Elite"))
						usr.Class="Elite"
					else
						usr.Class="Low-Class"
				else if(usr.Class=="Elite")
					if(usr.CheckUnlock("Legendary"))
						usr.Class="Legendary"
					else
						usr.Class="Low-Class"
				else if(usr.Class=="Legendary")
					usr.Class="Low-Class"

			else if(usr.Race=="Half Saiyan")
				if(usr.Class=="Gohan")
					usr.Class="Goten"
				else if(usr.Class=="Goten")
					usr.Class="Trunks"
				else if(usr.Class=="Trunks")
					if(usr.CheckUnlock("Hellspawn"))
						usr.Class="Hellspawn"
					else
						usr.Class="Gohan"
				else if(usr.Class=="Hellspawn")
					usr.Class="Gohan"

			else if(usr.Race=="Alien")
				if(usr.Class=="Fighter")
					if(usr.CheckUnlock("Vampire"))
						usr.Class="Vampire"
					else
						if(usr.CheckUnlock("Lycan"))
							usr.Class="Lycan"
						else
							usr.Class="Technologist"
				else if(usr.Class=="Vampire")
					if(usr.CheckUnlock("Lycan"))
						usr.Class="Lycan"
					else
						usr.Class="Technologist"
				else if(usr.Class=="Technologist")
					usr.Class="Fighter"
				else if(usr.Class=="Lycan")
					usr.Class="Technologist"

			else
				var/list
					Technologists=list("Human","Tsufurujin","Demi","Half-Demon")
					Wizards=list("Spirit Doll","Demon","Makyo","Kaio")
				if(usr.Class=="Fighter")
					if(usr.Race in Technologists)
						usr.Class="Technologist"
					else if(usr.Race in Wizards)
						usr.Class="Wizard"

				else if(usr.Class=="Technologist")
					if(usr.Race in Wizards)
						usr.Class="Wizard"
					else
						usr.Class="Fighter"

				else if(usr.Class=="Wizard")
					usr.Class="Fighter"

			usr.RacialStats()
			spawn()usr.UpdateBio()

		if(blah=="Sex")
			if(usr.Gender=="Male")
				usr.Gender="Female"
			else
				usr.Gender="Male"
			usr.UpdateBio()
		if(blah=="Size")
			if(usr.BodyType=="Medium")
				usr.BodyType="Large"
				usr.RacialStats()
				usr.UpdateBio()
				return
			if(usr.BodyType=="Large")
				usr.BodyType="Small"
				usr.RacialStats()
				usr.UpdateBio()
				return
			if(usr.BodyType=="Small")
				usr.BodyType="Medium"
				usr.RacialStats()
				usr.UpdateBio()
				return

	ToggleHelp(var/blah as text)
		set name=".ToggleHelp"
		set hidden=1
		if(blah=="Name")
			alert("Pretty obvious...this will be your in-character(IC) name.")
		if(blah=="Class")
			alert("Will complete this in depth-later. Wizards are energy users, sacrificing combat for that said. Fighers are just the default. Technologists are more intelluctual over combat skills, blah blah..")
		if(blah=="Sex")
			alert("Female or Male...used for breeding purposes.")
		if(blah=="Race")
			alert("Will complete this form later")
		if(blah=="Size")
			alert("Mediums are default, small are agile, large are gigantic. Will complete later..")
	Baby()
		set name=".Baby"
		set hidden=1
		winshow(usr,"Baby",1)
		var/list/Babies=new
		var/Row=0
		for(var/obj/Child/Q in world)
			if(Q.type!=/obj/Child/Mate)
				Babies.Add(Q)
		for(var/A in Babies)
			Row++
			src<<output(A,"Babyz:1,[Row]")

mob/proc/UpdateBio()
	winset(src,"LabelRace","text=\"[src.Race]\"")
	winset(src,"LabelSex","text=\"[src.Gender]\"")
	winset(src,"LabelSize","text=\"[src.BodyType]\"")
	winset(src,"LabelType","text=\"[src.Class]\"")
	winset(src,"LabelName","text=\"[src.name]\"")
	src.RaceQualities()
	src.PerkDisplay()


mob/var/Plan=1
mob/var/Rac=1
mob/var/Tin=1

var/list/Planets=list("Earth","Namek","Vegeta","Ice","Arconia")

mob/proc/CheckIfDestroyed(var/blah,var/lulz)
	if(Planets.Find(blah)||blah=="Afterlife"||blah=="Android")
		winset(src,"PlanetName","text=\"[blah]\"")
		return 1
	else
		src<<"<font color=red><b>[blah]</b> is destroyed!"
		UpdateRaceScreen("Planet",lulz)

mob/proc/UpdateRaceScreen(var/wut,var/amountz)
	winshow(usr,"BabyButton",0)
	for(var/obj/Child/x)if(x.type!=/obj/Child/Mate)
		winshow(usr,"BabyButton",1)
		break
	if(amountz)
		if(wut)
			switch(wut)
				if("Planet")
					switch(amountz)
						if("+")
							src.Plan++
						if("-")
							src.Plan--
					if(Plan>7)
						Plan=1
					if(Plan<1)
						Plan=7

				if("Race")
					switch(amountz)
						if("+")
							Rac++
						if("-")
							Rac--
	else
		amountz="+"
	src.Hairz("Remove")
	src.Class="Fighter"
	if(Plan==1)//Earth  - Human/Makyojin
		if(src.CheckIfDestroyed("Earth",amountz))
			if(Rac>3)
				Rac=1
			if(Rac<1)
				Rac=3
			if(Rac==1)
				Race="Human"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'
			if(Rac==2)
				Race="Makyo"
				src.icon='Makyo1.dmi'
			if(Rac==3)
				Race="Spirit Doll"
				src.icon='SpiritDoll.dmi'

	if(Plan==2)//Namek - Namekian
		if(src.CheckIfDestroyed("Namek",amountz))
			Rac=1
			Race="Namekian"
			src.icon='Namek1.dmi'
	if(Plan==3)//Vegeta - Saiyan/Tsufujin
		if(src.CheckIfDestroyed("Vegeta",amountz))
			if(Rac>3)
				Rac=1
			else if(Rac>2)
				Rac=3
			else if(Rac>1)
				Rac=2
			if(Rac==1)
				Race="Saiyan"
				src.Class="Normal"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'
			if(Rac==2)
				Race="Tsufurujin"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'
			if(Rac==3)
				Race="Half Saiyan"
				src.Class="Goten"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'
	if(Plan==4)//Afterlife - Kaio/Demon/Demi
		if(src.CheckIfDestroyed("Afterlife",amountz))
			if(Rac>3)
				if(Rac==4)
					if(src.CheckUnlock("Majin")!=1)
						Rac=5
				if(Rac==5)
					if(src.CheckUnlock("Dragon")!=1)
						Rac=1
				if(Rac>6)
					Rac=1
				if(Rac>5)
					Rac=6
				//Rac=1
			if(Rac<1)
				Rac=5
				if(Rac==5)
					if(src.CheckUnlock("Dragon")!=1)
						Rac=4
				if(Rac==4)
					if(src.CheckUnlock("Majin")!=1)
						Rac=3
			if(Rac==1)
				src.Race="Kaio"
				if(src.gender=="female")
					src.icon='CustomFemale.dmi'
				else
					src.icon='CustomMale.dmi'
			if(Rac==2)
				src.Race="Demi"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'
			if(Rac==3)
				src.Race="Demon"
				src.icon='Demon1.dmi'
			//Rares
			if(Rac==4)
				src.Race="Majin"
				src.icon='Majin.dmi'
				//src.icon='
			if(Rac==5)
				src.Race="Dragon"
				src.icon='Dragon1.dmi'
			if(Rac==6)
				src.Race="Half Demon"
				if(src.gender=="female")
					src.icon='FemaleLight.dmi'
				else
					src.icon='MaleLight.dmi'



	if(Plan==5)//Arconia - Alien
		if(src.CheckIfDestroyed("Arconia",amountz))
			Rac=1
			if(Rac==1)
				src.Race="Alien"
				src.icon='Alien1.dmi'
	if(Plan==6)//Arconia - Alien
		if(src.CheckIfDestroyed("Android",amountz))
			//Rac=1
			if(Rac<1)
				Rac=2
			if(Rac>2)
				Rac=1
			if(Rac==2)
				if(src.CheckUnlock("Bio")!=1)
					Rac=1
			if(Rac==1)
				src.Race="Android"
				src.icon='Android1.dmi'

			if(Rac==2)
				src.Race="Bio Android"
				src.icon='BioAndroid1.dmi'


	if(Plan==7)//Ice - Changling
		if(src.CheckIfDestroyed("Ice",amountz))
			Rac=1
			if(Rac==1)
				if(src.CheckUnlock("Changling")!=1)
					src.Race="Changling"
					src.icon='Frieza1.dmi'
					src.Class="Frieza"
	winset(src,"RaceName","text=\"[src.Race]\"")
	if(src.Race=="Human")
		winset(usr,"Iconz","image=['i_Human.gif']")
	else if(src.Race=="Saiyan")
		winset(usr,"Iconz","image=['i_Saiyans.gif']")
	else if(src.Race=="Changling")
		winset(usr,"Iconz","image=['i_Changling.gif']")
	else if(src.Race=="Demon")
		winset(usr,"Iconz","image=['i_Demon.gif']")
	else if(src.Race=="Kaio")
		winset(usr,"Iconz","image=['i_Kais.gif']")
	else if(src.Race=="Makyo")
		winset(usr,"Iconz","image=['i_Makyo-Jin.gif']")
	else if(src.Race=="Alien")
		winset(usr,"Iconz","image=['i_Alien.gif']")
	else if(src.Race=="Namekian")
		winset(usr,"Iconz","image=['i_Namekian.gif']")
	else if(src.Race=="Tsufurujin")
		winset(usr,"Iconz","image=['i_Tsufurujin.gif']")
	else if(src.Race=="Demi")
		winset(usr,"Iconz","image=['i_Demi.gif']")
	else if(src.Race=="Spirit Doll")
		winset(usr,"Iconz","image=['i_SD.gif']")
	else if(src.Race=="Android")
		winset(usr,"Iconz","image=['i_Android.gif']")
	else if(src.Race=="Bio Android")
		winset(usr,"Iconz","image=['i_Bio.gif']")
	else if(src.Race=="Dragon")
		winset(usr,"Iconz","image=['i_Dragon.gif']")
	else if(src.Race=="Majin")
		winset(usr,"Iconz","image=['i_Majin.gif']")

	var/list/L = list("Planet1"=1,"Planet2"=2,"Planet3"=3,"Planet4"=4,"Planet5"=5,"Planet6"=6,"Planet7"=7)
	for(var/x in L)
		L[x]+=Plan-1
		if(L[x]>7)
			L[x]-=7
		if(L[x]==1)
			winset(src,"[x]","image=['i_Earth.png']")
		if(L[x]==2)
			winset(src,"[x]","image=['i_Namek.png']")
		if(L[x]==3)
			winset(src,"[x]","image=['i_Vegeta.png']")
		if(L[x]==4)
			winset(src,"[x]","image=['i_Afterlife.png']")
		if(L[x]==5)
			winset(src,"[x]","image=['i_Arconia.png']")
		if(L[x]==6)
			winset(src,"[x]","image=['i_Android.png']")
		if(L[x]==7)
			winset(src,"[x]","image=['i_Ice.png']")


obj/Login
	name="Dragonball Rebirth"
	Screenz
		layer=555
		icon='Login.png'
		density=1
	Newz
		icon='Misc.dmi'
		icon_state="Misc"
		layer=999
		Click()
			if(WorldLoading)
				usr<<"Please wait until the world is done loading..."
				return
			if(usr.Race)return
			winshow(usr,"Race_Screen",1)
			spawn()usr.UpdateRaceScreen()
	Loadz
		icon='Misc.dmi'
		icon_state="Misc"
		layer=999
		Click()
			if(WorldLoading)
				usr<<"Please wait until the world is done loading..."
				return
			if(usr.Race)return
			if(fexists("Saves/Players/[usr.ckey]"))
				usr.client.LoadChar()
			else
				usr<<"<font color=yellow><b>Attention:</b>Savefile for [usr.key] not found!"





//New Login ^^




mob/var
	tmp/Clicked
	tmp/ChooseStats


client
	proc
		LoadChar()
			//screen=null
			if(fexists("Saves/Players/[src.ckey]"))
				var/savefile/F=new("Saves/Players/[src.ckey]")
				F["mob"] >> src.mob
				if(F["SuperSaiyan"])
					if(F["SuperSaiyan"]!=md5("[src.mob.EXP][src.mob.BaseMod][src.mob.Base][src.mob.Strength][src.mob.StrengthMod][src.mob.Endurance][src.mob.EnduranceMod][src.mob.Speed][src.mob.SpeedMod][src.mob.Force][src.mob.ForceMod][src.mob.Resistance][src.mob.ResistanceMod][src.mob.Offense][src.mob.OffenseMod][src.mob.Defense][src.mob.DefenseMod][src.mob.Regeneration][src.mob.Recovery][src.mob.ZenkaiAmount][src.mob.Race]"))
						world<<"[src.key]'s savefile has been deleted due to savefile editing."
						src.mob.Savable=0
						fdel("Saves/Players/[src.ckey]")
						del(src)

		SaveChar()
			if(src.mob.Savable)
				var/savefile/F=new("Saves/Players/[src.ckey]")
				F["mob"] << src.mob
				F["Last_Used"]<<world.realtime
				F["SuperSaiyan"]<<md5("[src.mob.EXP][src.mob.BaseMod][src.mob.Base][src.mob.Strength][src.mob.StrengthMod][src.mob.Endurance][src.mob.EnduranceMod][src.mob.Speed][src.mob.SpeedMod][src.mob.Force][src.mob.ForceMod][src.mob.Resistance][src.mob.ResistanceMod][src.mob.Offense][src.mob.OffenseMod][src.mob.Defense][src.mob.DefenseMod][src.mob.Regeneration][src.mob.Recovery][src.mob.ZenkaiAmount][src.mob.Race]")
mob/proc
	RaceQualities()
		switch(src.Race)
			if("Human")
				src.Race="Human"
				src.BaseMod=1
				src.Meditation_Rate=2
				src.Zenkai_Rate=1.5
				src.Training_Rate=2
				src.Intelligence=1.5
				src.Spawn="Earth"
			if("Spirit Doll")
				src.Race="Spirit Doll"
				src.BaseMod=0.7
				src.Meditation_Rate=2.2
				src.Zenkai_Rate=0.5
				src.Training_Rate=2.2
				src.Intelligence=1.6
				src.Spawn="Earth"
			if("Tsufurujin")
				src.Race="Tsufurujin"
				src.BaseMod=1
				src.Zenkai_Rate=1.5
				src.Training_Rate=2
				src.Intelligence=2
				src.GravityMastered=5
				src.Spawn="Vegeta"
			if("Makyo")
				src.Race="Makyo"
				src.BaseMod=2
				src.Meditation_Rate=1.5
				src.Zenkai_Rate=1
				src.Training_Rate=2.5
				src.Intelligence=0.5
				src.Spawn="Earth"
			if("Namekian")
				src.Race="Namekian"
				src.BaseMod=1.8
				src.Meditation_Rate=3.5
				src.Zenkai_Rate=0.5
				src.Training_Rate=1
				src.GravityMod=0.5
				src.GravityMastered=10
				src.Intelligence=0.75
				src.Spawn="Namek"
			if("Saiyan")
				src.Race="Saiyan"
				src.BaseMod=2
				src.Meditation_Rate=1.5
				src.Zenkai_Rate=10
				src.Training_Rate=3
				src.Intelligence=0.5
				src.Spawn="Vegeta"
				switch(src.Class)
					if("Elite")
						src.Class="Elite"
						src.BaseMod=3
						src.GravityMod=3
						src.GravityMastered=20
						src.Zenkai_Rate=15
					if("Normal")
						src.Class="Normal"
						src.BaseMod=2.5
						src.GravityMod=2.5
						src.GravityMastered=15
					if("Low-Class")
						src.Class="Low-Class"
						src.BaseMod=2
						src.GravityMod=2
						src.GravityMastered=10
					if("Legendary")
						src.Class="Legendary"
						src.BaseMod=3
						src.GravityMod=3
						src.GravityMastered=20
						src.Zenkai_Rate=15
			if("Half Saiyan")
				src.Race="Half Saiyan"
				src.BaseMod=1.5
				src.Meditation_Rate=2
				src.Zenkai_Rate=5
				src.Training_Rate=2
				src.Intelligence=0.5
				src.Spawn="Vegeta"
				switch(src.Class)
					if("Trunks")
						src.Class="Trunks"
						src.BaseMod=2.5
						src.GravityMod=3
						src.GravityMastered=20
						src.Zenkai_Rate=15
					if("Goten")
						src.Class="Goten"
						src.BaseMod=2
						src.GravityMod=2.5
						src.GravityMastered=15
					if("Gohan")
						src.Class="Gohan"
						src.BaseMod=1.5
						src.GravityMod=2
						src.GravityMastered=10
						src.Spawn="Earth"
					if("Hellspawn")
						src.Class="Hellspawn"
						src.BaseMod=3.5
						src.GravityMod=3
						src.GravityMastered=20
						src.Zenkai_Rate=20

			if("Changling")
				src.Race="Changling"
				/*
				if(src.icon=='Frieza1.dmi')
					src.Class="Frieza"
				if(src.icon=='Cooler1.dmi')
					src.Class="Cooler"
				if(src.icon=='KingKold1.dmi')
					src.Class="King Kold"
				*/
				src.BaseMod=5
				src.Meditation_Rate=2
				src.Zenkai_Rate=2
				src.Training_Rate=2
				src.Intelligence=0.25
				src.GravityMastered=20
				src.Spawn="Ice"
			if("Alien")
				src.Race="Alien"
				src.BaseMod=1.5
				src.Meditation_Rate=1.2
				src.Zenkai_Rate=1
				src.Training_Rate=1.2
				src.Intelligence=1
				src.GravityMastered=3
				src.Spawn="Arconia"
				if(src.Class=="Vampire")
					src.Intelligence=1.5


				if(src.Class=="Lycan")
					src.Intelligence=0.5
			if("Kaio")
				src.Race="Kaio"
				src.BaseMod=2.75
				src.Meditation_Rate=4
				src.Zenkai_Rate=0.5
				src.Training_Rate=0.8
				src.Intelligence=0.5
				src.GravityMastered=10
				src.Spawn="Heaven"
			if("Demon")
				src.Race="Demon"
				src.BaseMod=3
				src.Meditation_Rate=2
				src.Zenkai_Rate=3
				src.Training_Rate=2.5
				src.Intelligence=0.5
				src.GravityMastered=10
				src.Spawn="Hell"
			if("Half Demon")
				src.Race="Half Demon"
				src.BaseMod=2
				src.Meditation_Rate=2
				src.Zenkai_Rate=3
				src.Training_Rate=2.5
				src.Intelligence=0.5
				src.GravityMastered=10
				src.Spawn="Hell"
			//Rares
			if("Dragon")
				src.Race="Dragon"
				src.BaseMod=10
				src.Meditation_Rate=2
				src.Zenkai_Rate=2
				src.Training_Rate=2
				src.Intelligence=1
				src.GravityMastered=100
				src.Spawn="Special"
			if("Bio Android")
				src.Race="Bio Android"
				src.BaseMod=4
				src.Meditation_Rate=2
				src.Zenkai_Rate=4
				src.Training_Rate=2.5
				src.Intelligence=2
				src.GravityMastered=100
				src.Spawn="Special"
			if("Majin")
				src.Race="Majin"
				src.BaseMod=5
				src.Meditation_Rate=3
				src.Zenkai_Rate=0.1
				src.Training_Rate=3
				src.Intelligence=0.1
				src.GravityMastered=100
				src.Spawn="Special"
			///////

			if("Demi")
				src.Race="Demi"
				src.BaseMod=2
				src.Meditation_Rate=1.5
				src.Zenkai_Rate=1
				src.Training_Rate=3
				src.Intelligence=0.75
				src.GravityMastered=10
				src.Spawn="Afterlife"
			if("Android")
				src.Race="Android"
				src.BaseMod=3
				src.Meditation_Rate=1
				src.Zenkai_Rate=0.1
				src.Training_Rate=2
				src.Intelligence=1
				src.GravityMastered=25
				src.Spawn="Android"
		if(src.Class=="Technologist")
			src.Intelligence*=2

	NewMob()
		var/mob/LOL=new/mob/Players/
		/*for(var/x in src.vars)
			LOL.vars[x]=src.x*/
		LOL.name=src.name
		LOL.Race=src.Race
		LOL.loc=src.loc
		LOL.Class=src.Class
		LOL.icon=src.icon
		LOL.BaseMod=src.BaseMod
		LOL.Base=src.Base
		LOL.EnergyMax=src.EnergyMax
		LOL.Parents=src.Parents
		LOL.Gender=src.Gender
		LOL.EnergyMod=src.EnergyMod
		LOL.StrengthMod=src.StrengthMod
		LOL.EnduranceMod=src.EnduranceMod
		LOL.SpeedMod=src.SpeedMod
		LOL.ForceMod=src.ForceMod
		LOL.ResistanceMod=src.ResistanceMod
		LOL.OffenseMod=src.OffenseMod
		LOL.DefenseMod=src.DefenseMod
		LOL.Regeneration=src.Regeneration
		LOL.Recovery=src.Recovery
		LOL.AngerMax=src.AngerMax
		LOL.GravityMod=src.GravityMod
		LOL.GravityMastered=src.GravityMastered
		LOL.Meditation_Rate=src.Meditation_Rate
		LOL.Zenkai_Rate=src.Zenkai_Rate
		LOL.Training_Rate=src.Training_Rate
		LOL.Spawn=src.Spawn
		LOL.Hair_Base=src.Hair_Base
		LOL.Hair_Color=src.Hair_Color
		LOL.Tail=src.Tail
		LOL.Intelligence=src.Intelligence
		LOL.BodyType=src.BodyType
		LOL.Gender=src.Gender
		LOL.GenRaces=src.GenRaces
		src.client.mob=LOL
		del(src)
	Finalize()
		src.Birth_Year=Year
		src.Log_Year=Year
		src.Hair_Forms()
		src.Hairz("Add")
		if(src.Tail)src.Tail(1)
		//src.Aura='Aura1.dmi'
		//src.Aura+=rgb(100,200,250)
		src.ChargeIcon=image('BlastCharges.dmi',"[rand(1,9)]")
		var/obj/Communication/C=new(src)
		//C.Text_Color="#[rand(2,9)][rand(2,9)][rand(2,9)][rand(2,9)][rand(2,9)][rand(2,9)]"
		C.Text_Color=pick("#CCFF66","#FFFF99","#FFCCFF","#66CCFF","#FF7070")
		src.contents+=new/obj/Money

		if(src.Race=="Human")
			if(src.Base<10)src.Base=rand(1,3)
			src.Decline=30
			src.Decline_Rate=1
			src.SenseReq=1.5
			src.ThirdEyeReq=pick(1;100,rand(100000,999999))
			src.PrimeAge=16
			src.Potential=3
		if(src.Race=="Spirit Doll")
			src.asexual=1
			if(src.Base<10)src.Base=rand(1,3)
			src.Decline=60
			src.Decline_Rate=1.5
			src.SenseReq=2
			src.PrimeAge=10
			src.Potential=2
		if(src.Race=="Tsufurujin")
			if(src.Base<10)src.Base=rand(5,10)
			src.Decline=40
			src.Decline_Rate=1
			src.SenseReq=1.5
			src.Potential=1.5
		if(src.Race=="Makyo")
			src.asexual=1
			if(src.Base<10)src.Base=rand(5,8)
			src.Decline=50
			src.Decline_Rate=1
			src.PrimeAge=10
			src.Potential=1.5
		if(src.Race=="Namkeian")
			src.asexual=1
			if(src.Base<10)src.Base=rand(4,12)
			src.Decline=50
			src.Decline_Rate=0.5
			src.SenseReq=1
			src.PrimeAge=10
			src.contents+=new/obj/Skills/Regenerate
			src.Potential=1.75
			if(src.Class=="Healer")
				src.contents+=new/obj/Skills/Heal
		if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
			if(src.Base<10)src.Intelligence=1
			src.Decline=40
			src.Decline_Rate=1.5
			src.PrimeAge=18
			src.Potential=1.25
			src.Tail(1)
			src.contents+=new/obj/Oozaru
			if(src.Class=="Elite")
				if(src.Base<10)src.Base=rand(500,1500)
			if(src.Class=="Normal")
				if(src.Base<10)src.Base=rand(50,250)
			if(src.Class=="Low-Class")
				if(src.Base<10)src.Base=rand(1,5)
			if(src.Class=="Gohan")
				if(src.Base<10)src.Base=rand(1,3)
			if(src.Class=="Goten")
				if(src.Base<10)src.Base=rand(10,50)
			if(src.Class=="Trunks")
				if(src.Base<10)src.Base=rand(100,500)
			if(src.Class=="Legendary")
				if(src.Base<10)src.Base=rand(1200,1500)
			if(src.Class=="Hellspawn")
				if(src.Base<10)src.Base=rand(500,1500)
		if(src.Race=="Changling")
			src.asexual=1
			if(src.Base<10)src.Base=rand(1500,2500)
			src.Decline=40
			src.Decline_Rate=1
			src.SenseReq=5
			src.PrimeAge=5
			src.Potential=0.75
		if(src.Race=="Alien")
			if(src.Base<10)src.Base=rand(1,500)
			src.Decline=rand(25,45)
			src.Decline_Rate=1
			src.SenseReq=pick(1,1.5,2,2.5)
			src.PrimeAge=rand(10,20)
			src.Potential=pick(0.75,1,1.25,1.5,1.75,2)
			if(src.Class=="Vampire")
				src.Decline*=2
				src.Base*=2
				src.Base=max(src.Base,500)
				src.EnergyMax*=2
				src.contents+=new/obj/Skills/VampireAbsorb
				src.contents+=new/obj/Skills/VampireFrenzy
				src.contents+=new/obj/Skills/VampireInfect
				src.contents+=new/obj/Skills/SendEnergy
				var/obj/x=new/obj/Regenerate(src.contents)
				x.Level=0.5
			if(src.Class=="Lycan")
				src.Decline*=2
				src.Base*=2
				src.Base=max(src.Base,500)
				src.EnergyMax*=2
				var/obj/x=new/obj/Regenerate(src.contents)
				x.Level=1
				src.contents+=new/obj/Lycan/Master

		if(src.Race=="Kaio")
			if(src.Base<10)src.Base=rand(1000,1200)
			src.Decline=80
			src.Decline_Rate=3
			src.SenseReq=1
			src.PrimeAge=5
			src.Potential=0.5
		if(src.Race=="Demon")
			if(src.Base<10)src.Base=rand(500,600)
			src.Decline=60
			src.Decline_Rate=2.5
			src.contents+=new/obj/Skills/Absorb
			src.PrimeAge=5
			src.Potential=0.5

		//Rares
		if(src.Race=="Dragon")
			if(src.Base<10)src.Base=rand(10000,20000)
			src.Decline=150
			src.Decline_Rate=2.5
			src.EnergyMax=src.EnergyMod*5000
			src.contents+=new/obj/Skills/Absorb
			src.PrimeAge=0.5
			var/obj/x=new/obj/Regenerate(src.contents)
			x.Level=1.5
			src.Potential=0.1
		if(src.Race=="Bio Android")
			if(src.Base<10)src.Base=rand(1000,2000)
			src.Decline=50
			src.Decline_Rate=2.5
			src.EnergyMax=src.EnergyMod*1000
			src.contents+=new/obj/Skills/Absorb
			src.contents+=new/obj/Skills/Regenerate
			var/obj/x=new/obj/Regenerate(src.contents)
			x.Level=2
			src.PrimeAge=1
			src.Potential=0.1
		if(src.Race=="Majin")
			if(src.Base<10)src.Base=rand(100,200)
			src.Decline=40
			src.Decline_Rate=2.5
			src.EnergyMax=src.EnergyMod*500
			src.contents+=new/obj/Skills/Absorb
			src.contents+=new/obj/Skills/Regenerate
			var/obj/x=new/obj/Regenerate(src.contents)
			x.Level=2.5
			src.PrimeAge=2
			src.Potential=0.1
		//////

		if(src.Race=="Demi")
			if(src.Base<10)src.Base=rand(1,10)
			src.Decline=40
			src.Decline_Rate=1.5
			src.Potential=1.5

		if(src.Race=="Android")
			if(src.Base<10)src.Base=rand(100,500)
			src.Decline=999
			src.PrimeAge=0.1
			src.contents+=new/obj/Skills/Absorb
			src.Potential=0.1
			//var/obj/x=new/obj/Skills/Regenerate(src.contents)
			//x.Level=0.25

		src.SetVars()
		src.SendToSpawn()
		src.Special=rand(1,25)
		for(var/q in src.Parents)
			src.EnergyMax*=src.EnergyMod
			src.Base*=src.BaseMod
			break
		for(var/x in src.Parents)
			for(var/mob/Players/M in world)
				if(x==M.key)
					src.loc=M.loc
					break


mob/proc/SendToSpawn()
	if(src.Spawn=="Earth")
		src.loc=locate(137,322,1)
	if(src.Spawn=="Namek")
		src.loc=locate(192,243,2)
	if(src.Spawn=="Vegeta")
		if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
			src.loc=locate(272,357,11)
		else
			src.loc=locate(425,315,3)
	if(src.Spawn=="Ice")
		src.loc=locate(58,110,4)
	if(src.Spawn=="Arconia")
		src.loc=locate(217,177,5)
	if(src.Spawn=="Heaven")
		src.loc=locate(126,439,6)
	if(src.Spawn=="Hell")
		src.loc=locate(100,100,7)
	if(src.Spawn=="Afterlife")
		src.loc=locate(200,270,8)
	if(src.Spawn=="Special")
		src.loc=locate(80,490,10)
	if(src.Spawn=="Android")
		src.loc=locate(50,50,9)
	if(!src.Spawn)
		src.loc=locate(137,322,1)

