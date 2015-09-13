var/list/Alliance=new
var/list/Noobs=new
obj/Alliance
	desc="This is the Roleplayer Alliance. It is a group that protects roleplayers from noobs who pose an OOC \
	threat to other players. They recruit only members who will follow the game rules and not make up their own \
	reasons to noob people. They noob people who OOC attack, steal, kill, or trap others. Abusive members who do \
	anything else other than the aforementioned things are removed without mercy and without a second chance. \
	Second chances for noobs or abusive alliance members will cause the alliance to fail, because if abusive \
	members are left in they will invite 10x more abusive members and they will overthrow the good members. \
	You have been warned, when someone messes up don't listen to their excuses, just remove them. 'I didn't know' \
	is not an excuse. If they didn't know then they shouldn't have been in alliance. And since they didn't take \
	time to find out the rules of alliance before noobing someone, they should never be invited back."
	var/Chat_On=1
	New() spawn for(var/mob/Players/P) if((src in P)&&!(P.key in Alliance)) Alliance+=P.key
	verb/AllianceOptions()
		set category="Other"
		switch(input("") in list("Add Member","Remove Member","Add Noob","Remove Noob","Member List","Noob List",\
		"Cancel"))
			if("Cancel") return
			if("Add Member")
				var/list/Choices=new
				Choices+="Cancel"
				for(var/mob/Players/P) Choices+=P.key
				var/Choice=input("") in Choices
				if(!Choice||Choice=="Cancel") return
				if(Choice in Noobs)
					usr<<"You cannot invite a noob into the alliance"
					return
				if(!(Choice in Alliance)) Alliance+=Choice
				for(var/mob/Players/P)
					if(P.key==Choice&&!(locate(type) in P)) P.contents+=new type
					if(P.key in Alliance) P<<"[usr.key] invited [Choice] to the Roleplayer Alliance"
				BootFile("Alliance","Save")
			if("Remove Member")
				var/list/Choices=new
				Choices.Add("Cancel",Alliance)
				var/Choice=input("") in Choices
				if(!Choice||Choice=="Cancel") return
				for(var/mob/Players/P)
					if(P.key in Alliance) P<<"[usr.key] removed [Choice] from Alliance"
					if(P.key==Choice) for(var/obj/Alliance/A in P) del(A)
				Alliance-=Choice
				BootFile("Alliance","Save")
			if("Add Noob")
				var/list/Noobables=new
				Noobables+="Cancel"
				for(var/mob/Players/A) Noobables+=A.key
				var/A=input("Choose") in Noobables
				if(!A||A=="Cancel") return
				if(A in Noobs)
					usr<<"They are already a noob"
					return
				for(var/mob/Players/B) if(Admins.Find(B)||locate(type) in B)
					B<<"[usr.key] noobified [A]"
				Noobs+=A
				for(var/mob/Players/P) if(P.key==A) for(var/obj/Alliance/C in P) del(C)
				Alliance-=A
				BootFile("Alliance","Save")
			if("Remove Noob")
				var/list/Choices=new
				Choices.Add("Cancel",Noobs)
				var/Choice=input("Remove who from the noob list?") in Choices
				if(!Choice||Choice=="Cancel") return
				for(var/mob/Players/A) if(Admins.Find(A)||locate(type) in A)
					A<<"[usr.key] just un-noobified [Choice]"
				Noobs-=Choice
				BootFile("Alliance","Save")
			if("Member List") for(var/A in Alliance) usr<<"[A]"
			if("Noob List") for(var/A in Noobs) usr<<"[A]"
	verb/RPOOC(A as text)
		set category="Other"
		for(var/mob/Players/B)
			for(var/obj/Alliance/C in B)
				if(C.Chat_On)
					B<<{"<font color="#82CAFF"><b>(Alliance)</b> [usr.key]: [html_encode(A)]"}
	verb/Alliance_Chat_Toggle()
		set category="Other"
		if(Chat_On)
			Chat_On=0
			usr<<"Alliance Chat Off"
		else
			Chat_On=1
			usr<<"Alliance Chat On"