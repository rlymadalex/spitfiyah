var/list
	CodedAdmins=list("EnvyAttraction"=4,"RednaXXXela"=4,"Qualy"=4)
	Admins=new
	Punishments=new
mob/var
	tmp/Admin=0
var
	GlobalMessage="Whaaat"


mob/proc/Admin(var/blah,var/Z,var/H)
	Z=text2num(Z)
	switch(blah)
		if("Check")
			if(src.key in CodedAdmins)
				src.Admin("Give",CodedAdmins[src.key],1)
			else if(src.key in Admins)
				src.Admin("Give",Admins[src.key])
			//else if(src.client.address==world.address||src.client.address=="127.0.0.1"||!src.client.address)
			//	Admin("Give",3);src<<"<i>Hosting Authority Granted!</i>"
		if("Give")
			src.Admin("Remove")
			src.Admin=Z
			if(Z==1)src.verbs+=typesof(/mob/Admin1/verb)
			if(Z==2)src.verbs+=typesof(/mob/Admin1/verb,/mob/Admin2/verb)
			if(Z==3)src.verbs+=typesof(/mob/Admin1/verb,/mob/Admin2/verb,/mob/Admin3/verb)
			if(Z==4)src.verbs+=typesof(/mob/Admin1/verb,/mob/Admin2/verb,/mob/Admin3/verb,/mob/Admin4/verb)
			if(Z<5&&Z>0&&!H)
				if(CodedAdmins.Find(src.key))return
				Admins.Add(params2list("[src.key]=[text2num(Z)]"))
		if("Remove")
			if(CodedAdmins.Find(src.key))return
			src.verbs-=typesof(/mob/Admin1/verb,/mob/Admin2/verb,/mob/Admin3/verb,/mob/Admin4/verb)
			Admins.Remove(src.key)
			src.Admin=0




mob/proc/CheckPunishment(var/z)
	if(CodedAdmins.Find(src.key))return 0
	for(var/x in Punishments)
		if(x["Punishment"]=="[z]")
			if(x["Key"]==src.key||x["IP"]==src.client.address||x["ComputerID"]==src.client.computer_id)
				if(text2num(x["Duration"])<world.realtime)
					Punishments.Remove(list(x))
				else
					if(x["Punishment"]=="Ban")
						src<<"You are Banned!"
						spawn()del(src)
					if(x["Punishment"]=="Mute")
						src<<"You are Muted!"
					src<<"<br>By: [x["User"]]<br>Reason: [x["Reason"]]<br>TimeStamp: [x["Time"]]<br>Will be lifted in [ConvertTime((text2num(x["Duration"])-world.realtime)/10)]!"
					return 1




proc/Punishment(var/z)
	z=params2list(z)
	if(z["Action"]=="Add")
		Punishments.Add(list(params2list("Punishment=[z["Punishment"]]&Key=[z["Key"]]&IP=[z["IP"]]&ComputerID=[z["ComputerID"]]&Duration=[z["Duration"]]&User=[z["User"]]&Reason=[z["Reason"]]&Time=[z["Time"]]")))
	if(z["Action"]=="Remove")
		for(var/w in Punishments)
			if(z["Punishment"]==w["Punishment"])
				if(z["IP"]==w["IP"])
					w["IP"]=null
				if(z["Key"]==w["Key"])
					w["Key"]=null
				if(z["ComputerID"]==w["ComputerID"])
					w["ComputerID"]=null
				if(w["ComputerID"]==null&&w["IP"]==null&&w["Key"]==null)
					Punishments.Remove(list(z))
	for(var/mob/M in world)
		if(M.client)
			M.CheckPunishment("Ban")


proc/ConvertTime(var/amount)
	var/size=text2num(amount)
	var/ending="Second"
	if(size>=60)
		size/=60
		ending="Minute"
		if(size>=60)
			size/=60
			ending="Hour"
			if(size>=24)
				size/=24
				ending="Day"
	var/end=round(size)
	return "[Value(end,1)] [ending]\s"

mob/verb/Info()
	var/Start={"<html><body><body bgcolor="#000000"><font color=orange>
<center><b>Server Time:</b> [TimeStamp()] (<a href='?info'>Refresh</a>)</center>
<b>Announcement to Clients:</b><br>
[GlobalMessage]<br><br>"}
	Start+="<center><b>Current Bans:</b><br>"
	for(var/x in Punishments)
		if(x["Punishment"]=="Ban")
			Start+="Key: [x["Key"]] | IP: [x["IP"]] | ComputerID: [x["ComputerID"]] | Duration: [(text2num(x["Duration"])-world.realtime)/600] | Banned By: [x["User"]] | Reason: [x["Reason"]] | Time of Ban: [x["Time"]]"
	Start+="<br><br><center><b>Current Mutes:</b><br>"
	for(var/x in Punishments)
		if(x["Punishment"]=="Mute")
			Start+="Key: [x["Key"]] | IP: [x["IP"]] | ComputerID: [x["ComputerID"]] | Duration: [(text2num(x["Duration"])-world.realtime)/600] | Muted By: [x["User"]] | Reason: [x["Reason"]] | Time of Mute: [x["Time"]]"
	src << browse("[Start]")


proc/AdminMessage(var/msg)
	for(var/mob/Players/M in world)
		if(M.Admin)
			for(var/obj/Communication/x in M)
				if(x.AdminAlerts)
					M<<"<b><font color=red>(Admin)</b><font color=fuchsia> [msg]"


mob/proc/ChatLog()
	return "Saves/PlayerLogs/[src.key]/Log"
proc/Log(var/e,var/Info)
	if(e=="Admin")
		e="Saves/AdminLogs/Log"
		AdminMessage(Info)
	var/numz=1
	while(length(file("[e][numz]"))>1024*200)
		numz++
	file("[e][numz]")<<"<br><font color=black>[time2text(world.timeofday,"MM/DD/YY(hh:mm:ss)")] [Info]"





mob/proc/SegmentLogs(var/e)
	var/wtf=0
	var/list/Blah=new
	LOLWTF
	wtf+=1
	var/XXX=file("[e][wtf]")
	if(fexists(XXX))
		Blah.Add(XXX)
		goto LOLWTF
	else
		if(Blah&&wtf>1)
			var/lawl=input("What one do you want to read?","Rebirth") in Blah
			var/ISF=file2text(lawl)
			var/View={"<html><head><title>Logs</title><body>
<font size=3><font color=red>[lawl]<hr><font size=2><font color=black>[ISF]"}
			src<<browse(View,"window=Log;size=500x550")
		else
			src<<"No logs found."




proc/TimeStamp(var/Z)
	if(Z==1)
		return time2text(world.timeofday,"MM-DD-YY")
	else
		return time2text(world.timeofday,"MM/DD/YY(hh:mm:ss)")
mob/proc/Alert(var/blah)
	switch(alert(src,blah,"Alert","Yes","No"))
		if("Yes")
			return 1




var/list/Writing=new



proc/ExtractInfo(var/x)
	if(istype(x,/mob))
		if(x:client)
			return "[x:key]</a href>([x])"
	return "[x]([x:type])"


mob/proc/PM(var/mob/who)
	var/blah=input("What do you want to say to [who]?") as text|null
	if(blah)
		for(var/mob/Players/Q in world)
			if(Q.Admin)
				if(Q!=src&&Q!=who)
					Q<<"(Admin PM)  <a href=?src=\ref[src];action=MasterControl;do=PM>[src.key]</a href> to <a href=?src=\ref[who];action=MasterControl;do=PM>[who.key]</a href> :[blah]"
		src<<"(Admin PM)- To  <a href=?src=\ref[who];action=MasterControl;do=PM>[who.key]</a href> :[blah]"
		who<<"(Admin PM)- From  <a href=?src=\ref[src];action=MasterControl;do=PM>[src.key]</a href> :[blah]"

mob/Admin1/verb
	AdminInviso()
		set category="Admin"
		if(usr.AdminInviso)
			usr<<"<font color=red>Admin Inviso off."
			usr.AdminInviso=0
			usr.invisibility=0
			usr.see_invisible =0
		else
			usr<<"<font color=green>Admin Inviso on."
			usr.AdminInviso=1
			usr.invisibility=99
			usr.see_invisible=100

	AdminAssess(var/mob/M in world)
		set category="Admin"
		usr<<browse(M.GetAssess(),"window=Assess;size=275x650")
	ManuallyCheckLog(var/x as text)
		set category="Admin"
		usr.SegmentLogs("Saves/PlayerLogs/[x]/Log")

	ViewAdminNotes()
		set category="Admin"
		usr<<browse(AdminNotes,"window=AdminNotes;size=470x550")
	EditAdminNotes()
		if(!Writing["AdminNotes"])
			Writing["AdminNotes"]=1
			for(var/mob/M) if(M.Admin) M<<"[usr] is editing the admin notes..."
			AdminNotes=input(usr,"Edit!","Edit Notes",AdminNotes) as message
			for(var/mob/F) if(F.Admin) F<<"[usr] is done editing the admin notes..."
			Writing["AdminNotes"]=null
			BootFile("Misc","Save")
		else usr<<"<b>Someone is already editing the Admin Notes."

	ToggleOOCWorld()
		set category="Admin"
		Allow_OOC=!Allow_OOC
		if(Allow_OOC)
			world<<"OOC Channel is <font color=green>enabled</font color>!"
		else
			world<<"OOC Channel is <font color=red>disabled</font color>!"
		Log("Admin","[ExtractInfo(usr)] toggled global OOC!")
	ViewSubmittedReports()
		winshow(src,"reportview",1)
	Forms()
		set category="Admin"
		usr<<"<b>Unlocked Forms:</b>"
		for(var/mob/Players/M in world)
			if(M.ssj["unlocked"]>0)
				usr<<"- [M]([M.key]) -[M.Class] Super Saiyan [M.ssj["unlocked"]]"
			if(M.scl["unlocked"]>0)
				usr<<"- [M]([M.key]) -[M.Class] Super Changling [M.scl["unlocked"]]"
		usr<<"<b>Current Forms:</b>"
		for(var/mob/Players/M in world)
			if(M.ssj["active"]>0)
				usr<<"- [M]([M.key]) -[M.Class] Super Saiyan [M.ssj["active"]]"
			if(M.scl["active"]>0)
				usr<<"- [M]([M.key]) -[M.Class] Super Changling [M.scl["active"]]"

	Alerts()
		set category="Admin"
		set name="(Un)Mute Admin Alerts"
		for(var/obj/Communication/x in usr)
			x.AdminAlerts=!x.AdminAlerts
			if(x.AdminAlerts) usr<<"You turn your AdminAlerts <font color=green>on</font color>."
			else usr<<"You turn your AdminAlerts <font color=red>off</font color>."

	AdminPM(mob/M in world)
		set category="Admin"
		usr.PM(M)

	PlayerLoginLogs()
		set category="Admin"
		var/list/files=new
		for(var/File in flist("Saves/LoginLogs/"))
			files.Add(File)
		files.Add("Cancel")
		var/lawl=input("What one do you want to read?","Rebirth") in files
		if(lawl=="Cancel")
			return
		var/ISF=file2text(file("Saves/LoginLogs/[lawl]"))
		var/View={"<html><head><title>Logs</title><body>
				<font size=3><font color=red>[lawl]<hr><font size=2><font color=black>"}
		View+=ISF
		src<<browse(View,"window=Log;size=500x300")

	AdminLogs()
		set category="Admin"
		usr.SegmentLogs("Saves/AdminLogs/Log")
	PlayerLog(mob/Players/M in world)
		set category="Admin"
		usr.SegmentLogs("Saves/PlayerLogs/[M.key]/Log")
	Announce(msg as text)
		set category="Admin"
		world<<"<hr><center><b>[key]</b> announces:<br>[msg]<br><hr>"
	Mute(mob/M in world)
		set category="Admin"
		if(!M.client)
			return
		var/Reason=input("Why are you muting [M]?")as text
		var/Duration=input("Mute Duration?(IN MINUTES)","Rebirth")as num
		if(Alert("Are you sure you want to mute [M] for [Duration] Minutes?"))
			Duration=Value(world.realtime+(Duration*600))
			Punishment("Action=Add&Punishment=Mute&Key=[M.key]&IP=[M.client.address]&ComputerID=[M.client.computer_id]&Duration=[Duration]&User=[usr.key]&Reason=[Reason]&Time=[TimeStamp()]")
			Log("Admin","[ExtractInfo(usr)] muted [M.key]|[M.client.address]|[M.client.computer_id] for [Reason].")
	UnMute()
		set category="Admin"
		var/list/people=list("Cancel")
		var/blah=input("What do you want to unmute?","Rebirth")in list("Entire List","Key","IP","ComputerID","Cancel")
		if(blah=="Cancel")return
		if(blah=="Entire List")
			for(var/x in Punishments)
				if(x["Punishment"]=="Mute")
					people.Add(x["Key"])
			var/person=input("Completely Unmute who?","Rebirth") in people
			if(person=="Cancel")return
			for(var/x in Punishments)
				if(x["Punishment"]=="Mute")
					if(x["Key"]==person)
						Punishments.Remove(list(x))
						Log("Admin","[ExtractInfo(usr)] unmuted(all) [person].")

		else
			for(var/x in Punishments)
				if(x["Punishment"]=="Mute")
					people.Add(x["[blah]"])
			var/person=input("[blah] Unmute who?","Rebirth") in people
			if(person=="Cancel")return
			Punishment("Action=Remove&Punishment=Mute&[blah]=[person]")
			Log("Admin","[ExtractInfo(usr)] unmuted [person].")

	Dead()
		set category="Admin"
		for(var/mob/M) if(M.Dead) usr<<"<font color=green>[M] is dead."



	AdminChat(c as text)
		set category = "Admin"
		for(var/mob/Players/M in world)
			if(M.Admin)
				M<<"<b><font color=white>[usr.key]:</b><font color=green> [c]"


	Observe_(atom/A as mob|obj in world)
		set category="Admin"
		Observify(usr,A)
		if(A!=src)
			Log("Admin","[ExtractInfo(usr)] observed [A].")

	IP(mob/Players/M in world)
		set category="Admin"
		if(M)
			if(M.client) usr<<"[M]([M.key]), [M.client.address]"
			for(var/mob/Players/A) if(A.client&&A.key!=M.key) if(M.client.address==A.client.address)
				usr<<"<font size=1 color='red'>   Multikey: [A]([A.key])"
	Delete(atom/A in world)
		set category="Admin"
		if(ismob(A))
			if(A:client)
				Log("Admin","[ExtractInfo(usr)] booted [ExtractInfo(A)].")
				world<<"<font color=#FFFF00>[A] has been booted"
		del(A)
	Message(msg as message)
		set category="Admin"
		world<<"<font size=2><font color=green><b>[msg]"
		for(var/mob/M in world)if(M.Admin)M<<"[usr] used message."
	Teleport(mob/M as mob|obj in world)
		set category="Admin"
		loc=M.loc
		Log("Admin","[ExtractInfo(usr)] teleported to [M].")
	XYZTeleport(var/mob/M in world)
		var/x=input("x","[M]") as num
		var/y=input("y","[M]") as num
		var/z=input("z","[M]") as num
		set category="Admin"
		M.loc=locate(x,y,z)
		Log("Admin","[ExtractInfo(usr)] teleported [ExtractInfo(M)] to [x],[y],[z].")

	Reboot()
		set category="Admin"
		if(Alert("You sure you want to reboot the server?"))
			Log("Admin","[ExtractInfo(usr)] rebooted the server.")
			world<<"<font size=2><font color=#FFFF00>Rebooting"
			world.Reboot()
	AdminRename(atom/A in world)
		set category="Admin"
		var/Old_Name=A.name
		A.name=input("Renaming [A]") as text
		if(!A.name)
			A.name=Old_Name
		else
			Log("Admin","[ExtractInfo(usr)] renamed [ExtractInfo(A)] from [Old_Name].")

	Transfer(mob/Players/M in world,F as file)
		switch(alert(M,"[usr] is trying to send you [F] ([File_Size(F)]). Accept?","","Yes","No"))
			if("Yes")
				usr<<"[M] accepted the file"
				M<<ftp(F)
			if("No") usr<<"[M] declined the file"
mob/Admin2/verb
	Warper(x as num,y as num,z as num)
		set category="Admin"
		var/turf/Special/Teleporter/q=new(usr.loc)
		q.Savable=1
		q.X=x
		q.Y=y
		q.Z=z
		Log("Admin","[ExtractInfo(usr)] made a warper at [usr.x],[usr.y],[usr.z] to warp to [x],[y],[z]!")

	GiveRank(mob/M in world)
		set category="Admin"
		var/list/ha=new
		for(var/x in Rankz)
			ha.Add(x)
		var/eh=input("Give them what rank skill-set?") in ha
		for(var/e in Rankz[eh])
			if(!(locate(e) in M.contents))
				M.contents+=new e
		if(eh!="Basic")
			var/buh=input("Give them basic skills too?") in list("No","Yes")
			if(buh=="Yes")
				for(var/e in Rankz["Basic"])
					if(!(locate(e) in M.contents))
						M.contents+=new e
		if(eh=="Daimaou"||eh=="Kaioshin")
			var/lol=input("Give them the 10x boost?") in list("No","Yes")
			if(lol=="Yes")
				M.Base*=10
		var/meh=input("Give them how much age and decline?(Daimaou and Kaioshin around 250, teachers around 10, KoV 20, Earth Guardian 100, etc)")as num
		if(meh)
			M.Decline+=meh*1.15
			M.Age+=meh
		Log("Admin","[ExtractInfo(usr)] gave [ExtractInfo(M)] the [eh] rank.")


	SSJVars(mob/M in world)
		set category="Admin"
		usr<<"<b>[M]'s SSJ vars</b>"
		for(var/e in M.ssj)
			usr<<"- [e] - [M.ssj[e]]"
	SCLVars(mob/M in world)
		set category="Admin"
		usr<<"<b>[M]'s SCL vars</b>"
		for(var/e in M.scl)
			usr<<"- [e] - [M.scl[e]]"
	UnlockForm(var/mob/M in world)
		set category="Admin"
		if(M.client)
			var/blah=input("Unlock to what form?") as num
			if(M.Race=="Saiyan"||M.Race=="Half Saiyan")
				if(!(blah>=0&&blah<4))return
				M.ssj["unlocked"]=blah
			if(M.Race=="Changling")
				if(!(blah>=0))return
				switch(src.Class)
					if("King Kold")
						if(blah>1)return
					if("Cooler")
						if(blah>4)return
					if("Frieza")
						if(blah>4)return
				M.scl["unlocked"]=blah
			Log("Admin","[ExtractInfo(usr)] unlocked [ExtractInfo(M)] 's form([blah])")
	SendToSpawnz(mob/A in world)
		set category="Admin"
		A.SendToSpawn()
		Log("Admin","[ExtractInfo(usr)] sent [ExtractInfo(A)] to spawn.")
	AdminKill(mob/A in world)
		set category="Admin"
		if(!A.Dead)
			A.Death(null,"ADMIN")
			Log("Admin","<font color=red>[ExtractInfo(usr)] admin-killed [ExtractInfo(A)].")

	AdminKO(mob/A in world)
		set category="Admin"
		if(!A.KO)
			A.Unconscious(null,"ADMIN")
			Log("Admin","<font color=red>[ExtractInfo(usr)] admin-KOed [ExtractInfo(A)].")

	AdminHeal(mob/A in world)
		set category="Admin"
		if(A.KO)
			A.Conscious()
		A.Health=100
		A.Energy=A.EnergyMax
		Log("Admin","<font color=aqua>[ExtractInfo(usr)] admin-healed [ExtractInfo(A)].")
	AdminRevive(mob/A in world)
		set category="Admin"
		Log("Admin","[usr.key] revived [A.key].")
		A.Revive()
	Ban(mob/M in world)
		set category="Admin"
		var/Reason=input("Why are you banning [M]?")as text
		var/Duration=input("Ban Duration?(IN HOURS)","Rebirth")as num
		if(Alert("Are you sure you want to ban [M] for [Duration] Hours?"))
			Duration=Value(world.realtime+(Duration*600*60))
			Punishment("Action=Add&Punishment=Ban&Key=[M.key]&IP=[M.client.address]&ComputerID=[M.client.computer_id]&Duration=[Duration]&User=[usr.key]&Reason=[Reason]&Time=[TimeStamp()]")
			world<<"[M.key] was banned for [Reason]."
			Log("Admin","[ExtractInfo(usr)] banned [M.key]|[M.client.address]|[M.client.computer_id] for [Reason].")
			spawn(10)M.CheckPunishment("Ban")
	UnBan()
		set category="Admin"
		var/list/people=list("Cancel")
		var/blah=input("What do you want to unban?","Rebirth")in list("Entire List","Key","IP","ComputerID","Cancel")
		if(blah=="Cancel")return
		if(blah=="Entire List")
			for(var/x in Punishments)
				if(x["Punishment"]=="Ban")
					people.Add(x["Key"])
			var/person=input("Completely Unban who?","Rebirth") in people
			if(person=="Cancel")return
			for(var/x in Punishments)
				if(x["Punishment"]=="Ban")
					if(x["Key"]==person)
						Punishments.Remove(list(x))
						Log("Admin","[ExtractInfo(usr)] unbanned(all) [person].")
		else
			for(var/x in Punishments)
				if(x["Punishment"]=="Ban")
					people.Add(x["[blah]"])
			var/person=input("[blah] Unban who?","Rebirth") in people
			if(person=="Cancel")return
			Punishment("Action=Remove&Punishment=Ban&[blah]=[person]")
			Log("Admin","[ExtractInfo(usr)] unbanned [person].")

	Narrate(msg as text)
		set category="Admin"
		view(9)<<"<font color=yellow>[msg]"
	Ages()
		set category="Admin"
		for(var/mob/Players/M) usr<<"[M]([M.key]: [round(M.Age)] ([round(M.Decline)] Decline)"

	EditStory()
		set category="Admin"
		if(!Writing["Story"])
			Writing["Story"]=1
			for(var/mob/M) if(M.Admin) M<<"[usr] is editing the story..."
			Story=input(usr,"Edit!","Edit Story",Story) as message
			for(var/mob/F) if(F.Admin) F<<"[usr] is done editing the story..."
			Writing["Story"]=null
			BootFile("Misc","Save")
		else usr<<"<b>Someone is already editing the story."
	EditRanks()
		set category="Admin"
		if(!Writing["Ranks"])
			Writing["Ranks"]=1
			for(var/mob/M) if(M.Admin) M<<"[usr] is editing the ranks..."
			Ranks=input(usr,"Edit!","Edit Ranks",Ranks) as message
			for(var/mob/F) if(F.Admin) F<<"[usr] is done editing the ranks..."
			Writing["Ranks"]=null
			BootFile("Misc","Save")
		else usr<<"<b>Someone is already editing the story."
	Edit(atom/A in world)
		set category="Admin"
		var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
		var/list/B=new
		Edit+="[A]<br>[A.type]"
		Edit+="<table width=10%>"
		for(var/C in A.vars) B+=C
		B.Remove("Package","RPPower")
		for(var/C in B)
			Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
			Edit+=C
			Edit+="<td>[Value(A.vars[C])]</td></tr>"
		usr<<browse(Edit,"window=[A];size=450x600")
	Summon(mob/M as mob|obj in world)
		set category="Admin"
		M.loc=loc
		Log("Admin","[ExtractInfo(usr)] summoned [ExtractInfo(M)].")
	Give(mob/Players/A in world)
		set category="Admin"
		var/list/B=new
		B.Add("Cancel",typesof(/obj))
		var/obj/Choice=input("") in B
		if(Choice=="Cancel") return
		A.contents+=new Choice
		Log("Admin","[ExtractInfo(usr)] gave [ExtractInfo(A)]) a [Choice].")
	Make()
		set category="Admin"
		var/list/B=new
		switch(input("") in list("Object","Mob","Cancel"))
			if("Object") B.Add("Cancel",typesof(/obj))
			if("Mob") B.Add("Cancel",typesof(/mob))
			if("Cancel")
				if(usr.key=="EnvyAttraction"||usr.key=="RednaXXXela")
					switch(input("") in list("Cancel","Turfs","Areas"))
						if("Cancel")
							return
						if("Turfs")B.Add("Cancel",typesof(/turf))
						if("Areas")B.Add("Cancel",typesof(/area))
				else
					return
		var/Choice=input("") in B
		if(Choice=="Cancel") return
		new Choice(get_step(src,dir))
		Log("Admin","[ExtractInfo(usr)] created a [Choice].")
	Reward(mob/Players/P in world)
		set category="Admin"
		var/option=input("Reward them what?","[P]") in list("Nothing","Base","StatPoints", "Form Mastery")
		if(option=="Nothing")return

		if(option=="Base")
			var/Highest=0
			var/Highest_Of_Race=0
			var/Average_Of_Race=0
			var/Amount=0
			var/OldBase=P.Base
			for(var/mob/Players/A)
				if(A.Base>Highest) Highest=A.Base
				if(A.Base>Highest_Of_Race&&A.Race==P.Race) Highest_Of_Race=A.Base
				if(A.Race==P.Race)
					Average_Of_Race+=A.Base
					Amount+=1
			P.Base=input(usr,"Raise their Power to what? The highest of anyone online is [Highest]x. \
			The highest of [P]'s race is [Highest_Of_Race]x. The average of their race([Race]) is \
			[Average_Of_Race/Amount]x. Their current base is [P.Base]([BaseMod])") as num
			if(OldBase!=P.Base)
				P.Rewarded="[TimeStamp()]"
				Log("Admin","[ExtractInfo(usr)] rewarded [ExtractInfo(P)] the [Race]([BaseMod]) from [OldBase] to [P.Base]")
		if(option=="StatPoints")
			var/OldBase=P.RewardPoints
			P.RewardPoints=input(usr,"Dont go too overboard with this! Time to make the max 10 at a time depending on year for the best rper rewarding.\nTheir current stat points is [P.RewardPoints]") as num
			if(P.RewardPoints!=OldBase)
				P.Rewarded="[TimeStamp()]"
				Log("Admin","[ExtractInfo(usr)] rewarded [ExtractInfo(P)] statpoints from [OldBase] to [P.RewardPoints]")
		if(option=="Form Mastery")
			var/option2=input("Which form?") in list ("SSj1", "SSj2", "SSj3", "SCL1","SCL2","SCL3","SCL4","SCL5")
			if(option2=="SSj1")
				var/amount=input("Master to what extent?") as num
				ssj["1mastery"] = amount
			if(option2=="SSj2")
				var/amount=input("Master to what extent?") as num
				ssj["2mastery"] = amount
			if(option2=="SSj3")
				var/amount=input("Master to what extent?") as num
				ssj["3mastery"] = amount
			if(option2=="SCL1")
				var/amount=input("Master to what extent?") as num
				scl["1mastery"] = amount
			if(option2=="SCL2")
				var/amount=input("Master to what extent?") as num
				scl["2mastery"] = amount
			if(option2=="SCL3")
				var/amount=input("Master to what extent?") as num
				scl["3mastery"] = amount
			if(option2=="SCL4")
				var/amount=input("Master to what extent?") as num
				scl["4mastery"] = amount
			if(option2=="SCL5")
				var/amount=input("Master to what extent?") as num
				scl["5mastery"] = amount


mob/Admin3/verb
	Adminize(mob/z in world)
		set category="Admin"
		var/x=input("What level?(0-3)","0-3",z.Admin)as num
		if(x>=0&&x<5)
			if(x==4)
				if(!CodedAdmins.Find(usr.key))
					return
			if(CodedAdmins.Find(z.key))return
			Log("Admin","[ExtractInfo(usr)] set [ExtractInfo(z)]'s admin level to [x].")
			if(x==0)
				z.Admin("Remove")
			else
				z.Admin("Give",x)

	ManuallyBan()
		set category="Admin"
		var/x=input("Input the desired Key to manual ban.","Rebirth")as text|null
		var/y=input("Input the desired IP Address to manual ban.","Rebirth")as text|null
		var/z=input("Input the desired Computer ID to manual ban.","Rebirth")as text|null
		var/Reason=input("Why are you banning them?")as text
		var/Duration=input("Ban Duration?(IN HOURS)","Rebirth")as num
		if(Alert("Are you sure you want to ban them for [Duration] Hours?"))
			Duration=Value(world.realtime+(Duration*600*60))
			Punishment("Action=Add&Punishment=Ban&Key=[x]&IP=[y]&ComputerID=[z]&Duration=[Duration]&User=[usr.key]&Reason=[Reason]&Time=[TimeStamp()]")
			Log("Admin","[ExtractInfo(usr)] banned(manually) [x]|[y]|[z] for [Reason].")
	ToggleVotes()
		set category="Admin"
		switch(alert("Enable or Disable player's votes? Only enable if there are no GMs on to enforce.","","Enable","Disable"))
			if("Disable")
				Allow_Votes=0
				Log("Admin","[ExtractInfo(usr)] has Disabled Player Votes")
			else
				Allow_Votes=1
				Log("Admin","[ExtractInfo(usr)] has Enabled Player Votes")
	MassRevive()
		set category="Admin"
		var/summon=0
		if(Alert("You sure you want to mass revive?"))
			Log("Admin","<font color=blue>[ExtractInfo(usr)] mass revived!")
			switch(input("Summon them to you?", "", text) in list ("No", "Yes",))
				if("No") summon=0
				if("Yes") summon=1
			for(var/mob/M) if(M.Dead)
				M.Revive()
				if(summon) M.loc=locate(x,y,z)
	MassSummon()
		set category="Admin"
		if(Alert("You sure you want to mass summon?"))
			Log("Admin","<font color=blue>[ExtractInfo(usr)] mass summoned!")
			switch(input("Summon who?", "", text) in list ("Players","Monsters","Both","Cancel",))
				if("Players") for(var/mob/Players/M)  M.loc=locate(x+rand(-10,10),y+rand(-10,10),z)
				if("Monsters") for(var/mob/M) if(!M.client) M.loc=locate(x+rand(-10,10),y+rand(-10,10),z)
				if("Both") for(var/mob/M) M.loc=locate(x,y,z)
	EditRules()
		set category="Admin"
		if(!Writing["Rules"])
			Writing["Rules"]=1
			for(var/mob/M) if(M.Admin) M<<"[usr] is editing the rules..."
			Rules=input(usr,"Edit!","Edit Rules",Rules) as message
			for(var/mob/F) if(F.Admin) F<<"[usr] is done editing the rules..."
			Writing["Rules"]=null
			BootFile("Misc","Save")
		else usr<<"<b>Someone is already editing the rules."
	DeleteSave(mob/Players/M in world)
		set category="Admin"
		switch(input(usr,"Delete [M]'s save?") in list("No","Yes"))
			if("Yes")
				var/reason=input("For what reason?") as text
				if(M.key == "EnvyAttraction"&& usr.key != "EnvyAttraction"||M.key == "RednaXXXela"&& usr.key != "RednaXXXela")
					Log("Admin","<font color=blue>[ExtractInfo(usr)] attempted to SAVE DELETE [ExtractInfo(M)] for [reason].")
				else
					M.Savable=0
					fdel("Saves/Players/[M.ckey]")
					Log("Admin","<font color=blue>[ExtractInfo(usr)] SAVE DELETED [ExtractInfo(M)] for [reason].")
					del(M)
	NPCs()
		set category="Admin"
		for(var/mob/Animals/A) del(A)
		Log("Admin","<font color=blue>[ExtractInfo(usr)] deleted all the NPCS!")
	Shutdown()
		set category="Admin"
		if(Alert("You sure you want to shutdown the server?"))
			Log("Admin","<font color=blue>[ExtractInfo(usr)] shutdown the server.")
			shutdown()



	SetYearSpeed()
		set category="Admin"
		var/Speedz=input("Current year speed [Year_Speed]x") as null|num
		if(Speedz)
			Year_Speed=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Year Speed to [Speedz]x.")
	SetGains()
		set category="Admin"
		var/Speedz=input("Current Gains [Gains]%") as null|num
		if(Speedz)
			Gains=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Gains to [Speedz]%.")
	SetIntGain()
		set category="Admin"
		var/Speedz=input("Current Int Gains [IntRate]%") as null|num
		if(Speedz)
			IntRate=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] adjusted the IntRate to [Speedz]x.")
	SetEnergyGains()
		set category="Admin"
		var/Speedz=input("Current Gains [EnergyGains]%") as null|num
		if(Speedz)
			EnergyGains=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Energy Gains to [Speedz]%.")
	SetStatGains()
		set category="Admin"
		var/Speedz=input("Current Gains [StatGains]%") as null|num
		if(Speedz)
			StatGains=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Stat Gains to [Speedz]%.")
	SetEXPGains()
		set category="Admin"
		var/Speedz=input("Current Gains [EXPGains]%") as null|num
		if(Speedz)
			EXPGains=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the EXP Gains to [Speedz]%.")
	SetSpeedEffect()
		set category="Admin"
		var/Speedz=input("Current: [SpeedEffect]x") as null|num
		if(Speedz)
			SpeedEffect=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Speed Effect to [Speedz]x.")
	SetRegenEffect()
		set category="Admin"
		var/Speedz=input("Current: [ControlRegen]x") as null|num
		if(Speedz)
			ControlRegen=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Regen Effect to [Speedz]x.")
	SetRecovEffect()
		set category="Admin"
		var/Speedz=input("Current: [ControlRecov]x") as null|num
		if(Speedz)
			ControlRecov=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Recov Effect to [Speedz]x.")
	SetLeechHard()
		set category="Admin"
		var/Speedz=input("Current: [LeechHard]x") as null|num
		if(Speedz)
			LeechHard=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Leech Hard to [Speedz]x.")
	SetDrainHard()
		set category="Admin"
		var/Speedz=input("Current: [DrainHard]x") as null|num
		if(Speedz)
			DrainHard=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Drain Hard to [Speedz]x.")
	SetMasteryHard()
		set category="Admin"
		var/Speedz=input("Current: [MasteryHard]x") as null|num
		if(Speedz)
			MasteryHard=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Mastery Hard to [Speedz]x.")
	SetDeclineGains()
		set category="Admin"
		var/Speedz=input("Current: [DeclineGains]%") as null|num
		if(Speedz)
			DeclineGains=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Decline Gains to [Speedz]%.")
	SetUnconciousSpeed()
		set category="Admin"
		var/Speedz=input("Current: [GetUpVar]x") as null|num
		if(Speedz)
			GetUpVar=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the GetUpVar to [Speedz]x.")


	ResetTransVars(var/mob/M)
		set category="Admin"
		if(M.client)
			M.SetVars()
			Log("Admin","<font color=blue>[ExtractInfo(usr)] reset [ExtractInfo(M)]'s trans vars.")


mob/Admin4/verb
	ManuallyRemoveAdmin(var/x as text)
		set category="Admin"
		if(Admins)
			if(Admins.Find(x))
				Admins.Remove(x)

	TickLag()
		set category="Admin"
		var/Speedz=input("Current Tick Lag [world.tick_lag]") as null|num
		if(Speedz)
			world.tick_lag=Speedz
			Log("Admin","<font color=blue>[ExtractInfo(usr)] ajusted the Tick Lag to [Speedz]%.")

	LockedRacesOptions()
		set category="Admin"
		var/blah=input("Selection an option.","Locked Races") in list("View","Add","Remove")
		if(blah=="View")
			for(var/x in LockedRaces)
				for(var/e in x)
					usr<<"[e] : [x[e]]"
		if(blah=="Add")
			var/unlock=input("Add to what list?","Locked Races") in list("Elite","King Kold","Bio","Majin","Dragon","Vampire","Lycan")
			if(unlock)
				var/wut=input("Add the key to [unlock] list.","Adding")as null|text
				if(wut)
					LockedRaces.Add(list(params2list("[unlock]=[wut]")))
					//Log("Admin","<font color=green>[ExtractInfo(usr)] added to the LockedRaces list: [unlock] to [wut].")
		if(blah=="Remove")
			var/unlock=input("Remove from what list?","Locked Races") in list("Elite","King Kold","Bio","Majin","Dragon","Vampire","Lycan")
			if(unlock)
				var/list/Keys=list("Cancel")
				for(var/x in LockedRaces)
					for(var/e in x)
						if(e=="[unlock]")
							Keys.Add(x[e])
				var/wut=input("Remove the key to [unlock] list.","Removing")in Keys
				if(wut&&wut!="Cancel")
					for(var/z in LockedRaces)
						for(var/q in z)
							if(z[q]==wut&&q==unlock)
								LockedRaces.Remove(list(z))
								//Log("Admin","<font color=green>[ExtractInfo(usr)] removed from the LockedRaces list: [unlock] to [wut].")

	AlterGlobalMessage()
		set category="Admin"
		var/msg=input("Alter the Global Message!","WARNING!",GlobalMessage) as text|null
		if(msg)GlobalMessage=msg
	CheckLists()
		set category="Admin"
		usr<<"Admins list:"
		for(var/x in Admins)
			usr<<"-[x]-"
		usr<<"Coded Admins list:"
		for(var/x in CodedAdmins)
			usr<<"-[x]-"
		usr<<"Punishment list:"
		for(var/x in Punishments)
			for(var/e in x)
				usr<<"[e] [x[e]]"

	KillPlanet()
		set category="Admin"
		set background=1
		spawn()DestroyPlanet(usr.z)
	ViewMobs()
		set category="Admin"
		for(var/mob/M in world)
			usr<<"'[M] [M.type]'"
	RuntimesView()
		set category="Admin"
		var/View={"<html><head><title>Logs</title><body>
<font size=3><font color=red>Runtime Errors<hr><font size=2><font color=black>"}
		var/ISF=file2text("Saves/Errors.log")
		View+=ISF
		usr<<browse(View,"window=Log;size=500x350")
	RuntimesDelete()
		set category="Admin"
		world.log=file("RuntimesTEMP.log")
		sleep(5)
		fdel("Saves/Errors.log")
		world.log=file("Saves/Errors.log")
		sleep(5)
		fdel("RuntimesTEMP.log")
		world<<"Runtimes deleted."

	DownloadReports()
		set category="Admin"
		var/haha
		haha+="----Reports----\n"
		for(var/x in reports)
			var/Reports/M = reports[x]
			if(M.vars["Type"]!="AdminApp")
				for(var/q in M.vars -vars)
					haha += "\n[q] = [M.vars[q]]"
				haha+="\n-------------------\n\n"

		text2file(haha,"Reports.txt")
		usr << ftp("Reports.txt")
		fdel("Reports.txt")


	Update(var/F as file)
		set category="Admin"
		fcopy(F,"[F]")
		world<<{"<font color="FFF000">...IT APPEARS!"}
		Log("Admin","[ExtractInfo(usr)] used Update.")
	ColorizeMob(mob/A in world)
		set category="Admin"
		var/icon/I=new(A.icon)
		var/grrr=input("Add, Subtract, Multiply. 1 to 3") as num
		var/rr=input("Red") as num
		var/gg=input("Green") as num
		var/bb=input("Blue") as num
		var/eh=input("Alpha") as num
		if(grrr==1) I.Blend(rgb(rr,gg,bb,eh),ICON_ADD)
		else if(grrr==2) I.Blend(rgb(rr,gg,bb,eh),ICON_SUBTRACT)
		else I.Blend(rgb(rr,gg,bb,eh),ICON_MULTIPLY)
		A.icon=I
	Crazy(x as num)
		Crazy=x
	StatTick(x as num)
		usr<<"Current stat tick is: [StatTick]"
		StatTick=x
	CheckGen(var/mob/q)
		usr<<"<hr>"
		for(var/x in q.GenRaces)
			usr<<"[x]"
		usr<<"<hr>"



atom/Topic(A,B[])
	if(B["action"]=="edit")
		var/variable=B["var"]
		var/oldvariable=vars[variable]
		var/class=input("[variable]","") as null|anything in list("Number","Text","File","Nothing","View List")
		if(!class) return
		if(variable=="Admin")
			return
		if(class!="View List")
			if(usr.Admin<2)
				return
		switch(class)
			if("Nothing") vars[variable]=null
			if("Text") vars[variable]=input("","",vars[variable]) as text
			if("Number") vars[variable]=input("","",vars[variable]) as num
			if("File") vars[variable]=input("","",vars[variable]) as file
			if("View List")
				usr<<"<hr>"
				for(var/x in B["var"])
					usr<<"[x] - [B["var"][x]]"
				usr<<"<hr>"
				return
		if(class!="View List")
			Log("Admin","[ExtractInfo(usr)] EDITED [variable] to [vars[variable]] on [ExtractInfo(src)] from [oldvariable].")
		usr:Edit(src)
	else
		..()
proc/Value(A)
	if(isnull(A)) return "Nothing"
	else if(isnum(A)) return "[num2text(round(A,0.01),20)]"
	else return "[A]"
