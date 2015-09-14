proc/SenseDetect(atom/A,Range)
	var/list/Mobs=new
	for(var/mob/P in world)
		if(P.client)
			if(P.z==A.z)
				var/t=abs(usr.x-P.x)+abs(usr.y-P.y)
				if(t<10)
					Mobs+=P
					continue
				else
					if(t<Range*P.ControlPower)
						Mobs+=P
	return Mobs

mob/var/list/Tabz=list("Science"="Hide","Build"="Hide")

mob/Players/verb/ArrangeTabs()
	set category="Other"
	var/list/tabz=list("Science","Build","Cancel")
	var/blah=input("Toggle which tab?")in tabz
	if(blah=="Cancel")return
	if(usr.Tabz["[blah]"]=="Show")
		usr.Tabz["[blah]"]="Hide"
		usr<<"[blah] tab hidden!"
	else
		usr.Tabz["[blah]"]="Show"
		usr<<"[blah] tab showing!"


mob/proc/SenseRange()
	var/blah=src.EnergyMax/25
	if(blah>1000)
		blah=1000
	return blah
mob/var/StatTick=15
mob/Players/Stat()
	//set background=1
	for(var/obj/Vote/V in world)
		statpanel("Vote")
		if(statpanel("Vote"))
			stat(V)
			stat("Vote starter:","[V.VoterN]{[V.Voter]}")
			stat("Vote target:","[V.VotedN]{[V.Voted]}")
			stat("Vote reason:","[V.reason]")
			stat("Votes (Y/N):","[V.yes]/[V.no]")
			stat("Time left:","[V.time] seconds")
			stat("-----------")
	for(var/obj/Child/E in contents)
		if(E.type!=/obj/Child/Mate)
			statpanel("Offspring")
			if(statpanel("Offspring"))
				stat(E)
				stat("Race:","[E.Race]")
				stat("-----------")

	if(Target)
		if(istype(Target,/mob))
			if(Target.KO||istype(Target,/mob/Body))
				if(Target!=src)
					if(!src.KO)
						if(Target in view(1))
							statpanel("Loot")
							if(statpanel("Loot"))
								stat(Target)
								for(var/obj/A in Target) if(A.Stealable) stat(A)
	if(client.show_verb_panel&&!Tabs)
		if(Health<50)
			Anger()
			if(Health<=0)
				Health=0
				if(!KO)
					spawn(10)if(Health<0&&!KO) Unconscious(null,"low health!")
		if(Energy<0) Energy=0
		statpanel("Statistics")
		if(statpanel("Statistics"))
			stat("Strength","[Percent(Strength)]")
			stat("Endurance","[Percent(Endurance)]")
			stat("Speed","[Percent(Speed)]")
			stat("Force","[Percent(Force)]")
			stat("Resistance","[Percent(Resistance)]")
			stat("Offense","[Percent(Offense)]")
			stat("Defense","[Percent(Defense)]")
			stat("Regeneration","[Regeneration]")
			stat("Recovery","[Recovery]")
			stat("----","----")
			stat("Passive Skills:")
			//stat("Unarmed:","[Skillz["Unarmed"]["Level"]] ([Skillz["Unarmed"]["Current"]]/[Skillz["Unarmed"]["Next"]])")
			//stat("Sword:","[Skillz["Sword"]["Level"]] ([Skillz["Sword"]["Current"]]/[Skillz["Sword"]["Next"]])")
			stat("Combo:","[Skillz["Warp"]["Level"]] ([Skillz["Warp"]["Current"]] /[Skillz["Warp"]["Next"]])")
			stat("Swimming:","[Skillz["Swim"]["Level"]] ([Skillz["Swim"]["Current"]] /[Skillz["Swim"]["Next"]])")
			stat("Dig:","[Skillz["Dig"]["Level"]] ([Skillz["Dig"]["Current"]] /[Skillz["Dig"]["Next"]])")



		if(Admin)
			statpanel("Overview")
			if(statpanel("Overview"))
				stat("CPU","[world.cpu]")
				stat("Power Gains","[Gains]%")
				stat("EXP Gains","[EXPGains]%")
				stat("Stat Gains","[StatGains]%")
				stat("Energy Gains","[EnergyGains]%")
				stat("Intellect Gains","[IntRate]%")
				stat("Decline Gains","[DeclineGains]%")
				stat("Speed Effect","[SpeedEffect]x")
				stat("Control Regen/Recov","[ControlRegen]/[ControlRecov]")
				stat("Punch Drain","[DrainHard]x")
				stat("Leech Hardness","[LeechHard]x")
				stat("Mastery Hardness","[MasteryHard]x")
				stat("Year/Speed","[Year]/[Year_Speed]x")
				stat("Unconcious Speed","[GetUpVar]x")
				for(var/mob/Players/P)
					stat("[Commas(round(P.Power))]([round(P.Health)]%/[round(P.Energy/P.EnergyMax*100)]%)",P)
		statpanel("Inventory")
		if(statpanel("Inventory"))
			for(var/obj/Money/M in usr)
				stat(M)
			for(var/obj/Items/A in usr)
				stat(A)


		if(usr.Control)
			var/obj/Items/Tech/SpaceTravel/M=usr.Control
			if(istype(M,/obj/Items/Tech/SpaceTravel))
				if(M in world)
					if(M.z==12&&M.Lvl>=50)
						statpanel("Navigation")
						if(statpanel("Navigation"))
							for(var/obj/Planets/Z in world)
								stat("[M.CheckDirection(Z)]",Z)

		var/Scouterz=0
		for(var/obj/Items/Tech/Scouter/L in usr.contents)
			if(L.suffix)
				Scouterz=1
				statpanel("Scouter")
				if(statpanel("Scouter"))
					for(var/mob/Players/M in world)
						if(!M.AdminInviso)
							if(M.z==usr.z||M.Power>1000000000)
								if(M in SenseDetect(usr,usr.SenseRange())||M.Power>1000000)
									if(M.Power<=L.Lvl*L.Lvl*10000)
										stat("[Get_Scouter_Reading(M)] [CheckDirection(M)]",M)
									else
										stat("??? [CheckDirection(M)]",M)
				break
		if(Class=="Lycan"||Class=="Vampire")
			statpanel("Smell")
			if(statpanel("Smell"))
				for(var/mob/Players/M in view(20))
					if(!M.AdminInviso)
						var/show="Clean"
						if(locate(/obj/Lycan) in M)
							show="Lycan"
						if(locate(/obj/Skills/VampireAbsorb) in M)
							if(show=="Lycan")
								show="Half Breed"
							else show="Vampire"
						stat("[show] [CheckDirection(M)]",M)

		if(Scouterz==0)
			if(usr.SenseReq*250<EnergyMax||usr.Admin)
				statpanel("Sense")
				if(statpanel("Sense"))
					for(var/mob/Players/M in world)
						if(!M.AdminInviso)
							if(M.z==usr.z||M.Power>1000000000)
								if(M in SenseDetect(usr,usr.SenseRange())||M.Power>1000000)
									stat("[Get_Sense_Reading(M)]% [CheckDirection(M)]",M)
			if(usr.Target)
				if(ismob(usr.Target))
					if(SenseReq*500<EnergyMax||usr.Admin)
						statpanel("Enhanced Sense")
						if(statpanel("Enhanced Sense"))
							stat("Focused:",Target)
							stat("Direction","[CheckDirection(Target)]")
							stat("Power;","[Get_Sense_Reading(Target)]% yours")
							stat("Health","[Target.Health]%")
							stat("Energy","[(Target.Energy/Target.EnergyMax)*100]%")
							if(SenseReq*1000<EnergyMax)
								stat("Strength","[(Target.Strength/Target.StrengthMod/(Strength/StrengthMod)*100)]% yours")
								stat("Endurance","[(Target.Endurance/Target.EnduranceMod/(Endurance/EnduranceMod)*100)]% yours")
								stat("Speed","[(Target.Speed/Target.SpeedMod/(Speed/SpeedMod)*100)]% yours")
								stat("Force","[(Target.Force/Target.ForceMod/(Force/ForceMod)*100)]% yours")
								stat("Resistance","[(Target.Resistance/Target.ResistanceMod/(Resistance/ResistanceMod)*100)]% yours")
								stat("Offense","[(Target.Offense/Target.OffenseMod/(Offense/OffenseMod)*100)]% yours")
								stat("Defense","[(Target.Defense/Target.DefenseMod/(Defense/DefenseMod)*100)]% yours")
							if(usr.Admin)
								for(var/obj/Z in Target.contents)
									if(!Z.AdminInviso)
										stat(Z)
		if(usr.Tabz["Build"]=="Show")
			if(usr.Age>=1||usr.Admin)
				statpanel("Build")
				if(statpanel("Build")) stat(Builds)
		if(usr.Tabz["Science"]=="Show")
			if(usr.Intelligence>0)
				statpanel("Science")
				if(statpanel("Science"))
					stat("Level:","[usr.IntelligenceLevel]")
					stat("EXP:","[usr.IntelligenceEXP]/[usr.IntelligenceEXPNeeded]")
					for(var/obj/Money/M in usr)
						stat(M)
					for(var/obj/O in Technology_List)
						if(usr.IntelligenceLevel>=O.Level)
							stat("[Commas(Technology_Price(src,O))]",O)

	sleep(StatTick)
/*

	else if(Tabs=="Appearance")
		statpanel("Hair")
		if(statpanel("Hair"))
			stat(Done)
			stat(Hair_List)
		statpanel("Clothes")
		if(statpanel("Clothes"))
			stat(Done)
			stat(Clothes_List)
		statpanel("Aura")
		if(statpanel("Aura"))
			stat(Done)
			stat(Aura_List)
		for(var/obj/Skills/Attacks/A in src)
			statpanel("Blasts")
			if(statpanel("Blasts"))
				stat(Done)
				stat(Blast_List)
			break*/

/*	else if(Tabs=="Customize Stats")
		statpanel("Customize Stats")
		stat("Strength","[Strength]x")
		stat("Endurance","[Endurance]x")
		stat("Force","[Force]x")
		stat("Resistance","[Resistance]x")
		stat("Speed","[Speed]x")
		stat("Efficiency","[Efficiency]x")
		stat("Regeneration","[Regeneration]x")
		stat("Recovery","[Recovery]x")
		stat("Offense","[Offense]x")
		stat("Defense","[Defense]x")*/

atom/proc/CheckDirection(var/mob/M)
	if(M)
		if(M.z==src.z)
			if(M.x > src.x)
				if(M.y>usr.y)
					return "North East"
				if(M.y<usr.y)
					return "South East"
				if(M.y==usr.y)
					return "East"
			if(M.x < usr.x)
				if(M.y>usr.y)
					return "North West"
				if(M.y<usr.y)
					return "South West"
				if(M.y==usr.y)
					return "West"
			if(M.x == usr.x)
				if(M.y>usr.y)
					return "North"
				if(M.y<usr.y)
					return "South"
				if(M.y==usr.y)
					return "-"
		else
			return "???"









mob/proc/GetPowerUpRatio()
	//var/Ratio=1+(Charged_Power*0.025)
	var/Ratio=round(ControlPower)/100
	if(Ratio<=0)
		Ratio=0.00001
	return Ratio

mob/proc/Recover(var/blah,Amount=1)
	switch(blah)
		if("Health")
			if(Health<100&&!KO&&!Transfering&&icon_state!="Train"&&icon_state!="Flight"&&icon_state!=""&&icon_state!="KB"&&icon_state!="Attack"&&icon_state!="Blast"&&icon_state!="KO")
				if(Health<=10) Amount/=20
				Health+=0.334*Regeneration*Amount*ControlRegen //5 minutes if 1 regeneration
				if(Health>100) Health=100

		if("Energy")
			if(Energy<EnergyMax&&!Charged_Power&&icon_state!="Train"&&!Transfering&&icon_state!="Attack"&&icon_state!="Blast")
				if(Energy<=EnergyMax/10) Amount/=10
				Energy+=0.334*(EnergyMax*0.01)*Recovery*Amount*ControlRecov //5 minutes if 1 regeneration
				if(Energy>EnergyMax) Energy=EnergyMax

mob
	proc
		CalmLoop()
			set background=1
			while(src)
				if(Anger>0)
					src.OMessage(10,"<font color=white><i>[src] becomes calm.","<font color=silver>[src]([src.key]) becomes calm.")
					Anger=0
				sleep(rand(4000,15000))



mob/proc/Available_Power()
	while(src)
		sleep(10)
		//Avaliable Power
		var/Ratio=Base*20*Body*Power_Multiplier*RPPower


		//Health
		if(src.Race!="Android")
			if(!src.Anger)
				Ratio*=max(sqrt(max(Health/100,0.01)),0.01)
		//
		//Energy
		if(src.Race!="Android")
			Ratio*=max(sqrt(max(Energy/EnergyMax,0.01)),0.01)
		//
		if(Anger) Ratio*=Anger
		if(KaiokenBP) Ratio+=KaiokenBP
		if(PlusPower) Ratio+=PlusPower
		if(CyberPower)Ratio+=CyberPower
		if(AbsorbPower)Ratio+=AbsorbPower

		//
		Power=Ratio*GetPowerUpRatio()

		//Power=GetPower("Available")*GetPowerUpRatio()
		if(prob(99))//Health/Energy Recovery
			Recover("Health",src.Regeneration)
			if(ControlPower<=100&&!Regenerate&&!Swim)
				Recover("Energy",src.Recovery)
			if(Regenerate)
				if(Energy<EnergyMax/10)
					src<<"You stop Regenerating."
					src.Regenerate=0
				if(Regenerate)
					Recover("Health",src.Regeneration*2)
					Energy-=EnergyMax/10
			if(Energy>(EnergyMax*1.1)&&!PowerUp) Energy*=0.995
			if(Health>110) Health*=0.995
		if(prob(75))//PC System
			if(src.PowerUp==1)
				src.ControlPower+=Recovery
				if(((src.Energy/src.EnergyMax)*100)<30)
					src.PowerUp=0
					src.Auraz("Remove")
					src<<"You are too tired to power up."
					src.PowerUp=0
			if(src.PowerDown&&!src.PowerUp&&ControlPower>0.01&&!KO)
				src.ControlPower=ControlPower*0.90
			//	Increase_Powerup()
			//	Increase_Powerup()
			//	Increase_Powerup()
			//Beyond 100% Drain
			if(!KO&&ControlPower>100)
				if(src.icon_state=="Meditate"&&src.ControlPower>100)
					src.ControlPower-=src.Recovery
					if(src.ControlPower<100)
						src.ControlPower=100
				if(((src.Energy/src.EnergyMax)*100)>=10) src.Energy-=(0.005*(src.ControlPower-100)*(src.ControlPower-100)*(1/src.Recovery))
				else
					src.Energy=1
					src.ControlPower=100
					src.PowerUp=0
					//if(Race=="Saiyan"|Race=="Half-Saiyan") Revert()
					src.Auraz("Remove")
					src<<"You are too tired to hold the energy you gathered, your energy levels return to normal."



mob/proc/Update_Stat_Labels()
	if(!src.ha)
		if(src)
			src<<output("Gravity: [round(Gravity)]x","GravityT")
			src<<output("Health: [round(Health)]%", "Health")
			src<<output("Energy: [round((Energy/EnergyMax)*100)]%","EnergyZ")

			winset(src, "HealthBar", "value=\"[round(Health)]\"")
			winset(src, "EnergyBar", "value=\"[round((Energy/EnergyMax)*100)]\"")

			var/blah=GetPowerUpRatio()*100
			if(blah!=100)
				winset(src, "PowerBar", "value=\"[round(((Body)*Energy/EnergyMax)*Health)*GetPowerUpRatio()]\"")
				if(blah<100)
					src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)*GetPowerUpRatio()]%(-[100-blah]%)","Power")
				else
					src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)*GetPowerUpRatio()]%(+[blah-100]%)","Power")
			else
				winset(src, "PowerBar", "value=\"[round(((Body)*Energy/EnergyMax)*Health)]\"")
				src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)]%","Power")
	else
		if(src)
			src<<output("Gravity: [round(Gravity)]x","BarGravity")
			src<<output("Health: [round(Health)]%", "BarHealth")
			src<<output("Energy: [round((Energy/EnergyMax)*100)]%","BarEnergy")
			var/blah=GetPowerUpRatio()*100
			if(blah!=100)
				if(blah<100)
					src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)*GetPowerUpRatio()]%(-[100-blah]%)","BarPower")
				else
					src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)*GetPowerUpRatio()]%(+[blah-100]%)","BarPower")
			else
				src<<output("Power: [round(((Body)*Energy/EnergyMax)*Health)]%","BarPower")






mob/var/tmp/ha

mob/verb/SwitchShit()
	set hidden=1
	usr.ha=1
	for(var/e in list("Health","Energy","Power","Gravity"))
		winset(src,"Bar[e]","is-visible=true")




mob/proc/Get_Sense_Reading(mob/A)
	var/One=Get_Scouter_Reading(A)
	var/Two=Get_Scouter_Reading(src)
	if(One<1)
		One=1
	if(Two<1)
		Two=1
	var/Power=100*(One/Two)
	if(A.KO) Power*=0.05
	Power=round(Power)
	if(Power>1000) Power=1000
	return Power
mob/proc/Get_Scouter_Reading(mob/B)
	var/Power=B.Power*B.Skill
	if(B.KO) Power*=0.05
	return round(Power)


mob/verb/Maximize_Button()
	set name=".Maximize_Button"
	set hidden=1
	if(winget(usr,"mainwindow","is-maximized")=="true") winset(src,"mainwindow","is-maximized=false")
	else winset(src,"mainwindow","is-maximized=true")