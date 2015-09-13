mob/proc/GetAssess()
	var/TrueAge=Year-src.Birth_Year
	var/PowerDisplay
	if(src.Power>1)
		PowerDisplay=Commas(src.Power)
	else
		PowerDisplay=1




	var/blahh={"

			<html>
	<style type="text/css">
	<!--
	body {
	     color:#449999;
	     background-color:black;
	     font-size:12;
	 }
	table {
	     font-size:12;
	 }
	//-->
	</style>
	<body>
	[src.name]<br>
	Current Anger: [src.Anger*100]%<br>
	<table cellspacing="6%" cellpadding="1%">
	<tr><td>Age:</td><td>[round(src.Age,0.1)](True Age:[round(TrueAge,0.1)])</td></tr>
	<tr><td>Body:</td><td>[src.Body*100]% ([round(src.Decline,0.1)] Decline)</td></tr>
	<tr><td>Base:</td><td>[Commas(round(src.Base))]([src.BaseMod])</td></tr>
	<tr><td>Current BP:</td><td>[PowerDisplay]</td></tr>
	<tr><td>Energy:</td><td>[Commas(round(src.EnergyMax))]([src.EnergyMod])</td></tr>
	<tr><td>Strength:</td><td>[Commas(src.Strength)]([src.StrengthMod])</td></tr>
	<tr><td>Endurance:</td><td>[Commas(src.Endurance)]([src.EnduranceMod])</td></tr>
	<tr><td>Speed:</td><td>[Commas(src.Speed)]([src.SpeedMod])</td></tr>
	<tr><td>Force:</td><td>[Commas(src.Force)]([src.ForceMod])</td></tr>
	<tr><td>Resistance:</td><td>[Commas(src.Resistance)]([src.ResistanceMod])</td></tr>
	<tr><td>Offense:</td><td>[Commas(src.Offense)]([src.OffenseMod])</td></tr>
	<tr><td>Defense:</td><td>[Commas(src.Defense)]([src.DefenseMod])</td></tr>
	<tr><td>Regeneration:</td><td>[src.Regeneration]</td></tr>
	<tr><td>Recovery:</td><td>[src.Recovery]</td></tr>
	<tr><td>Zenkai:</td><td>[src.Zenkai_Rate]</td></tr>
	<tr><td>Gravity:</td><td>[Commas(src.GravityMastered)]([src.GravityMod])</td></tr>
	<tr><td>Anger:</td><td>[src.AngerMax*100]%</td></tr>
	<tr><td>Meditation Rate:</td><td>[src.Meditation_Rate]</td></tr>
	<tr><td>Training Rate:</td><td>[src.Training_Rate]</td></tr>
	<tr><td>Flying:</td><td>([src.FlySkillMod])</td></tr>
	<tr><td>Zanzoken:</td><td>([src.ZanzokenSkillMod])</td></tr>
	<tr><td>Intelligence:</td><td>([src.Intelligence])</td></tr>
	<tr><td>Potential:</td><td>[src.Potential]</td></tr>
	<tr><td>Gain Multiplier: [Commas(src.EXP)]</td></tr>
			</table>"}
	if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
		if(src.Class=="Legendary")
			blahh+={"<font color=#FFFF00>Super Saiyan at: [Commas(src.ssj["1req"])]<br>Legendary Super Saiyan at: [Commas(src.ssj["2req"])]<br>Super Saiyan 3 at: [Commas(src.ssj["3req"])]"}
		else
			blahh+={"<font color=#FFFF00>Super Saiyan at: [Commas(src.ssj["1req"])]<br>Super Saiyan 2 at: [Commas(src.ssj["2req"])]<br>Super Saiyan 3 at: [Commas(src.ssj["3req"])]"}
	if(src.Race=="Changling")
		if(src.ssj["1req"])
			blahh+={"<font color=#CC99FF>Super Changling 1 at: [Commas(src.scl["1req"])]"}
		if(src.ssj["2req"])
			blahh+={"<br><font color=#CC99FF>Super Changling 2 at: [Commas(src.scl["2req"])]"}
		if(src.ssj["3req"])
			blahh+={"<br><font color=#CC99FF>Super Changling 3 at: [Commas(src.scl["3req"])]"}
		if(src.ssj["4req"])
			blahh+={"<br><font color=#CC99FF>Super Changling 4 at: [Commas(src.scl["4req"])]"}
	return blahh
	//	<font color=#FFFF00>Super Saiyan at: 1'500'000<br>Super Saiyan 2 at: 200'000'000<br>Super Saiyan 3 at: 550'000'000


obj/Package
	Crandal
		verb
			ChangeIcon(var/atom/A as mob|obj in view(usr,5))
				set src=usr.client
				set category="Other"
				if(istype(A,/obj))

					if(istype(A,/obj/Planets)||istype(A,/obj/Items/Tech/SpaceTravel)||istype(A,/obj/Oozaru)||istype(A,/obj/Lycan))
						usr<<"You're not allowed to change these icons."
						return
					if(usr.Alert("You sure you wanna change [A]'s icon?"))
						var/Z=input(usr,"Choose an icon for [A]!","ChangeIcon")as icon
						A.icon=Z
						A.icon_state=input("icon state") as text
				if(istype(A,/mob))
					if(usr.Alert("You sure you wanna change [A]'s icon?"))
						var/Z=input(usr,"Choose an icon for [A]!","ChangeIcon")as icon
						if(A!=usr)
							var/hm=input(A,"Do you want to change your icon into [Z] which [usr] presented?")in list("No","Yes")
							if(hm=="No")
								return
						A.icon=Z


			Rename(var/atom/A as mob|obj in view(usr,5))
				set src=usr.client
				set category="Other"
				if(istype(A,/obj/Planets)||istype(A,/obj/PlanetFlag))
					usr<<"You're not allowed to rename these objects."
					return
				var/blah=input("") as text
				if(istype(A,/mob))
					if(A!=usr)
						usr<<"You cannot rename other people!"
						return
				if(blah&&blah!=""&&blah!=" ")
					A.name=copytext(blah,1,30)

	Assess
		verb/Assess()
			set category="Other"
			//<font color="#449999">
			usr<<browse(usr.GetAssess(),"window=Assess;size=280x652")



	PowerRanks
		verb/PowerRanks()
			set category="Other"
			var/View={"<html><head><title>Power Ranks</title><body>
	<font size=3><font color=red>Power Ranks:<hr><font size=2><font color=black><b>BPRank(StatRank)</b><br>"}
			if(usr.Admin)
				var/list/people=new
				for(var/mob/M in world)
					if(M.client)
						people.Add(M.key)
				var/list/sortedpeople=dd_sortedTextList(people,0)
				for(var/x in sortedpeople)
					for(var/mob/M in world)
						if(M.key==x)
							View+="<b>[M.key]</b> - [M.GetPowerRank(2)]([M.GetPowerRank(1)])<br>"
							break
			else
				View+="[usr.GetPowerRank(2)]([usr.GetPowerRank(1)])"
			usr<<browse(View,"window=Log;size=250x400")


	MaterializeSpecial
		AdminInviso=1
		verb/MakeTrainingEquipment()
			set category="Other"
			var/blah=input("make what") in list("Nevermind","Log","Bag")
			if(blah=="Nevermind")return
			if(blah=="Log")
				var/obj/Items/Tech/Log/Q=new(usr.loc)
				Q.Health=rand(115656,3213211)
			if(blah=="Bag")
				var/obj/Items/Tech/PunchingBag/Q=new(usr.loc)
				Q.Health=rand(115656,3213211)


	Colorfy
		verb/Colorize(obj/O in view(8))
			set category="Other"
			switch(input("Add, Subtract, or Multiply color?", "", text) in list ("Add", "Subtract","Multiply"))
				if("Add")
					var/rred=input("How much red?") as num
					var/ggreen=input("How much green?") as num
					var/bblue=input("How much blue?") as num
					O.icon=O.icon
					O.icon+=rgb(rred,ggreen,bblue)
				if("Subtract")
					var/rred=input("How much red?") as num
					var/ggreen=input("How much green?") as num
					var/bblue=input("How much blue?") as num
					O.icon=O.icon
					O.icon-=rgb(rred,ggreen,bblue)
				if("Multiply")
					var/colorz=input("Multiply") as color
					var/icon/I=new(O.icon)
					I.Blend((colorz),ICON_MULTIPLY)
					O.icon=I

mob/var/list/Package=new

mob/proc/CheckIfPackaged()
	//Disabled- Everyone gets these skills for now.  if(src.key=="RednaXXXela")//All Packages - Owner
	if(client)
		if(!(locate(/obj/Package/Crandal,src.contents)))
			src.contents+=new/obj/Package/Crandal
		if(!(locate(/obj/Package/Assess,src.contents)))
			src.contents+=new/obj/Package/Assess
		if(!(locate(/obj/Package/Colorfy,src.contents)))
			src.contents+=new/obj/Package/Colorfy
		if(!(locate(/obj/Package/PowerRanks,src.contents)))
			src.contents+=new/obj/Package/PowerRanks

	//if(src.key=="Blah blah")//Assess