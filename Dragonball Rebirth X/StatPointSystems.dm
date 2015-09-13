mob/proc/ClassBodyStats()
	if(src.BodyType=="Small")
		StrengthMod*=0.7
		EnduranceMod*=0.7
		SpeedMod*=1.2
		ResistanceMod*=0.8
		OffenseMod*=1.2
		DefenseMod*=1.2
		Regeneration*=1.2
		Recovery*=1.2
	if(src.BodyType=="Large")
		StrengthMod*=2
		EnduranceMod*=3
		SpeedMod*=0.7
		ResistanceMod*=1.2
		OffenseMod*=0.7
		DefenseMod*=0.7
		Regeneration*=0.7
		Recovery*=0.7
	if(src.Class=="Wizard")
		EnergyMod*=2
		StrengthMod/=1.5
		EnduranceMod/=1.2
		SpeedMod*=1.5
		ForceMod*=1.35
		ResistanceMod*=1.1
		OffenseMod/=1.5
		DefenseMod/=1.7
		Regeneration/=1.5
		Recovery*=1.35
	if(src.Class=="Healer")
		EnergyMod*=1.5
		StrengthMod/=1.25
		EnduranceMod/=1.1
		//SpeedMod/=1.5
		ForceMod*=1.1
		ResistanceMod*=1.3
		OffenseMod/=1.25
		DefenseMod/=1.1
		Regeneration*=1.1
		Recovery*=1.1
	if(src.Class=="Technologist")
		//Intelligence*=2
		StrengthMod/=2
		EnduranceMod/=1.5
		ForceMod/=1.5
		ResistanceMod/=1.25
		OffenseMod/=1.5
		DefenseMod/=1.5
		Regeneration/=1.25
		Recovery/=1.25
		EnergyMod/=1.5



mob/proc/Stats(var/blah)
	if(blah=="Human")//done
		IncrementStat("Energy",0.5)
		IncrementStat("Speed",1.5)
		IncrementStat("Offense",1.2)
		IncrementStat("Defense",1.2)
		IncrementStat("Regeneration",0.6)
		IncrementStat("Recovery",1)
		IncrementStat("Anger",0.5)
	else if(blah=="Spirit Doll")//done
		IncrementStat("Energy",2)
		IncrementStat("Speed",2)
		IncrementStat("Force",1)
		IncrementStat("Resistance",1)
		IncrementStat("Offense",0.8)
		IncrementStat("Defense",0.8)
		IncrementStat("Regeneration",1)
		IncrementStat("Recovery",2)
		IncrementStat("Anger",0.15)
	else if(blah=="Namekian")//Done
		IncrementStat("Energy",2)
		IncrementStat("Strength",0.2)
		IncrementStat("Endurance",0.5)
		IncrementStat("Speed",1)
		IncrementStat("Force",1)
		IncrementStat("Resistance",1)
		IncrementStat("Offense",0.8)
		IncrementStat("Defense",1.5)
		IncrementStat("Regeneration",2)
		IncrementStat("Recovery",0.5)
		IncrementStat("Anger",0.1)

	//Rares
	else if(blah=="Majin")//Done
		IncrementStat("Energy",1)
		IncrementStat("Speed",1.5)
		IncrementStat("Resistance",-0.2)
		IncrementStat("Offense",1)
		IncrementStat("Defense",-0.8)
		IncrementStat("Regeneration",5)
		IncrementStat("Recovery",4)
		//IncrementStat("Anger",0)
	else if(blah=="Bio Android")//Done
		IncrementStat("Energy",2)
		IncrementStat("Strength",2)
		IncrementStat("Endurance",2)
		IncrementStat("Speed",2)
		IncrementStat("Resistance",1.5)
		IncrementStat("Offense",2)
		IncrementStat("Defense",1)
		IncrementStat("Regeneration",4)
		IncrementStat("Recovery",2)
		IncrementStat("Anger",0.5)
	else if(blah=="Dragon")//Done
		IncrementStat("Energy",2)
		IncrementStat("Strength",1)
		IncrementStat("Endurance",2)
		IncrementStat("Speed",1.2)
		IncrementStat("Force",1)
		IncrementStat("Resistance",2)
		IncrementStat("Offense",1)
		IncrementStat("Defense",1)
		IncrementStat("Regeneration",2)
		IncrementStat("Recovery",2)
		IncrementStat("Anger",1)
	////////////


	else if(blah=="Saiyan")
		if(Class=="Elite")
			IncrementStat("Energy",1)
			IncrementStat("Strength",3)
			IncrementStat("Endurance",1)
			IncrementStat("Speed",1.4)
			IncrementStat("Force",2)
			IncrementStat("Resistance",1)
			IncrementStat("Offense",0.8)
			IncrementStat("Defense",0.2)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",0.5)
		if(Class=="Normal")
			IncrementStat("Energy",0.5)
			IncrementStat("Strength",1.5)
			IncrementStat("Endurance",1.5)
			IncrementStat("Speed",0.3)
			IncrementStat("Force",1)
			IncrementStat("Resistance",1)
			IncrementStat("Offense",0.5)
			IncrementStat("Defense",0.5)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",0.75)
		if(Class=="Low-Class")
			IncrementStat("Energy",0.5)
			IncrementStat("Strength",1)
			IncrementStat("Endurance",2.5)
			IncrementStat("Speed",0.5)
			IncrementStat("Force",0.2)
			IncrementStat("Resistance",2.5)
			IncrementStat("Offense",0.5)
			IncrementStat("Defense",1)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",1)
		if(Class=="Legendary")
			IncrementStat("Energy",1)
			IncrementStat("Strength",3)
			IncrementStat("Endurance",2)
			IncrementStat("Speed",1)
			IncrementStat("Force",2)
			IncrementStat("Resistance",3)
			IncrementStat("Offense",0.8)
			IncrementStat("Defense",-0.2)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",0.5)
	else if(blah=="Half Saiyan")
		if(Class=="Trunks")
			IncrementStat("Energy",0.5)
			IncrementStat("Strength",2)
			IncrementStat("Endurance",1)
			IncrementStat("Speed",1)
			IncrementStat("Force",1.5)
			IncrementStat("Resistance",1)
			IncrementStat("Offense",0.8)
			IncrementStat("Defense",1)
			IncrementStat("Regeneration",0.5)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",0.5)
		if(Class=="Goten")
			IncrementStat("Energy",0.5)
			IncrementStat("Strength",1.5)
			IncrementStat("Endurance",1.5)
			IncrementStat("Speed",1.2)
			IncrementStat("Force",0.3)
			IncrementStat("Resistance",1.3)
			IncrementStat("Offense",0.8)
			IncrementStat("Defense",0.8)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",2)
			IncrementStat("Anger",0.75)
		if(Class=="Gohan")
			IncrementStat("Energy",0.5)
			IncrementStat("Strength",1.5)
			IncrementStat("Endurance",2.5)
			IncrementStat("Speed",1.8)
			IncrementStat("Force",1.8)
			IncrementStat("Resistance",2)
			IncrementStat("Offense",2)
			IncrementStat("Defense",2)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",2.2)
			IncrementStat("Anger",2.5)
		if(Class=="Hellspawn")
			IncrementStat("Energy",1)
			IncrementStat("Strength",2)
			IncrementStat("Endurance",1)
			IncrementStat("Speed",0.5)
			IncrementStat("Force",0.5)
			IncrementStat("Resistance",0.5)
			IncrementStat("Offense",0.8)
			IncrementStat("Defense",0.5)
			IncrementStat("Regeneration",1)
			IncrementStat("Recovery",1)
			IncrementStat("Anger",1)
	else if(blah=="Changling")//Done
		IncrementStat("Endurance",4)
		IncrementStat("Strength",3)
		IncrementStat("Speed",1.5)
		IncrementStat("Force",1.5)
		IncrementStat("Resistance",4)
		IncrementStat("Offense",1.5)
		IncrementStat("Defense",-0.2)
		IncrementStat("Recovery",2.25)
		IncrementStat("Anger",0.5)
	else if(blah=="Demon")//Done
		IncrementStat("Energy",1)
		IncrementStat("Strength",2)
		IncrementStat("Endurance",1)
		IncrementStat("Speed",0.5)
		IncrementStat("Force",1)
		IncrementStat("Offense",0.5)
		IncrementStat("Regeneration",2)
		IncrementStat("Recovery",1.575)
		IncrementStat("Anger",0.5)
	else if(blah=="Half Demon")
		IncrementStat("Energy",1.5)
		IncrementStat("Strength",1)
		IncrementStat("Endurance",1)
		IncrementStat("Speed",0.8)
		IncrementStat("Force",1.5)
		IncrementStat("Resistance",0.5)
		IncrementStat("Offense",2)
		IncrementStat("Defense",1.5)
		IncrementStat("Regeneration",1.8)
		IncrementStat("Recovery",1.85)
		IncrementStat("Anger",1.5)
	else if(blah=="Kaio")
		IncrementStat("Energy",2)
		IncrementStat("Strength",-0.2)
		IncrementStat("Endurance",2)
		IncrementStat("Speed",1)
		IncrementStat("Force",0.8)
		IncrementStat("Resistance",1)
		IncrementStat("Defense",2)
		IncrementStat("Regeneration",0.5)
		IncrementStat("Recovery",2)
		IncrementStat("Anger",0.2)
	else if(blah=="Makyo")
		IncrementStat("Energy",1.5)
		IncrementStat("Sterngth",1)
		IncrementStat("Endurance",2)
		IncrementStat("Speed",0.5)
		IncrementStat("Resistance",2)
		IncrementStat("Offense",0.5)
		IncrementStat("Regeneration",0.5)
		IncrementStat("Anger",0.5)
	else if(blah=="Demi")
		IncrementStat("Energy",0.5)
		IncrementStat("Strength",2)
		IncrementStat("Endurance",1)
		IncrementStat("Speed",0.5)
		IncrementStat("Resistance",1)
		IncrementStat("Offense",0.2)
		IncrementStat("Defense",1)
		IncrementStat("Regeneration",1)
		IncrementStat("Recovery",0.5)
		IncrementStat("Anger",0.5)
	else if(blah=="Tsufurujin")
		IncrementStat("Energy",0.5)
		IncrementStat("Speed",1)
		IncrementStat("Force",0.8)
		IncrementStat("Resistance",0.5)
		IncrementStat("Offense",1.2)
		IncrementStat("Defense",1.2)
		IncrementStat("Regeneration",1)
		IncrementStat("Recovery",1)
		IncrementStat("Anger",0.5)
	//else if(blah=="Alien")
	//	SetStatPoints(90)
	//else
	//	SetStatPoints(10)








mob/proc/RacialStats(var/blah)
	for(var/obj/SavedStats/Z in src)
		del(Z)
	src.ResetStats()
	src.contents+=new/obj/SavedStats
	if(!length(GenRaces)||usr.Race=="Half Saiyan")
		Stats("[usr.Race]")
		if(Race=="Alien"||Race=="Android")
			if(src.Class=="Lycan")
				IncrementStat("Endurance",1)
				IncrementStat("Strength",2)
				IncrementStat("Speed",1)
				IncrementStat("Force",-0.9)
				IncrementStat("Resistance",2)
				IncrementStat("Offense",1)
				IncrementStat("Defense",0.5)
				IncrementStat("Regeneration",1.5)
				IncrementStat("Recovery",1)
				IncrementStat("Anger",0.5)
				SetStatPoints(10)

			else if(src.Class=="Vampire")
				IncrementStat("Endurance",-0.2)
				IncrementStat("Strength",2)
				IncrementStat("Speed",2)
				IncrementStat("Force",2)
				IncrementStat("Resistance",-0.2)
				IncrementStat("Offense",1)
				IncrementStat("Defense",1)
				IncrementStat("Regeneration",1.5)
				IncrementStat("Recovery",1)
				IncrementStat("Anger",0.5)
				SetStatPoints(10)
			else
				SetStatPoints(70)
		else
			SetStatPoints(10)
	else
		var/numba=0
		for(var/Q in src.GenRaces)
			if(numba==0)
				src.Stats("[Q]")
			else
				var/mob/M=new
				M.Stats("[Q]")
				src.EnergyMod+=M.EnergyMod
				src.StrengthMod+=M.StrengthMod
				src.EnduranceMod+=M.EnduranceMod
				src.SpeedMod+=M.SpeedMod
				src.ForceMod+=M.ForceMod
				src.ResistanceMod+=M.ResistanceMod
				src.OffenseMod+=M.OffenseMod
				src.DefenseMod+=M.DefenseMod
				src.Regeneration+=M.Regeneration
				src.Recovery+=M.Recovery
				src.AngerMax+=M.AngerMax
				del(M)
			numba++
		src.EnergyMod/=numba
		src.StrengthMod/=numba
		src.EnduranceMod/=numba
		src.SpeedMod/=numba
		src.ForceMod/=numba
		src.ResistanceMod/=numba
		src.OffenseMod/=numba
		src.DefenseMod/=numba
		src.Regeneration/=numba
		src.Recovery/=numba
		src.AngerMax/=numba
		SetStatPoints(10)
	src.ClassBodyStats()
	src.GetIncrements()
	//if(client)PerkDisplay()
	//if(client)Show_Stat_Menu()




mob/var/RewardPoints=0
mob/verb/RewardPoints(type as text)
	set name=".StatReward"
	set hidden=1
	if(type in list("Strength","Endurance","Energy","Resistance","Force","Speed","Offense","Defense"))
		if(RewardPoints>0)
			RewardPoints--
			if(type=="Energy")
				src.vars["EnergyMax"]+=src.vars["EnergyMod"]
			else
				src.vars[type]+=src.vars["[type]Mod"]/(100/src.GetPowerRank(1))
		winset(src,"RewardPoints","text=[RewardPoints]")





mob/verb/Skill_Points(type as text,skill as text)
	set name=".Skill_Points"
	set hidden=1
	var/Increase=1
	if(type=="-")
		if(Points==Max_Points) return //You cant subtract any more points if points are full
		Increase=-1
	if(type=="+")
		Increase=1
		if(Points==0) return //You cant add any more points if you had none left
	if(locate(/obj/SavedStats) in usr)
		for(var/obj/SavedStats/Z in src.contents)
			var/EnergyMin=Z.EnergyModGain*10
			var/StrengthMin=Z.StrengthModGain*10
			var/EnduranceMin=Z.EnduranceModGain*10
			var/SpeedMin=Z.SpeedModGain*10
			var/ForceMin=Z.ForceModGain*10
			var/ResistanceMin=Z.ResistanceModGain*10
			var/OffenseMin=Z.OffenseModGain*10
			var/DefenseMin=Z.DefenseModGain*10
			var/RegenerationMin=Z.RegenerationGain*10
			var/RecoveryMin=Z.RecoveryGain*10
			var/AngerMin=Z.AngerGain*20
			switch(skill)
				if("Energy")
					if(type=="-")if(EnergyMod<=EnergyMin)return
					IncrementStat("Energy",Increase)
					winset(src,"[skill]","text=[EnergyMod]")
				if("Strength")
					if(type=="-") if(StrengthMod<=StrengthMin)return
					IncrementStat("Strength",Increase)
					winset(src,"[skill]","text=[StrengthMod]")
				if("Endurance")
					if(type=="-") if(EnduranceMod<=EnduranceMin)return
					IncrementStat("Endurance",Increase)
					winset(src,"[skill]","text=[EnduranceMod]")
				if("Speed")
					if(type=="-") if(SpeedMod<=SpeedMin)return
					IncrementStat("Speed",Increase)
					winset(src,"[skill]","text=[SpeedMod]")
				if("Force")
					if(type=="-") if(ForceMod<=ForceMin)return
					IncrementStat("Force",Increase)
					winset(src,"[skill]","text=[ForceMod]")
				if("Resistance")
					if(type=="-") if(ResistanceMod<=ResistanceMin)return
					IncrementStat("Resistance",Increase)
					winset(src,"[skill]","text=[ResistanceMod]")
				if("Offense")
					if(type=="-") if(OffenseMod<=OffenseMin)return
					IncrementStat("Offense",Increase)
					winset(src,"[skill]","text=[OffenseMod]")
				if("Defense")
					if(type=="-") if(DefenseMod<=DefenseMin)return
					IncrementStat("Defense",Increase)
					winset(src,"[skill]","text=[DefenseMod]")
				if("Regeneration")
					if(type=="-") if(Regeneration<=RegenerationMin)return
					IncrementStat("Regeneration",Increase)
					winset(src,"[skill]","text=[Regeneration]")
				if("Recovery")
					if(type=="-") if(Recovery<=RecoveryMin)return
					IncrementStat("Recovery",Increase)
					winset(src,"[skill]","text=[Recovery]")
				if("Anger")
					if(type=="-") if(AngerMax<=AngerMin)return
					IncrementStat("Anger",Increase)
					winset(src,"[skill]","text=[AngerMax*100]%")
			Points-=Increase
			winset(src,"Points Remaining","text=[Points]")
/*
obj/Redo_Stats
	var/Last_Redo=0
	verb/Redo_Stats()
		set category="Other"
		if(usr.Redoing_Stats) return
		if(Last_Redo+5>Year)
			usr<<"You can not do this til year [Last_Redo+5]"
			return
		usr.Redo_Stats()
		Last_Redo=Year
mob/proc/Redo_Stats()
	set category="Other"
	Redoing_Stats=1
	ResetStats()
	RacialStats()
	while(winget(src,"skills","is-visible")=="true") sleep(1)
	Redoing_Stats=0



*/

mob/proc/ResetStats()
	StrengthMod=1
	EnduranceMod=1
	ForceMod=1
	ResistanceMod=1
	SpeedMod=1
	EnergyMod=1
	OffenseMod=1
	DefenseMod=1
	Regeneration=1
	Recovery=1
	AngerMax=1

mob/proc/PerkDisplay()
	winset(src,"Points Remaining","text=[Points]")
	winset(src,"Race BP","text=\"[BaseMod]x Battle Power\"")
	winset(src,"TrainingRate","text=\"[Training_Rate]x Training\"")
	winset(src,"MeditationRate","text=\"[Meditation_Rate]x Meditation\"")
	winset(src,"ZenkaiRate","text=\"[Zenkai_Rate]x Zenkai\"")
	winset(src,"TechRate","text=\"[src.Intelligence]x Intelligence\"")
	winset(src,"Energy","text=[EnergyMod]")
	winset(src,"Strength","text=[StrengthMod]")
	winset(src,"Endurance","text=[EnduranceMod]")
	winset(src,"Speed","text=[SpeedMod]")
	winset(src,"Force","text=[ForceMod]")
	winset(src,"Resistance","text=[ResistanceMod]")
	winset(src,"Offense","text=[OffenseMod]")
	winset(src,"Defense","text=[DefenseMod]")
	winset(src,"Regeneration","text=[Regeneration]")
	winset(src,"Recovery","text=[Recovery]")
	winset(src,"Anger","text=[AngerMax*100]%")

mob/proc/SetStatPoints(Amount=0)
	src.Points=Amount//+=
	src.Max_Points=Amount//+=


mob/proc/GetIncrements()
	for(var/obj/SavedStats/Z in src.contents)
		Z.EnergyModGain=EnergyMod/10
		Z.SpeedModGain=SpeedMod/10
		Z.StrengthModGain=StrengthMod/10
		Z.EnduranceModGain=EnduranceMod/10
		Z.ForceModGain=ForceMod/10
		Z.ResistanceModGain=ResistanceMod/10
		Z.OffenseModGain=OffenseMod/10
		Z.DefenseModGain=DefenseMod/10
		Z.RegenerationGain=Regeneration/10
		Z.RecoveryGain=Recovery/10
		Z.AngerGain=AngerMax/20

mob/proc/Show_Stat_Menu()
	PerkDisplay()
	winshow(src,"skills",1)
mob/var/tmp/Redoing_Stats
mob/var/tmp/Points=0
mob/var/tmp/Max_Points=10

obj/SavedStats
	var
		EnergyModGain=1
		SpeedModGain=1
		StrengthModGain=1
		EnduranceModGain=1
		ForceModGain=1
		ResistanceModGain=1
		OffenseModGain=1
		DefenseModGain=1
		RegenerationGain=1
		RecoveryGain=1
		AngerGain=1


mob/proc/IncrementStat(Stat,Amount=1)
	for(var/obj/SavedStats/Z in src.contents)
		if(Stat=="Energy")
			EnergyMod+=Z.EnergyModGain*Amount
		if(Stat=="Speed")
			SpeedMod+=Z.SpeedModGain*Amount
		if(Stat=="Strength")
			StrengthMod+=Z.StrengthModGain*Amount
		if(Stat=="Endurance")
			EnduranceMod+=Z.EnduranceModGain*Amount
		if(Stat=="Force")
			ForceMod+=Z.ForceModGain*Amount
		if(Stat=="Resistance")
			ResistanceMod+=Z.ResistanceModGain*Amount
		if(Stat=="Offense")
			OffenseMod+=Z.OffenseModGain*Amount
		if(Stat=="Defense")
			DefenseMod+=Z.DefenseModGain*Amount
		if(Stat=="Regeneration")
			Regeneration+=Z.RegenerationGain*Amount
		if(Stat=="Recovery")
			Recovery+=Z.RecoveryGain*Amount
		if(Stat=="Anger")
			AngerMax+=Z.AngerGain*Amount
		return
	if(Stat=="Energy")
		EnergyMod+=Amount
	if(Stat=="Speed")
		SpeedMod+=Amount
	if(Stat=="Strength")
		StrengthMod+=Amount
	if(Stat=="Endurance")
		EnduranceMod+=Amount
	if(Stat=="Force")
		ForceMod+=Amount
	if(Stat=="Resistance")
		ResistanceMod+=Amount
	if(Stat=="Offense")
		OffenseMod+=Amount
	if(Stat=="Defense")
		DefenseMod+=Amount
	if(Stat=="Regeneration")
		Regeneration+=Amount
	if(Stat=="Recovery")
		Recovery+=Amount


mob/verb/Skill_Points_Done()
	set name=".Skill_Points_Done"
	set hidden=1
	if(Points) src<<"You still have points!"
	else
		winshow(src,"Finalize_Screen",0)
		for(var/obj/SavedStats/Z in usr.contents)
			del(Z)
		if(!usr.Savable)
			usr.NewMob()