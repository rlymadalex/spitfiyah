var
	Year=0
	Year_Speed=1
proc/Years()
	set background=1
	while(1)
		sleep(36000/Year_Speed)
		Year+=0.1
		var/Month=round(Year-round(Year),0.1)
		world<<"<font color=#FFFF00>It is now month [Month*10] of year \
		[round(Year)]"
		spawn Add_Planet_Money()
		for(var/mob/Players/P)
			P.Age_Increase()
		for(var/obj/PlanetFlag/Pole/Q in world)
			if(Q.Owner)
				for(var/mob/Players/W)
					if(W.key==Q.Owner)
						W<<"You collect your monthly income for controlling the planet [W]!"
						for(var/obj/Money/B in W)
							B.Level+=rand(10000,25000)
		if(prob(20))
			world<<"<small><font color=yellow>The moon comes out..."
			for(var/mob/Players/P)
				if(initial(P.Tail)&&P.Age<16)
					P.Tail(1)
				for(var/obj/Oozaru/O in P)
					if(O.Looking)
						P.Oozaru(1)
		if(Year>1)
			if(Year%10==0)
				MakyoStar=1
				if((Year*10)%100==0)
					world<<"<small><font color=red>The Makyo Star approaches..."
			else
				MakyoStar=0
mob/proc/Age_Increase()
	if(Dead)
		if(Age<20)
			Age+=0.1
	if(!Dead) Age+=0.1
	Log_Year=Year
	//if(Year>=Birth_Year+20) AngerMax=150
	if(Age>Decline)
		if(prob(2))Death(null,"old age")
	src<<"<font color=#FFFF00>You are now [Age] years old."
mob/proc/Age_Update()
	if(Dead&&Age<20)
		Age+=Year-Log_Year
		if(Age>20)
			Age=20
	if(!Dead) Age+=Year-Log_Year
	Log_Year=Year



