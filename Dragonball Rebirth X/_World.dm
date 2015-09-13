var/MakyoStar=0
var/Crazy=0
//MAKE NPC SPAWNS(did some on earth already)...or just place them on the map for now o.o they dont save
//add the cooler npcs lol()> note; done with SpecialBig.dmi, start/finish Special.dmi
//dont fuking release till that shit is done dumbfuck.
//WORRY ABOUT SHIT MORE.
//ADD NPC DROPS!!!!!!@@!@@!@

world
	name="Dragonball Rebirth"
	status="Version 1.3 (Beta-Testing) | Last Updated: 12/18/11"
	turf=/turf/Special/Blank
	area=/area/Outside
	mob= /mob/Creation
	hub="EnvyAttraction.RPRebirth"
	hub_password="haha"
	//tick_lag=1
	//fps=20
	//step_size=16//32
	cache_lifespan=2
	loop_checks=0
	view=8
	OpenPort()
		..()
		world<<"World Link: byond://[address]:[port]."
	New()
		..()
		WorldLoading=1
		spawn(100)GlobalSave()
		Stars()
		//spawn(100)Check()
		log=file("Saves/Errors.log")
		spawn(10)BootWorld("Load")
	Del()
		BootWorld("Save")
		..()

proc/SpawnMaterial()
	var/num=0
	for(var/obj/Items/Tech/SpaceTravel/Ship/AndroidShip/Q in world)
		num++
	if(num==0)
		world<<"<small>Server: Spawning Android Ship."
		var/obj/q=new/obj/Items/Tech/SpaceTravel/Ship/AndroidShip
		q.loc=locate(rand(1,500),rand(1,500),12)
	var/list/buh=list("Earth"=1,"Namek"=2,"Vegeta"=3,"Ice"=4,"Arconia"=5)
	for(var/x in buh)
		if(Planets.Find(x))
			var/numz=0
			for(var/obj/Planets/Q in world)
				if(Q.Zz==buh[x])
					numz++
			if(numz==0)
				world<<"<small>Server: Spawning [x]"
				var/obj/planet = text2path("/obj/Planets/[x]")
				new planet(locate(rand(1,500),rand(1,500),12))
	num=0
	var/amount=5
	while(amount>0)
		for(var/obj/Planets/Alien/Q in world)
			if(Q.Zz==amount)
				num=1
		if(num==0)
			world<<"<small>Server: Spawning Random Alien Planet."
			var/obj/q=new/obj/Planets/Alien
			q.loc=locate(rand(1,500),rand(1,500),12)
			q:Zz=amount
			var/randy=1
			var/randx=amount
			while(randx>5)
				randx-=5
				randy++
			world<<"<small>Server: Spawning Conquer Flag on Random Alien Planet."
			var/obj/A=new/obj/PlanetFlag/Pole
			A.loc=locate(rand(randx*100-99,randx*100-1),rand(randy*100-99,randy*100-1),14)
			A:Zz=amount
			switch(amount)
				if(5)
					q.icon-=rgb(100,100,100)
				if(4)
					q.icon+=rgb(-30,-40,50)
				if(3)
					q.icon+=rgb(-30,48,-50)
				if(2)
					q.icon+=rgb(-44,44,50)
				if(1)
					q.icon+=rgb(-70,40,-56)
		amount--


var/numberz=0

proc/GlobalSave()
	set background=1
	while(1)
		numberz++
		sleep(37000*rand(1,2))
		for(var/mob/Players/Q in world)
			if(Q.Savable)
				Q.client.SaveChar()
		BootWorld("Save")
	//	if(numberz>5)
	//		numberz=0
	//		world<<"Server is rebooting in 30 seconds! Prepare!"
	//		spawn(300)world.Reboot()



var/Updates={"
<i>|Version MM/DD/YYYY|</i><br><br>

<b>(V1.3 12/21/2011)</b><br>
New Digging system.<br>
New Warping system.<br>
Grab is logged to prevent people from non-rp grabbing and drowning people.<br>
New train drain formula.<br>
Planet conquer system?! (:(There are random alien planets in space, conquer the flag on the respective planet.... you find out the rest!(You can even name the planets!))<br>
Basic AI(Will be advanced soon) system implemented.<br>
Made set src=usr.client my friend!<br>
Lycan transformations done. Their Shred/Howl skills now limited to only transformation. Leap is applicable to normal and lycan form.<br>
New Barrage skill given to Vegeta Teachers.<br>
Can now customize swords! (:<br>
New race icons! Makyo and SpiritDoll.<br>
Fixed some density issues with turfs/objs.<br>
New Wolf Fang Fist skill, along with a new default rank: Wolf Hermit.<br>
New homing systems and features, click a mob to target them.(Not fully complete, just works for things like wolf fang fist, homing swords and such)<br>

<hr>
<b>(V1.2 12/18/2011)</b><br>
New Login screen.<br>
Smell feature for Lycans/Vampires<br>
<hr>
<b>(V1.2 12/17/2011)</b><br>
Swimming system!(This includes drowning, so be careful)<br>
Rewarded Stat system!<br>
Redid Lycans! Transformations are delayed for them though!<br>
Can now punch walls and turfs and the such!<br>

<hr>
<b>(V1.2 12/11/2011)</b><br>
Security Measures (:<br>
I can download reports for easier reading!<br>
Removed Admin Apps from SubmitReport, apply on the forums if you want I guess.<br>
Fixed Zanzoken bug.<br>
Enhanced PD system even further for CPU usage and such.<br>
Completely redid Stat ranks. Should be alot better now (: <br>
Fixed some more bugs lol.<br>
Cannot Oozaru while dead now, Oozaru has less defense.<br>
Cannot kill in the TFR.<br>
New Alien Types(Ultra Rare): Vampire, Lycan.<br>

<hr>
<b>(V1.2 12/09/2011)</b><br>
Adjusted Zenkai system.<br>
New PD system.<br>

<hr>
<b>(V1.2 12/05/2011)</b><br>
Fixed security flaw.<br>
Fixed client logins?<br>
CustomChangeSkillIcon - you can now choose your own blast/power control/beam icons etc.<br>
Completely redid Pierce/Explosive system. they are now set (:<br>
Fixed Combat system<br>
<hr>
<b>(V1.2 12/04/2011)</b><br>
Androids no longer lose BP based upon current health and energy.<br>
Fixed some bugs.<br>
Fixed logs.<br>
Fixed splitforms?<br>
Paragraph to emote!<br>
Anger now works better.<br>
authenticate for clients switched to 0, should allow me to fucking login. <_<<br>

<hr>
<b>(V1.2 12/03/2011)</b><br>
Added halfies (:<br>
Added in whole new unique mating system. Your dominant race will be one of the parents, but your stats and such will be a combination of your parents parents races and all that!<br>
Smooth combat system (:<br>
Pod launch time changed to 30 seconds, request by players.<br>
Asexual added.<br>
New bind system.<br>
Sense tab won't appear if scouter tab is.<br>
You can't loot someone while KOed yourself.<br>
Logs have higher durability and are harder to break now.<br>
Each race has their own specific prime age.(when they can mate, and get full body.)<br>
Nerfed Oozaru from 10x to 5x.<br>
Disabled Guest keys.<br>
Nerfed walls.<br>
Power Up drains no longer compensatable by medding.<br>
Added Bio Android, Majin, and Dragon races.(Rares)<br>
Fixed bugs and addressed submitted reports.<br>
Boosted Majin and Demonic Will.<br>
Added Death Regenerate.<br>
Added Dragonballs.<br>
Any saiyan can naturally learn False Moon if they're special (: (about every 1 in 10 saiyans)<br>
SSJ auto-gives FBM now like it should.<br>
Redid zenkai system.<br>
For Changilngs and saiyans, you must master the previous form before being able to trans into the next.<br>
Added Android race and ship(planet, driveable at a certain year)<br>
Added a special changling ship that the changling lord would get a certain year.<br>
Basic Cyberization System.<br>

<hr>
<b>(V1.1 11/28/2011)</b><br>
Disabled reboot.<br>
Touched up some things.<br>
Added Scouter Frequencies/speak.<br>
Fixed makyo star :P!<br>
ADDED REMOTEABLE PODS- FUCK YAH!<br>
Redid Turrets accuracy.<br>
<hr>
<b>(V1.1 11/27/2011)</b><br>
Fixed some bugs.<br>
Redid Fly gains <br>
Added Check for self destruct<br>
Zanzoken fix.<br>
Turrets should be fixed.<br>
Added Makyo Star.(Boost to demons and makyos, amulet ports to earth)<br>
Clear weather is now 70% of the time now rather than 10%<br>
Fixed Oozaru overlays.<br>
Oozaru now gives a 10x boost.<br>
Tried to tone down some CPU whore usages.<br>
Fixed the typical black screen bug when using a pod while grabbing it(nubs).<br>
ArrangeTabs requested by the community, added.<br>


<hr>
<b>(V1.1 11/26/2011)</b><br>
Tail overlays fixed when choosing new hair, Oozaru verb hides tail when not looking at moon, etc.<br>
Swords!<br>
Revamped Namekian mods.<br>
Redid some energy drain formulas.<br>
New EXP leeching system.<br>
Looting system.<br>
Added whisper verb.<br>
Probability of melee gain effected by speedmod now for balance.<br>
Added concious global speed.<br>
Redid anger system.<br>
Added gaining decline system, and global var speed.<br>

<hr>
<b>(V1.1 11/24/2011)</b><br>
Fixed healer namekians.<br>
Added global reboots.<br>
Fixed kaio teleport.<br>

<hr>
<b>(V1.1 11/13/2011)</b><br>
Fixed lockout glitch.<br>
Fixed runtime errors.<br>
Redid Reports.<br>
Global saving is now every 1-2 hours.<br>
Fixed MAJOR bug.<br>

<hr>
<b>(V1.1 11/12/2011)</b><br>
Added Third Eye.<br>
Everything Tech releated is boltable and unboltable.<br>
Fixed runtime errors.<br>
Easier correlation between admins.<br>
Added ships.<br>
Added Spirit Doll race.<br>
Rebalanced races mods including int.<br>
Added restore youth.<br>
New Int system.<br>
Gives Aliens 90 points now instead of 70.<br>
Added Absorb.<br>
Added roleplay alliance.<br>
Added energy req. to skills to be leeched/taught.<br>
Telepathy is now race specific.<br>
Special Expand transes for Makyos, Namekians and Demis.<br>
Added admin applications in SubmitForum.<br>
Technologists and Wizards completely redone.<br>
Added spacemasks.<br>
New skill: Bind.<br>
New skill: False Moon.<br>
New tech: Moons.<br>
New skill: regenerate.<br>
Global saving every 2-4 hours.<br>
Implemented a manual save verb.<br>
Added racial skills.(ex: such as humans get focus at 5k energy.)<br>
Nerfed flying energy gains slightly.<br>
Added TFR(The Final Realms)<br>
New stealing system.<br>
Healer class for namekian.<br>
Demons no longer recieve Majin racially, Majin is a skilll infested by the Daimaou and forcefully placed upon victims giving them full control of their free will.<br>
Demons now recieve Demonic Will(Nerfed version of majin pretty much).<br>


<hr>
<b>(V1.0 11/10/2011)</b><br>
Fixed turrets.(and reduced price)<br>
Fixed Oozaru and global moon.<br>
Increased overall strength of upgraded walls, etc.<br>
Fixed OPed Ki attacks.<br>
Added zanzoken and powercontrol at basics at a high energy req.<br>
Eliminated punching drain from NPCs.<br>
Redid Sokidan.<br>
Viewable upgrade cost in window, description verb to view current level of tech.<br>
Fixed autokills, and added who koed who in energy attacks.<br>
Fixed teach verb.<br>
Self Destruct/Materialize are auto-mastered now.<br>
Added planet gravity.<br>
Fixed attack bug.<br>
Fixed afterlife clouds!<br>
Fixed logs' durability and their gains.<br>
Heightened sparring gains.(NPC sparring and client sparring now different as well)<br>

<hr>
<b>(V1.0 11/08/2011)</b><br>
Skill Mastery made a dynamic variable.<br>
Fixed log hitting delay.<br>
Fixed weather click problems.(mouse_opacity now set to 0)<br>
Fixed some runtime errors.<br>
Revamped deaths(secret), body blood/spoil/eat system.<br>
Added scouters.<br>
Can now upgrade roofs, doors, and the like and toggle if you can fly over roofs.<br>
Can now knock on doors.<br>
Fixed some portal/spawn bugs.<br>
Added in Notes for admins.<br>
Fixed knockback.<br>
Fixed map loading.<br>

<hr>
<b>(V1.0 11/07/2011)</b><br>
Fixed a retarded bug that caused the game to continually crash.(BYOND's update with the Move() proc)<br>
Changed OOC Layout to differentiate from say chat. <br>
Rename now lets you rename yourself as well as objects. <br>
Added an Examine verb so you can right click people.<br>
Fixed Leech difficulity and made it a dynamic world variable.<br>
Fixed logs.<br>
Added admin help.<br.
Added dynamic variable for punching drain.<br>
Added Countdown verb<br>

<hr>
<b>(V1.0 11/06/2011)</b><br>
Decided to bring it back up since 10/23, so I guess this is really the new release date.
Fixed speed delay.<br>
Added flexiable dynamic world variables that can be alterable in game that effects gains on nearly everything.<br>
Added Races verb.<br>
Added Screen Size verb<br>
Added SubmitReport(Credits to Super Saiyan X)<br>

<hr>
<b>(V1.0 10/23/2011)</b><br>
Game released to public :)

"}


proc/Check()
	while(src)
		var/File=world.Export("http://laststrike.110mb.com/DRV.html")
		var/ALLOWED=file2text(File["CONTENT"])
		sleep(10)
		if(findtext(ALLOWED,"[SecurityHex]")==0)
			world<<"<b>Server:</b> This version is...<font color=red><b><u>OUTLAWED!"
			spawn(60)del(world)
		sleep(rand(6000,36000))



var/WorldLoading


var/SecurityHex="PrivateTesting666"



var/list/LockedRaces=list(params2list("Elite=RednaXXXela"),params2list("Legendary=RednaXXXela"),params2list("King Kold=RednaXXXela"),params2list("Dragon=RednaXXXela"),params2list("Bio=RednaXXXela"),params2list("Majin=RednaXXXela"),params2list("Vampire=RednaXXXela"),params2list("Hellspawn=RednaXXXela"),params2list("Half Saiyan=RednaXXXela"),params2list("Lycan=RednaXXXela"))

mob/proc/CheckUnlock(var/blah)
	if(blah=="Elite"||blah=="Hellspawn"||blah=="Half Saiyan"||blah=="Legendary"||blah=="King Kold"||blah=="Trunks"||blah=="Gohan"||blah=="Majin"||blah=="Bio"||blah=="Dragon"||blah=="Vampire"||blah=="Lycan")
		var/rarity=3
		if(blah=="Elite")
			rarity=2
		if(blah=="Legendary")
			rarity=5
		if(blah=="King Kold")
			rarity=5
		if(blah=="Trunks")
			rarity=2
		if(blah=="Gohan")
			rarity=1
		if(blah=="Hellspawn")
			rarity=5
		if(blah=="Vampire"||blah=="Lycan")
			rarity=10
		if(blah=="Half Saiyan")
			rarity=1
		var/list/online=new
		online["[blah]"]=0
		online["Other"]=0
		for(var/mob/Players/M in world)
			if(blah=="Elite"||blah=="Low-Class")
				if(M.Race=="Saiyan")
					if(M.Class=="[blah]")
						online["[blah]"]++
					else
						online["Other"]++
			if(blah=="Vampire"||blah=="Lycan")
				if(M.Race=="Alien")
					if(M.Class=="[blah]")
						online["[blah]"]++
					else
						online["Other"]++
			if(blah=="Gohan"||blah=="Trunks")
				if(M.Race=="Half Saiyan")
					if(M.Class=="[blah]")
						online["[blah]"]++
					else
						online["Other"]++
			if(blah=="King Kold")
				if(M.Race=="Changling")
					if(M.Class=="[blah]")
						online["[blah]"]++
					else
						online["Other"]++
		if(online["Other"]>(online[blah]+1)*rarity||src.CheckSpecial("[blah]"))
			return 1
	return 0

mob/proc/CheckSpecial(var/blah)
	for(var/x in LockedRaces)
		for(var/e in x)
			if(e=="[blah]")
				if(x[e]==src.key)
					return 1
	return 0



proc/Stars()
	for(var/turf/Special/Stars/E)
		E.icon_state="[rand(1,2500)]"


proc/BootWorld(var/blah)
	switch(blah)
		if("Load")
			BootFile("All","Load")
			Load_Turfs()
			Load_Objects()
			sleep(rand(1,10))
			spawn()Years()
			sleep(rand(1,10))
			spawn()Add_Builds()
			sleep(rand(1,10))
			spawn()Add_Customizations()
			sleep(rand(1,10))
			spawn()Add_Technology()
			sleep(rand(1,10))
			WorldLoading=0
			Reports("Load")
		if("Save")
			BootFile("All","Save")
			//Save_Alliance()
			Reports("Save")
			Save_Turfs()
			Save_Objects()


proc/BootFile(var/file,var/op)
	set background=1
	world<<"<small>Server: ([op])ing [file]"
	switch(file)
		if("Admins")
			if(op=="Load")
				if(fexists("Saves/Admins"))
					var/savefile/F=new("Saves/Admins")
					F["Admins"]>>Admins
			if(op=="Save")
				var/savefile/F=new("Saves/Admins")
				F["Admins"]<<Admins

		if("Planets")
			if(op=="Load")
				if(fexists("Saves/Planets"))
					var/savefile/F=new("Saves/Planets")
					F["Planets"]>>Planets
				//else
				//	Planets.Add()
					//Planets.Add("Earth","Namek","Vegeta","Ice","Afterlife","Hell","Heaven","Arconia")
			if(op=="Save")
				var/savefile/F=new("Saves/Planets")
				F["Planets"]<<Planets
		if("Alliance")
			switch(op)
				if("Load")
					if(fexists("Saves/Alliance"))
						var/savefile/S=new("Saves/Alliance")
						S["Noobs"]>>Noobs
						S["Alliance"]>>Alliance
				if("Save")
					var/savefile/S=new("Saves/Alliance")
					S["Noobs"]<<Noobs
					S["Alliance"]<<Alliance
		if("Misc")
			if(op=="Load")
				if(fexists("Saves/Misc"))
					var/savefile/F=new("Saves/Misc")
					F["Year"]>>Year
					F["YearSpeed"]>>Year_Speed
					F["Gains"]>>Gains
					F["Locked"]>>LockedRaces
					F["IntRate"]>>IntRate
					F["EnergyGains"]>>EnergyGains
					F["StatGains"]>>StatGains
					F["EXPGains"]>>EXPGains
					F["SpeedEffect"]>>SpeedEffect
					F["ControlRegen"]>>ControlRegen
					F["ControlRecov"]>>ControlRecov
					F["LeechHard"]>>LeechHard
					F["DrainHard"]>>DrainHard
					F["MasteryHard"]>>MasteryHard
					F["Decline"]>>DeclineGains
					F["GetUp"]>>GetUpVar
				if(fexists("Saves/Rules"))
					var/savefile/S=new("Saves/Rules")
					S["Saves/Rules"]>>Rules
				if(fexists("Saves/Story"))
					var/savefile/S=new("Saves/Story")
					S["Saves/Story"]>>Story
				if(fexists("Saves/Ranks"))
					var/savefile/S=new("Saves/Ranks")
					S["Saves/Ranks"]>>Ranks
				if(fexists("Saves/AdminNotes"))
					var/savefile/S=new("Saves/AdminNotes")
					S["Saves/AdminNotes"]>>AdminNotes
			if(op=="Save")
				var/savefile/F=new("Saves/Misc")
				F["Year"]<<Year
				F["YearSpeed"]<<Year_Speed
				F["Gains"]<<Gains
				F["Locked"]<<LockedRaces
				F["IntRate"]<<IntRate
				F["EnergyGains"]<<EnergyGains
				F["StatGains"]<<StatGains
				F["EXPGains"]<<EXPGains
				F["SpeedEffect"]<<SpeedEffect
				F["ControlRegen"]<<ControlRegen
				F["ControlRecov"]<<ControlRecov
				F["LeechHard"]<<LeechHard
				F["DrainHard"]<<DrainHard
				F["MasteryHard"]<<MasteryHard
				F["Decline"]<<DeclineGains
				F["GetUp"]<<GetUpVar


				var/savefile/S=new("Saves/Rules")
				S["Saves/Rules"]<<Rules
				var/savefile/Z=new("Saves/Story")
				Z["Saves/Story"]<<Story
				var/savefile/E=new("Saves/Ranks")
				E["Saves/Ranks"]<<Ranks
				var/savefile/W=new("Saves/AdminNotes")
				W["Saves/AdminNotes"]>>AdminNotes
		if("Bans")
			switch(op)
				if("Save")
					if(Punishments)
						var/savefile/S=new("Saves/Punishment")
						S["Punishments"]<<Punishments
				if("Load")
					if(fexists("Saves/Punishment"))
						var/savefile/S=new("Saves/Punishment")
						S["Punishments"]>>Punishments
		if("All")
			if(op=="Save")
				BootFile("Planets","Save")
				BootFile("Admins","Save")
				BootFile("Misc","Save")
				BootFile("Bans","Save")
				BootFile("Alliance","Save")
			if(op=="Load")
				BootFile("Planets","Load")
				BootFile("Admins","Load")
				BootFile("Misc","Load")
				BootFile("Bans","Load")
				BootFile("Alliance","Load")
	world<<"<small>Server: [file] ([op])ed"


client/proc/LoginLog(var/title=null)
	if(title=="LOGOUT")
		if(src.mob)
			title={"<font color=red>logged out.</font color>([src.mob.name])"}
		else
			title={"<font color=red>logged out.</font color>"}
	AdminMessage("[TimeStamp()]<b> [src.key]</b> | [src.address] | [src.computer_id] ([title])")
	var/ISF=file("Saves/LoginLogs/[TimeStamp(1)].txt")
	ISF<<"<font color=black>[TimeStamp()]<b> [src.key]</b> | [src.address] | [src.computer_id] ([title])<br>"

client
	default_verb_category=null
	perspective=EYE_PERSPECTIVE|EDGE_PERSPECTIVE
	Del()
		src.LoginLog("LOGOUT")
		if(mob)
			if(mob.Control)
				var/obj/Items/Tech/SpaceTravel/M=mob.Control
				if(M in world)
					mob.loc=M.loc
					M.who=null
					mob.client.eye=mob
					mob.Control=null
			if(mob.Savable)
				SaveChar()
				del(mob)
	New()
		..()
		src.LoginLog("<font color=blue>logged in.</font color>")





client/North() if(mob.Allow_Move(NORTH)) return ..()
client/South() if(mob.Allow_Move(SOUTH)) return ..()
client/East() if(mob.Allow_Move(EAST)) return ..()
client/West() if(mob.Allow_Move(WEST)) return ..()
client/Northwest() if(mob.Allow_Move(NORTHWEST)) return ..()
client/Northeast() if(mob.Allow_Move(NORTHEAST)) return ..()
client/Southwest() if(mob.Allow_Move(SOUTHWEST)) return ..()
client/Southeast() if(mob.Allow_Move(SOUTHEAST)) return ..()
mob/proc/Allow_Move(D)
	if(!Move_Requirements()) return
	if(Beaming)
		dir=D
		return
	if(Control)
		step(Control,D)
		if(Target&&istype(Target,/obj/Others/Build)) Build_Lay(Target,usr)
	for(var/mob/P in range(1,usr)) if(P.Grab==usr)
		var/Grab_Escape=10*(Power*Strength)/(P.Power*P.Strength)
		if(prob(Grab_Escape))
			view(P)<<"[usr] breaks free of [P]!"
			P.Grab_Release()
		else view(P)<<"[usr] struggles against [P]!"
		return
	return 1
mob/proc/Move_Requirements() if(!Knockbacked&&!Frozen&&!Moving&&!KO&&icon_state!="Meditate"&&icon_state!="Train") return 1

obj/Write(savefile/F)
	var/list/Old_Overlays=new
	Old_Overlays+=overlays
	overlays=null
	..()
	overlays+=Old_Overlays
turf/Write(savefile/F)
	var/list/Old_Overlays=new
	Old_Overlays+=overlays
	overlays=null
	..()
	overlays+=Old_Overlays
client/Click(obj/Items/A)
	if(mob&&mob.Target&&isobj(A)&&(A in mob.Target)&&mob.Target.KO&&mob.Target!=mob)
		if(!(mob.Target in oview(1,mob)))
			src<<"You are not near them"
			return
		if(istype(A,/obj/Money))
			if(A.Level)
				view(mob)<<"[mob] steals [Commas(A.Level)] Resources from [mob.Target]"
				for(var/obj/Money/M in mob) M.Level+=A.Level
				A.Level=0
			return
		view(mob)<<"[mob] steals [A] from [mob.Target]"
		if(A.suffix=="Equipped") A.Equip(mob.Target)
		A.Move(mob)
	else ..()