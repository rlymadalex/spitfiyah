mob/Players/verb
	UseRewardPoints()
		set category="Other"
		winshow(usr,"RewardStats",1)
		spawn()winset(usr,"RewardPoints","text=[RewardPoints]")
	SaveVerb()
		set hidden=1
		if(usr.Savable)
			if(!usr.SaveDelay)
				usr.SaveDelay=1
				usr<<"<b>Saving character...</b>"
				usr.client.SaveChar()
				usr<<"<b>Character saved!</b>"
				spawn(600)usr.SaveDelay=null
	AdminHelp(var/txt as text)
		set category="Other"
		usr<<"Message sent!"
		txt=html_encode(txt)
		txt=copytext(txt,1,1000)
		for(var/mob/Players/M in world)
			if(M.Admin)
				M<<"<font color=red>(ADMIN HELP)</font color> <a href=?src=\ref[usr];action=MasterControl;do=PM>[usr.key]</a href> [M.Controlz(usr)]: [txt]"
		usr<<"Admin message sent!"
	Examine(var/atom/A as mob|obj in view(usr))
		if(istype(A,/obj))
			if(A.desc)
				src<<A.desc
		else
			usr<<"This is: [A]"




	ScreenSize()
		set category="Other"
		var/screenx=input("Enter the width of the screen, max is 31.") as num
		screenx=min(max(1,screenx),31)
		var/screeny=input("Enter the height of the screen, max is 31.") as num
		screeny=min(max(1,screeny),31)
		client.view="[screenx]x[screeny]"
	Warp()
		set category="Other"
		src.Warp=!src.Warp
		if(src.Warp) usr<<"You turn your Warp <font color=green>on</font color>."
		else usr<<"You turn your Warp <font color=red>off</font color>."


	Races()
		set category="Other"
		var/list/lolz=new
		for(var/mob/Players/Q in world)
			if(!(lolz.Find(Q.Race)))
				lolz.Add("[Q.Race]")
				lolz["[Q.Race]"]=1
			else
				lolz["[Q.Race]"]++
		if(lolz)
			for(var/x in lolz)
				usr<<"[x] - [lolz[x]]"
	Countdown()
		set category="Other"
		var/time=60*10
		src.OMessage(10,"[src] is counting down! ([time/10] seconds)","<font color=silver>[src]([src.key]) used countdown.")
		spawn(time)	src.OMessage(10,"[src] ended counting down! (0 seconds)","<font color=silver>[src]([src.key]) ended using countdown.")
		spawn(time/2)	src.OMessage(10,"[src] counting down! ([time/2/10] seconds)")
	SkillSheet()
		set name="Skill Sheet"
		set category="Other"
		var/html={"<html><head><title>Skill Sheet</title></head><body><font face="Arial" size=2>"}
		for(var/obj/Skills/x in usr.contents)
			usr << browse_rsc(icon(x.icon,x.icon_state),"[x.name]")
			html+={"<img src="[x.name]">"}
			html+={"<ul><li><b>Name:</b> [x.name]</li>"}
			html+={"<li><b>Description: [x.desc]</b> "}
			html+={"<li><b>Mastery:</b> "}
			if(istype(x,/obj/Skills/Rank/Zanzoken))
				html+="[usr.ZanzokenSkill]x"
			else if(istype(x,/obj/Skills/Rank/Kaioken))
				html+="[usr.KaiokenMastery]x"
			else if(istype(x,/obj/Skills/Fly))
				html+="[usr.FlySkill]x"
			else
				html+="[x.Level]%"

			html+="</li></ul> <br>"
		html+="</body></html>"
		usr<<browse(html,"window=Skill;size=450x650")
	TextColor()
		set category="Other"
		if(locate(/obj/Communication) in usr)
			for(var/obj/Communication/C in usr)
				C.Text_Color=input(usr,"Choose a color for OOC and Say.") as color
	VotingControl()
		set category="Other"
		var/blah=input("Choose an option.","Control Panel") in list("Vote Mute","Vote Boot","Cancel")
		switch(blah)
			if("Vote Mute")
				usr.VoteMute()
			if("Vote Boot")
				usr.VoteBoot()
	Admins()
		set category="Other"
		var/list/admins=new
		admins.Add(Admins,CodedAdmins)
		for(var/x in admins)
			for(var/mob/M in world)
				if(M.client)
					if(M.key==x)
						usr<<"[x] | [admins[x]]<font color=green> (Online)"
						admins.Remove(x)
		admins.Remove(CodedAdmins)
		for(var/y in admins)
			usr<<"[y] | [admins[y]]"

	Who()
		set category="Other"
		var/View={"<html><head><title>Who</title><body>
<font size=3><font color=red>Player Panel:<hr><font size=2><font color=black>"}
		var/list/people=new
		for(var/mob/M in world)
			if(M.client)
				people.Add(M.key)
		var/list/sortedpeople=dd_sortedTextList(people,0)
		var/online=0
		if(usr.Admin)
			View+={"
					<table border=1 cellspacing=6>
					<tr>
					<th><font size=2>Key(IC Name)/Panel</th>
					<th><font size=2>IP Address(Computer ID)</th>
					<th><font size=2>Race(Class/Size)</th>
					<th><font size=2>Location</th>
					<th><font size=2>Base(BaseMod)/icon_state</th>
					<th><font size=2)Last Rewarded:</th>
					</tr>"}
			for(var/x in sortedpeople)
				for(var/mob/M in world)
					if(M.key==x)
						online++
						View+={"<tr>
							<td><font size=2>[M.key] ([M.name])/(<a href=?src=\ref[M];action=MasterControl>x</a href>)</td>
							<td><font size=2>[M.client.address] ([M.client.computer_id])</td>
							<td><font size=2>[M.Race] ([M.Class]/[M.BodyType])</td>
							<td><font size=2>[M.loc] ([M.x],[M.y],[M.z])</td>
							<td><font size=2>[M.Base]([M.BaseMod])/ [M.icon_state]</td>
							<td><font size=2>[M.Rewarded]</td>
							</tr>"}
						break
			View+={"</table"><br>"}
		else

			for(var/x in sortedpeople)
				online++
				View+="[x]<br>"
		View+="<font color=green><b>Online:</b> [online]"
		usr<<browse("[View]","window=Logzk;size=850x450")
	Overlays()
		set category="Other"
		usr.overlays-=usr.overlays
		usr.underlays-=usr.underlays
		if(usr.Dead)
			src.overlays+='Halo.dmi'

mob/proc/Controlz(var/mob/M)
	if(src.Admin)
		return "(<a href=?src=\ref[M];action=MasterControl>x</a href>)"


mob/proc/Say_Spark()
	var/image/A=image(icon='Say Spark.dmi',pixel_y=6)
	overlays+=A
	spawn(20) if(src) overlays-=A
var/Allow_OOC=1



var/list/crazyy=list(\
"YOU FUCKING NOOBS I'LL FUCKING KILL YOU ALL",
"FUCKING RIGHT, DAMN RIGHT, ALL RIGHT!",
"IF YOU DONT MOVE YOUR FUCKING ASS, I WILL FUCKING KILL YOU",
"DAT DRAG0N NUB CANT CODE FOR SHIT",
"WANNA HEAR A JOKE?!!? Archonex.",
"Oh yahhhhhhhhh!",
"Oh baby..that feels so good.....WTF? WHEN DID YOU GET HEERE?",
"AHH FUCKK IM CUMMINNNN",
"CA-CAN I RIDEEE YOUUU?",
"MY BOOBS ARE BOUNCY!",
"DONT FUCK WITH THE FUCKING COCKKK!",
"LEWISSS IS GAAYYYY",
"BEAMED IS A HOMOOOO",
"You coon skinned rainbow faggot.",
"IM NOT WORTHYYYY!",
"Im so depressed guys...get me a razor.",
"WHY WONT YOU LOVE ME?",
"I spread peanutbutter all overmyself this one time...",
"Amelieeee is oohhhh so sexxxi (:",
"CH-CH-CHERRY TIME?!",
"BECAUSE YOU TOUCH YOURSELF",
"Lets fall in loveee~ first one to fall, loses.....",
"GAME OVER!",
"Lilybooooo~",
"Kyle is gay and likes it up the butt.",
"Waylon is a two faced faggot (:",
"THAT COLD REAPER MOTHER FUCKER CAN SUCK MY FUCKIN LEFT NUT!",
"HELL YEAH HELL YEAH HELL YEAH!",
)

obj/Communication
	var/Text_Color="green"
	var/ShowOOC=1
	var/AdminAlerts=1
	var/Telepathy_Enabled=1
	verb/OOC(T as text)
		set category = "Other"
		set src=usr.contents
		if(OOC_Check(T))
			if(!usr.Admin) T=copytext(T,1,700)
			if(SpamCheck(usr,T))return
			if(Crazy)T=pick(crazyy)
			for(var/mob/Players/P)
				for(var/obj/Communication/C in P)
					if(C.ShowOOC)
						if(usr.DisplayKey)
							P<<{"<font color=green><b>OOC:<font color="[Text_Color]"> [usr.DisplayKey]</b>([usr.name])[P.Controlz(usr)]: <font color=white>[html_encode(T)]"}
						else
							P<<{"<font color=green><b>OOC:<font color="[Text_Color]"> [usr.key]</b>([usr.name])[P.Controlz(usr)]: <font color=white>[html_encode(T)]"}


			for(var/mob/Creation/P)
				if(usr.DisplayKey)
					P<<{"<font color=green><b>OOC:<font color="[Text_Color]"> [usr.DisplayKey]</b>([usr.name])[P.Controlz(usr)]: <font color=white>[html_encode(T)]"}
				else
					P<<{"<font color=green><b>OOC:<font color="[Text_Color]"> [usr.key]</b>([usr.name])[P.Controlz(usr)]: <font color=white>[html_encode(T)]"}


	verb/Say(T as text)
		set category="Other"
		set src=usr.contents
		for(var/mob/E in hearers(12,usr))
			E<<"<font color=[Text_Color]>[usr][E.Controlz(usr)]: [html_encode(T)]"
			Log(E.ChatLog(),"<font color=green>[usr]([usr.key]) says: [html_encode(T)]")
		usr.Say_Spark()
	verb/Whisper(T as text)
		set category="Other"
		set src=usr.contents
		var/list/peepz=new
		for(var/mob/E in hearers(1,usr))
			E<<"<i><font color=[Text_Color]>[usr][E.Controlz(usr)] whispers</i>: [html_encode(T)]"
			Log(E.ChatLog(),"<font color=green>[usr]([usr.key]) WHISPERS: [html_encode(T)]")
			peepz.Add(E)
		for(var/mob/W in hearers(10,usr))
			if(W in peepz)continue
			W<<"<i><font color=[Text_Color]>[usr][W.Controlz(usr)] whispers</i>..."


	verb/Emote(T as message)
		set category="Other"
		set src=usr.contents
		for(var/mob/E in hearers(15,usr))
			E<<"<font color=yellow>*[usr.name][E.Controlz(usr)] [html_encode(T)]*"
			Log(E.ChatLog(),"<font color=red>*[usr]([usr.key]) [html_encode(T)]*")
		usr.Say_Spark()
	proc/OOC_Check(T)
		if(!Allow_OOC&&!(CodedAdmins.Find(usr.key)))
			usr<<"OOC is disabled."
			return 0
		if(usr.key in Mutes&&!(CodedAdmins.Find(usr.key)))
			usr<<"You are muted."
			return 0
		return 1
	verb/ToggleOOC()
		set category="Other"
		src.ShowOOC=!src.ShowOOC
		if(src.ShowOOC) usr<<"You turn your OOC <font color=green>on</font color>."
		else usr<<"You turn your OOC <font color=red>off</font color>."


	verb/Telepathy_Toggle()
		if(src.Telepathy_Enabled)
			usr<<"<font color=red>Telepathy messages off."
			src.Telepathy_Enabled=0
		else
			usr<<"<font color=green>Telepathy messages on."
			src.Telepathy_Enabled=1


mob/proc/OMessage(var/View=10,var/Msg,var/Log)
	for(var/mob/Players/E in hearers(View,src))
		if(Msg)
			E<<"[Msg]"
		if(Log)
			Log(E.ChatLog(),Log)
mob/var/tmp/Spam=0


proc/SpamCheck(var/mob/M,var/T)
	if(M.CheckPunishment("Mute"))
		return 1
	if(!M.Admin)
		M.Spam++
		spawn(20)if(M.Spam>0)M.Spam--
		if(findtext(T,"\n\n\n")||M.Spam>9)
			world<<"[M]([M.key]) was just BANNED for spamming!(Auto)"
			Punishment("Action=Add&Punishment=Ban&Key=[M.key]&IP=[M.client.address]&ComputerID=[M.client.computer_id]&Duration=[world.realtime+((10*60*60*24)*7)]&User=Auto&Reason=Spamming&Time=[TimeStamp()]")
		return 0