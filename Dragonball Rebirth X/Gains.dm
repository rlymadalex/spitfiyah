mob/proc/LOLWUT()
	if(src.Base>=(BaseMod*37500)&&BaseMod<50)
		if(Race=="Human")
			BaseMod*=220
		else if(Race=="Spirit Doll")
			BaseMod*=220
		else if(Race=="Android")
			BaseMod*=100
		else if(Race=="Majin")
			BaseMod*=100
		else if(Race=="Makyo")
			BaseMod*=150
		else if(Race=="Saiyan"||Race=="Half Saiyan")
			BaseMod*=50
		else if(Race=="Tsufurujin")
			BaseMod*=220
		else if(Race=="Namekian")
			BaseMod*=130
		else if(Race=="Changling")
			BaseMod*=200
		else if(Race=="Demi")
			BaseMod*=50
		else if(Race=="Demon"||Race=="Half Demon")
			BaseMod*=100
		else if(Race=="Kaio")
			BaseMod*=100
		else if(Race=="Alien")
			BaseMod*=150
		else
			BaseMod*=50
	if(src.Age>=src.PrimeAge)//Mate
		if(!(src.Race in list("Android","Bio Android","Dragon","Majin")))
			if(!locate(/obj/Child/Mate,src.contents))
				src.contents+=new/obj/Child/Mate
				src<<"You can have babies now!"
	if(src.Race=="Human")//Third Eye
		if(src.ThirdEyeReq)
			if(src.Base>=ThirdEyeReq/20)
				if(!locate(/obj/Skills/Buffs/ThirdEye,src.contents))
					src.contents+=new/obj/Skills/Buffs/ThirdEye
					src<<"You unlocked the ability to use the legendary Third Eye technique!"
	if(src.IntelligenceLevel>=30)
		if(!locate(/obj/Cyberize,src.contents))
			src.contents+=new/obj/Cyberize
			src<<"You learned how to cyber...ize..others!"

	if(src.Race in list("Demi","Makyo"))//Expand
		if(src.EnergyMax>5000)
			if(!locate(/obj/Skills/Buffs/Expand,src.contents))
				src.contents+=new/obj/Skills/Buffs/Expand
				src<<"<i>Due to your immense energy...you learn Expand on your own.</i>"

	if(src.Race=="Saiyan")//False Moon
		if(src.Special==5)
			if(src.EnergyMax>5000)
				if(!locate(/obj/Skills/FalseMoon,src.contents))
					src.contents+=new/obj/Skills/FalseMoon

	if(src.Race in list("Human","Namekian"))//Focus
		if(src.EnergyMax>5000)
			if(!locate(/obj/Skills/Buffs/Focus,src.contents))
				src.contents+=new/obj/Skills/Buffs/Focus
				src<<"<i>Due to your immense energy...you learn Focus on your own.</i>"

	if(src.Race =="Namekian")//Namekian Fusino
		if(src.EnergyMax>3000)
			if(!locate(/obj/Skills/NamekianFusion,src.contents))
				src.contents+=new/obj/Skills/NamekianFusion
				src<<"<i>Due to your immense energy you learn the legendary Namekian ritual.</i>"

	if(src.Race=="Demon")//DemonicWill
		if(src.EnergyMax>5000)
			if(!locate(/obj/Skills/Buffs/DemonicWill,src.contents))
				src.contents+=new/obj/Skills/Buffs/DemonicWill
				src<<"<i>Your demonic nature has fully manifested.</i>"

	if(src.Race=="Kaio")//DivineBlessing
		if(src.EnergyMax>15000)
			if(!locate(/obj/Skills/Buffs/DivineBlessing,src.contents))
				src.contents+=new/obj/Skills/Buffs/DivineBlessing
				src<<"<i>The Blessing of the gods descend upon you...</i>"

	if(src.EnergyMax>1000)
		if(!locate(/obj/Skills/Attacks/Blast,src.contents))
			src.contents+=new/obj/Skills/Attacks/Blast
			src<<"<i>Due to your immense energy...you learn Blast on your own.</i>"
		if(src.EnergyMax>1500)
			if(!locate(/obj/Skills/Attacks/Beams/Beam,src.contents))
				src.contents+=new/obj/Skills/Attacks/Beams/Beam
				src<<"<i>Due to your immense energy...you learn Beam on your own.</i>"
			if(src.EnergyMax>2000)
				if(!locate(/obj/Skills/Fly,src.contents))
					src.contents+=new/obj/Skills/Fly
					src<<"<i>Due to your immense energy...you learn Fly on your own.</i>"
				if(src.EnergyMax>2500)
					if(!locate(/obj/Skills/Attacks/Charge,src.contents))
						src.contents+=new/obj/Skills/Attacks/Charge
						src<<"<i>Due to your immense energy...you learn Charge on your own.</i>"
					if(src.EnergyMax>3500)
						if(src.Race in list("Namekian","Spirit Doll","Demon","Human","Alien"))
							if(!locate(/obj/Skills/Telepathy,src.contents))
								src.contents+=new/obj/Skills/Telepathy
								src<<"<i>Due to your immense energy...you learn how to communicate with others Telepathically.</i>"
						if(src.EnergyMax>10000)
							if(!locate(/obj/Skills/PowerControl,src.contents))
								src.contents+=new/obj/Skills/PowerControl
								src<<"<i>Due to your immense energy...you learn how to fluxate your power on your own.</i>"
							if(src.EnergyMax>15000)
								if(!locate(/obj/Skills/Rank/Zanzoken,src.contents))
									src.contents+=new/obj/Skills/Rank/Zanzoken
									src<<"<i>Due to your immense energy...you learn how to accelerate matter into high velocities.</i>"


mob/proc/Melee_Gain(Amount)
	if(prob(50/sqrt(src.SpeedMod)))
		Base+=0.04*sqrt(sqrt(Gravity))*GetPowerRank(2)*(Gains/100)*BaseMod*Training_Rate*WeightFormula(1)*EXP/1000*Amount/2
		EnergyMax+=0.008*EnergyMod*Amount*EnergyGains
		EXP+=(EXPGains/100)*0.0015
		src.Decline+=0.000004*Training_Rate*(DeclineGains/100)
		if(prob(80)) Speed+=0.052*SpeedMod*GetPowerRank(1)*(StatGains/100)*Amount
		if(StrFocus=="Balanced")
			if(prob(60))
				if(prob(90))Strength+=0.048*StrengthMod*GetPowerRank(1)*(StatGains/100)*Amount
				Endurance+=0.048*EnduranceMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(StrFocus=="Strength") if(prob(60)) Strength+=0.096*StrengthMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(StrFocus=="Endurance") if(prob(60)) Endurance+=0.096*EnduranceMod*GetPowerRank(1)*(StatGains/100)*Amount
		if(ForFocus=="Balanced")
			if(prob(60))
				if(prob(90))Force+=0.04*ForceMod*GetPowerRank(1)*(StatGains/100)*Amount
				Resistance+=0.04*ResistanceMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(ForFocus=="Force") if(prob(60)) Force+=0.08*ForceMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(ForFocus=="Resistance") if(prob(60))Resistance+=0.08*ResistanceMod*GetPowerRank(1)*(StatGains/100)*Amount
		if(OffFocus=="Balanced")
			if(prob(65))
				if(prob(90))Offense+=0.1*OffenseMod*GetPowerRank(1)*(StatGains/100)*Amount
				Defense+=0.1*DefenseMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(OffFocus=="Offense") if(prob(65)) Offense+=0.2*OffenseMod*GetPowerRank(1)*(StatGains/100)*Amount
		else if(OffFocus=="Defense") if(prob(65)) Defense+=0.2*DefenseMod*GetPowerRank(1)*(StatGains/100)*Amount




mob/proc
	GetPowerRank(var/Rank)
		var/PeopleOnline=0
		for(var/mob/K) if(K.client)
			PeopleOnline+=1
		if(Rank==1)
			var/StrongerStats=1
			var/YourStats=(Strength/StrengthMod)+(Endurance/EnduranceMod)+(Speed/SpeedMod)+(Resistance/ResistanceMod)+(Force/ForceMod)+(Offense/OffenseMod)+(Defense/DefenseMod)
			for(var/mob/A) if(A.client)
				var/TheirStats=(A.Strength/A.StrengthMod)+(A.Endurance/A.EnduranceMod)+(A.Speed/A.SpeedMod)+(A.Resistance/A.ResistanceMod)+(A.Force/A.ForceMod)+(A.Offense/A.OffenseMod)+(A.Defense/A.DefenseMod)
				if(TheirStats>YourStats) StrongerStats+=1
			return round(100/PeopleOnline*StrongerStats)
		if(Rank==2)
			var/StrongerBPs=1
			for(var/mob/A) if(A.client)
				if(A.Base/A.BaseMod>Base/BaseMod) StrongerBPs+=1
			return round(100/PeopleOnline*StrongerBPs)



mob/Players/verb
	StatFocus()
		set category="Other"
		var/Choice=alert(usr,"Choose Option","","Strength","Balanced","Endurance")
		switch(Choice)
			if("Strength") usr.StrFocus="Strength"
			if("Endurance") usr.StrFocus="Endurance"
			if("Balanced") usr.StrFocus="Balanced"
		var/Choice2=alert(usr,"Choose Option","","Force","Balanced","Resistance")
		switch(Choice2)
			if("Force") usr.ForFocus="Force"
			if("Resistance") usr.ForFocus="Resistance"
			if("Balanced") usr.ForFocus="Balanced"
		var/Choice3=alert(usr,"Choose Option","","Offense","Balanced","Defense")
		switch(Choice3)
			if("Offense") usr.OffFocus="Offense"
			if("Defense") usr.OffFocus="Defense"
			if("Balanced") usr.OffFocus="Balanced"
		var/Choice4=alert(usr,"Focus on Intelligence?","","No","Yes")
		switch(Choice4)
			if("No") usr.IntFocus=0
			if("Yes") usr.IntFocus=1
mob/proc/IntGain()
	src.IntelligenceEXP+=rand(10,100)*(IntRate/100)
	if(src.IntelligenceEXP>IntelligenceEXPNeeded)
		src.IntelligenceEXP-=IntelligenceEXPNeeded
		src.IntelligenceLevel+=1
		src.IntelligenceEXPNeeded=(1000*sqrt(IntelligenceLevel)*IntelligenceLevel)/Intelligence




mob/proc/RemoveWaterOverlay()
	var/list/meh=list("1","2","3","4","5","6","7","8","9","10","11","12","waterfall")
	for(var/x in meh)
		src.overlays-=image('WaterOverlay.dmi',"[x]")

mob/proc/GainLoop()
	set background=1
	while(src)
		sleep(10)
		spawn()if(client)Update_Stat_Labels()
		if(src.KO)
			if(prob(50))
				if(ZenkaiAmount<(Base-ZenkaiAmount)*(((sqrt(Zenkai_Rate)*2)/5)))
					var/Gain=0.05*sqrt(sqrt(Gravity))*GetPowerRank(2)*(Gains/100)*BaseMod*Zenkai_Rate*WeightFormula(1)*(EXP/1000)/(2*Regeneration)
					Base+=Gain
					ZenkaiAmount+=Gain
		if(prob(15))
			Base+=0.04*sqrt(sqrt(Gravity))*GetPowerRank(2)*(Gains/100)*BaseMod*Training_Rate*Meditation_Rate*WeightFormula(1)*EXP/1000*0.0025/2
			EnergyMax+=0.008*EnergyMod*0.0025*Meditation_Rate*Training_Rate*EnergyGains
			EXP+=(EXPGains/100)*0.00025
			src.Decline+=0.000004*Training_Rate*Meditation_Rate*(DeclineGains/100)
		if(src.Digging)

			var/amounttaken=src.EnergyMax/(10*src.Skillz["Dig"]["Level"])
			if(src.Energy>amounttaken)
				src.Energy-=amounttaken
				src.SkillUP("Dig",0.1)
				var/Multi=1
				for(var/obj/Money/M in src)
					for(var/obj/Items/Tech/EnhanceDigger/E in src)
						if(E.suffix)
							Multi=E.DigMulti
							break
					M.Level+=rand(10,20)*Multi*rand(1,3)
			else
				src.icon_state=""
				src.Digging=0
				src.Frozen=0
		//if(prob(66))
		var/gravityy
		for(var/turf/Q in view(0))
			if(Q.Gravity)
				gravityy=Q.Gravity
				//break
			if(!Flying)
				if(istype(Q,/turf/Waters))
					if(Swim==0)

						src.RemoveWaterOverlay()
						spawn()src.overlays+=image('WaterOverlay.dmi',"[Q.icon_state]")
					Swim=1
					if(!src.KO)
						var/amounttaken=src.EnergyMax/(10*src.Skillz["Swim"]["Level"])
						if(src.Energy>amounttaken)
							src.Energy-=amounttaken
							src.SkillUP("Swim",0.1)
						else
							src.Unconscious(null,"fatigue due to swimming! They will drown if not rescued!")
							src.Health=99
					else
						if(prob(50))Health-=rand(1,5)
						if(Health<1)
							if(prob(50))src.Death(null,"drowning!")
				else
					if(Swim==1)
						src.RemoveWaterOverlay()
					Swim=0
			else
				if(Swim==1)
					src.RemoveWaterOverlay()
					Swim=0
		if(gravityy)src.Gravity=gravityy
		else src.Gravity=GetPlanetGravity(src.z)
		if(src.Gravity>src.GravityMastered)
			src.GravityMastered+=src.GravityMod*sqrt(src.Gravity)*0.0001
			src.EXP+=(EXPGains/100)*0.005
			src.Health-=(src.Gravity/src.GravityMastered)*2


		if(icon_state=="Meditate")
			src.Decline+=0.0000004*Meditation_Rate*(DeclineGains/100)
			Base+=0.04*sqrt(sqrt(Gravity))*GetPowerRank(2)*(Gains/100)*BaseMod*Meditation_Rate*WeightFormula(1)*EXP/1000*0.01/2
			EnergyMax+=0.008*EnergyMod*0.01*Meditation_Rate*EnergyGains
			EXP+=(EXPGains/100)*0.0005
			if(prob(75))src.LOLWUT()
			Recover("Health",Meditation_Rate)
			if(ControlPower<=100&&!Regenerate&&!Swim)
				Recover("Energy",Meditation_Rate)


			if(IntFocus==1)
				if(prob(35))IntGain()
			else
				if(ForFocus=="Balanced")
					if(prob(10))
						Force+=0.004*ForceMod*GetPowerRank(1)*(StatGains/100)
						Resistance+=0.004*ResistanceMod*GetPowerRank(1)*(StatGains/100)
					if(prob(10)) Speed+=0.004*SpeedMod*GetPowerRank(1)*(StatGains/100)
				else if(ForFocus=="Force")
					if(prob(10)) Force+=0.008*ForceMod*GetPowerRank(1)*(StatGains/100)
					if(prob(10)) Speed+=0.004*SpeedMod*GetPowerRank(1)*(StatGains/100)
				else if(ForFocus=="Resistance")
					if(prob(10)) Resistance+=0.008*ResistanceMod*GetPowerRank(1)*(StatGains/100)
					if(prob(10)) Speed+=0.004*SpeedMod*GetPowerRank(1)*(StatGains/100)
		if(icon_state=="Train")
			src.Decline+=0.0000004*Training_Rate*(DeclineGains/100)
			EXP+=(EXPGains/100)*0.0007
			Base+=0.04*sqrt(sqrt(Gravity))*GetPowerRank(2)*(Gains/100)*BaseMod*Training_Rate*WeightFormula(1)*EXP/1000*0.01/2
			EnergyMax+=0.008*EnergyMod*0.01*Training_Rate*EnergyGains
			if(StrFocus=="Balanced")
				if(prob(10))
					Strength+=0.008*StrengthMod*GetPowerRank(1)*(StatGains/100)
					Endurance+=0.008*EnduranceMod*GetPowerRank(1)*(StatGains/100)
				if(prob(10))Speed+=0.002*SpeedMod*GetPowerRank(1)*(StatGains/100)
			else if(StrFocus=="Strength")
				if(prob(10)) Strength+=0.016*StrengthMod*GetPowerRank(1)*(StatGains/100)
				if(prob(10)) Speed+=0.002*SpeedMod*GetPowerRank(1)*(StatGains/100)
			else if(StrFocus=="Endurance")
				if(prob(10)) Endurance+=0.016*EnduranceMod*GetPowerRank(1)*(StatGains/100)
				if(prob(10)) Speed+=0.002*SpeedMod*GetPowerRank(1)*(StatGains/100)
			if(prob(80))
				src.Energy-=5*sqrt(sqrt(EnergyMax))/10
				if(src.Energy<5)
					src<<"You stop training due to the lack of energy."
					src.icon_state=""
		if(Flying)
			if(prob(75))
				EXP+=(EXPGains/100)*0.0002
				Energy-=EnergyMax/(FlySkillMod*10+(FlySkill/100))
				EnergyMax+=0.001*EnergyMod*EnergyGains
			src.FlySkill+=src.FlySkillMod
			if(Energy<=0)
				Flying=0
				icon_state=""
				src<<"You stop flying due to lack of energy."
		if(prob(60))
			if(src.Race=="Makyo"||src.Race=="Demon"||src.Race=="Half Demon")
				if(prob(30))
					if(MakyoStar)
						if(src.Race=="Makyo")
							src.PlusPower=1000000
						if(src.Race=="Demon")
							src.PlusPower=100000
						if(src.Race=="Half Demon")
							src.PlusPower=50000
					else
						src.PlusPower=0
			if(src.z!=7&&src.z!=13)
				for(var/obj/Curse/x in src)
					if(src.Power*src.Energy/3>x.Power)
						src<<"You break the curse due to your immense power!"
						del(x)
					else
						src.loc=locate(250,250,7)
						src<<"The curse takes it toll and you are sent to hell!"
						break
			if(Noobs.Find(src.key))
				Body=0.001
				if(src.z!=7)
					src.loc=locate(250,250,7)
					src<<"You are an OOC threat and are condemed to hell!"
			else
				if(Age>=PrimeAge)
					Body=1
				else
					Body=Age/PrimeAge
				if(Age>=Decline) Body=1-((Age-Decline)*Decline_Rate*0.05)
				if(Dead)
					if(KeepBody)
						Body=0.25
					else
						Body=0.05

			//Get_Refire()
			var/Base=SpeedMod
			var/Az=sqrt(sqrt(sqrt(src.Speed)))
			var/Lawl=Base+Az
			Refire=25/Lawl
			for(var/obj/Money/M in src) M.suffix="[Commas(M.Level)] Resources"
			if(src.KaiokenBP)
				var/prevlevel=src.KaiokenBP/(2000*KaiokenMastery)
				if(prevlevel>src.KaiokenMastery)
					var/amount=prevlevel-src.KaiokenMastery
					src.Health-=amount*amount*amount
					if(src.Health<=0)
						src<<"You stop using Kaioken."
						src.KaiokenBP=0
						src.Speed*=0.5
						src.SpeedMod*=0.5
						src.Defense*=2
						src.DefenseMod*=2
						src.overlays-=image(icon='AurasBig.dmi',icon_state="Kaioken",pixel_x=-32)
						src.Death(null,"the strain of Kaioken!")
					if(src.KaiokenMastery<20)
						if(prob(5*amount))
							src.KaiokenMastery++
		if(prob(75))
			if(src.ssj["active"]>0)
				ssj["[src.ssj["active"]]mastery"]+=1/sqrt(ssj["[src.ssj["active"]]mastery"])/(20*ssj["active"])
				ssj["[src.ssj["active"]]mastery"]=min(ssj["[src.ssj["active"]]mastery"],100)
				if(!(src.ssj["active"]==1&&src.ssj["1mastery"]==100))
					src.Energy-=(src.EnergyMax*(1/ssj["[src.ssj["active"]]mastery"]))/(100/ssj["active"])
					if(src.Energy<(EnergyMax/20))
						src.Revert()
			if(src.scl["active"]>0)
				scl["[src.scl["active"]]mastery"]+=1/sqrt(scl["[src.scl["active"]]mastery"])/(20*scl["active"])
				scl["[src.scl["active"]]mastery"]=min(scl["[src.scl["active"]]mastery"],100)
				if(!(src.scl["active"]==1&&src.scl["1mastery"]==100))
					src.Energy-=(src.EnergyMax/(scl["[src.scl["active"]]mastery"]/1))/(2500*scl["active"])
					if(src.Energy<(EnergyMax/20))
						src.Revert()
			for(var/obj/Skills/Buffs/Focus/x in src)
				if(x.Using)
					if(src.Energy<src.EnergyMax/10||src.KO)
						src.SkillX("Focus",x)
						break
					src.Energy-=(src.EnergyMax/(x.Level/1))/(10*(EnergyMax/1000))
					x.Skill_Increase(1)
					if(prob(10))src.SkillLeech(x)
				break
			if(prob(50))
				for(var/obj/Skills/Buffs/Expand/x in src)
					if(x.Using)
						if(src.KO)
							src.SkillX("Expand",x)
							break
						x.Skill_Increase(1)
						if(prob(10))src.SkillLeech(x)
					break


		if(prob(5))
			if(src.Flying)
				for(var/obj/Skills/Fly/x in src)
					src.SkillLeech(x)
			for(var/obj/Skills/Attacks/Beams/x in src)
				if(x.Using)src.SkillLeech(x)
			for(var/obj/Skills/Rank/Shield/x in src)
				if(x.Using)src.SkillLeech(x)
			if(src.PowerUp||src.PowerDown)
				for(var/obj/Skills/PowerControl/x in src)
					src.SkillLeech(x)
		if(prob(88))
			if(usr.Transfering)
				var/nullify=1
				var/mob/Players/M=usr.Transfering
				if(istype(M,/mob/Players))
					if(M in world&&!src.KO)
						if(M.z==src.z&&!M.KO)
							if(M in range(10,src))
								if(src.Energy>src.Energy/10&&src.Health>10)
									//src.Health--
									src.Energy-=src.EnergyMax/100
									M.Energy+=M.EnergyMax/100
									missile('SE.dmi', src, M)
									nullify=0
				if(nullify)usr.Transfering=null



mob/proc/WeightFormula(var/Wut)
	var/canlift=src.Strength*2+src.Endurance/2*1.5
	var/lifted=1
	if(Wut==2)
		return canlift
	if(Wut==1)
		for(var/obj/Items/Weights/W in src)
			if(W.suffix)
				lifted+=W.Level
		var/gain=lifted/canlift*1.5
		if(gain<1)
			gain=1
		return gain
