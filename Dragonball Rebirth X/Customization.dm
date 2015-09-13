mob/Players/verb
	Customize()
		set category="Other"
		usr.Grid("Blasts","Auras","Charges")
		src.Auraz("Remove")
	Hair()
		set category="Other"
		usr.Hairz("Remove")
		usr.Grid("Hair")
	Clothes()
		set category="Other"
		usr.Grid("Clothes")

mob/proc/Auraz(var/Z)
	for(var/obj/Skills/PowerControl/M in src.contents)
		if(Z=="Add")
			src.Auraz("Remove")
			if(src.ssj["active"])
				if(src.ssj["active"]>0)
					src.overlays+=image('AurasBig.dmi',"SSJ",pixel_x=-32)
					return
			src.overlays += image(M.sicon,M.sicon_state)
		if(Z=="Remove")
			src.overlays -= image(M.sicon,M.sicon_state)
			src.overlays-=image('AurasBig.dmi',"SSJ",pixel_x=-32)
			src.overlays-=image('AurasBig.dmi',"LSSJ",pixel_x=-32)

mob/proc/Chargez(var/Z)
	if(Z=="Add")
		src.overlays -= image(ChargeIcon)
		src.overlays += image(ChargeIcon)
	if(Z=="Remove")
		src.overlays -= image(ChargeIcon)



mob/proc/Hairz(var/Z)
	if(Z=="Add")
		if(src.Tail)
			Tail(1)
		src.Hairz("Remove")
		Hair=Hair_Base
		if(Hair_Color) Hair+=Hair_Color
		if(src.ssj["active"]==1)
			src.overlays += image(Hair_SSJ1)
		else if(src.ssj["active"]==2)
			src.overlays += image(Hair_SSJ2)
		else if(src.ssj["active"]==3)
			src.overlays += image(Hair_SSJ3)
		else
			src.overlays += image(Hair)
	if(Z=="Remove")
		src.overlays -= image(Hair)
		src.overlays -= image(Hair_SSJ1)
		src.overlays -= image(Hair_SSJ2)
		src.overlays -= image(Hair_SSJ3)


mob/var
	Hair
	Hair_Base
	Hair_Color
	Hair_SSJ1
	Hair_SSJ2
	Hair_SSJ3
	SCLForm_1
	SCLForm_2
	SCLForm_3
	SCLForm_4
	SCLForm_5
	SCLForm_6


mob/proc/Hair_Forms()
	Hair_SSJ1=null
	Hair_SSJ2=null
	Hair_SSJ3=null
	if(src.Race=="Saiyan"||src.Race=="Half Saiyan")
		Hair_SSJ3='Hair_SSj3.dmi'
		switch(src.Hair_Base)
			if('Hair1.dmi')
				Hair_SSJ1='Hair1_SSj.dmi'
				Hair_SSJ2='Hair1_USSj.dmi'
			if('Hair3.dmi')
				Hair_SSJ1='Hair3_SSj.dmi'
				Hair_SSJ2='Hair3_USSj.dmi'
			if('Hair4.dmi')
				Hair_SSJ1='Hair4_SSj.dmi'
				Hair_SSJ2='Hair4_USSj.dmi'
			if('Hair7.dmi')
				Hair_SSJ1='Hair7_SSj.dmi'
				Hair_SSJ2='Hair7_USSj.dmi'
			if('Hair9.dmi')
				Hair_SSJ1='Hair9_SSj.dmi'
				//Hair_SSJ2='Hair9_SSj.dmi'//bah
			if('Hair12.dmi')
				Hair_SSJ1='Hair12_SSj.dmi'
				//Hair_SSJ2='Hair12_SSj.dmi'//bah
			if('Hair13.dmi')
				Hair_SSJ1='Hair13_SSj.dmi'
				//Hair_SSJ2='Hair13_SSj.dmi'//bah
			if('Hair15.dmi')
				Hair_SSJ1='Hair15_SSj.dmi'
				Hair_SSJ2='Hair15_USSj.dmi'
			if('HairF4.dmi')
				Hair_SSJ1='HairF4_SSj.dmi'
				Hair_SSJ2='HairF_USSj.dmi'
		if(Hair_Base)
			if(Hair_SSJ1==null)
				if(Hair_Base)
					var/icon/x=new(Hair_Base)
					if(x)
						x.Blend(rgb(153,153,5),ICON_ADD)
					Hair_SSJ1=x
			if(Hair_SSJ2==null)
				if(Hair_Base)
					var/icon/x=new(Hair_Base)
					if(x)
						x.Blend(rgb(150,150,-10),ICON_ADD)
					Hair_SSJ2=x

proc/Add_Customizations()
	for(var/A in typesof(/obj/Hairs)) if(A!=/obj/Hairs) Hair_List+=new A
	for(var/A in typesof(/obj/Items/Wearables)) if(A!=/obj/Items/Wearables) Clothes_List+=new A
	for(var/A in typesof(/obj/Charge_Icons)) if(A!=/obj/Charge_Icons) Charge_List+=new A
	for(var/A in typesof(/obj/Aura_Icons)) if(A!=/obj/Aura_Icons) Aura_List+=new A
	for(var/A in typesof(/obj/Blast_Icons)) if(A!=/obj/Blast_Icons) Blast_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Human)) if(A!=/obj/Creation_Icons/Human) Human_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Alien)) if(A!=/obj/Creation_Icons/Alien) Alien_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Demon)) if(A!=/obj/Creation_Icons/Demon) Demon_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Makyo)) if(A!=/obj/Creation_Icons/Makyo) Makyo_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Namekian)) if(A!=/obj/Creation_Icons/Namekian) Namekian_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Changling)) if(A!=/obj/Creation_Icons/Changling) Changling_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/SpiritDoll)) if(A!=/obj/Creation_Icons/SpiritDoll) SpiritDoll_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Kaio)) if(A!=/obj/Creation_Icons/Kaio) Kaio_List+=new A
	for(var/A in typesof(/obj/Creation_Icons/Android)) if(A!=/obj/Creation_Icons/Android) Android_List+=new A

var/list/Hair_List=new
obj/Hairs
	proc/Hair_Click(mob/A)
		if(A.IconClicked==0)
			A.IconClicked=1
			var/Color=input(A,"Choose color") as color|null
			if(Color) src.icon+=Color
			A.Hair_Base=initial(icon)
			A.Hair_Color=Color
			A.Hair_Forms()
			A.Hairz("Add")
			A.IconClicked=0
			winshow(usr,"Grid1",0)
			src.icon=initial(icon)
	Click() Hair_Click(usr)
	None
	Hair_1F
		icon='HairF1.dmi'
	Hair_2F
		icon='HairF2.dmi'
	Hair_3F
		icon='HairF3.dmi'
	Hair_4F
		icon='HairF4.dmi'
	Hair_5F
		icon='HairF5.dmi'
	Hair_6F
		icon='HairF6.dmi'
	Hair_7F
		icon='HairF7.dmi'
	Hair_1
		icon='Hair1.dmi'
	Hair_2
		icon='Hair2.dmi'
	Hair_3
		icon='Hair3.dmi'
	Hair_4
		icon='Hair4.dmi'
	Hair_5
		icon='Hair5.dmi'
	Hair_6
		icon='Hair6.dmi'
	Hair_7
		icon='Hair7.dmi'
	Hair_8
		icon='Hair8.dmi'
	Hair_9
		icon='Hair9.dmi'
	Hair_10
		icon='Hair10.dmi'
	Hair_11
		icon='Hair11.dmi'
	Hair_12
		icon='Hair12.dmi'
	Hair_13
		icon='Hair13.dmi'
	Hair_14
		icon='Hair14.dmi'
	Hair_15
		icon='Hair15.dmi'
	Hair_16
		icon='Hair16.dmi'
	Hair_17
		icon='Hair17.dmi'
	Hair_18
		icon='Hair18.dmi'
	Hair_19
		icon='Hair19.dmi'
	Hair_20
		icon='Hair20.dmi'
	Hair_21
		icon='Hair21.dmi'
	Hair_22
		icon='Hair22.dmi'
	Hair_23
		icon='Hair23.dmi'
	Hair_24
		icon='Hair24.dmi'
	Hair_25
		icon='Hair25.dmi'
	Hair_26
		icon='Hair26.dmi'
	Hair_27
		icon='Hair27.dmi'


mob/verb/ToggleInt(var/blah as text)
	set name=".ToggleInterface"
	set hidden=1
	switch(blah)
		if("Customization")
			winshow(usr,"Grid2",0)



mob/proc
	Grid(var/Z,var/X,var/E)
		if(istype(src,/mob/Creation))
			winshow(src,"Grid1",0)
			sleep()
			winshow(src,"Grid1",1)
		else
			winshow(src,"Grid2",0)
			sleep()
			winshow(src,"Grid2",1)
		winset(src,"GridZ","cells=0x0")
		sleep()
		winset(src,"GridX","cells=0x0")
		var/Row=0
		if(X=="Auras")
			if(locate(/obj/Skills/PowerControl,src.contents))
				for(var/A in Aura_List)
					Row++
					src<<output(A,"GridX:1,[Row]")
		if(E=="Charges")
			for(var/A in Charge_List)
				Row++
				src<<output(A,"GridX:1,[Row]")

		if(Z=="Clothes")
			for(var/A in Clothes_List)
				Row++
				src<<output(A,"GridX:1,[Row]")
		if(Z=="Hair")
			for(var/A in Hair_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
				else
					src<<output(A,"GridX:1,[Row]")
		if(Z=="Blasts")
			for(var/A in Blast_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
				else
					src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationHuman")
			for(var/A in Human_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
				else
					src<<output(A,"GridX:1,[Row]")
		if(Z=="CreationSD")
			for(var/A in SpiritDoll_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
				else
					src<<output(A,"GridX:1,[Row]")

		if(Z=="CreationDemon")
			for(var/A in Demon_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationAlien")
			for(var/A in Alien_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationNamekian")
			for(var/A in Namekian_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationMakyo")
			for(var/A in Makyo_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationChangling")
			for(var/A in Changling_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationKaio")
			for(var/A in Kaio_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")
		if(Z=="CreationAndroid")
			for(var/A in Android_List)
				Row++
				if(istype(usr,/mob/Creation))
					src<<output(A,"GridZ:1,[Row]")



var/list
	Human_List=new
	Alien_List=new
	Demon_List=new
	Namekian_List=new
	Makyo_List=new
	Changling_List=new
	SpiritDoll_List=new
	Kaio_List=new
	Android_List=new

obj/Creation_Icons
	proc/Creation_Click(mob/A)
		if(A.IconClicked==0)
			A.IconClicked=1
			if(A.Race=="Demi"||A.Race=="Alien"||A.Race=="Demon"||A.Race=="Spirit Doll"||A.Race=="Kaio")
				var/Icon_Color=input(A,"Choose color") as color|null
				if(Icon_Color) icon+=Icon_Color
			A.IconClicked=0
			A.icon=src
			winshow(A,"Grid1",0)
			if(A.Race=="Alien"||A.Race=="Human"||A.Race=="Saiyan"||A.Race=="Demi"||A.Race=="Half Saiyan"||A.Race=="Kaio")
				A.Grid("Hair")
			//else
			//	A.BodyType()
			icon=initial(icon)
	Click() Creation_Click(usr)
	Kaio
		Icon_1
			icon='CustomMale.dmi'
		Icon_2
			icon='CustomFemale.dmi'
	SpiritDoll
		Icon_1
			icon='SpiritDoll.dmi'
		Icon_2
			icon='SpiritDoll2.dmi'
	Human
		Icon_1
			icon='MaleLight.dmi'
		Icon_2
			icon='MaleTan.dmi'
		Icon_3
			icon='MaleDark.dmi'
		Icon_1Female
			icon='FemaleLight.dmi'
		Icon_2Female
			icon='FemaleTan.dmi'
		Icon_3Female
			icon='FemaleDark.dmi'
	Makyo
		Icon_1
			icon='Makyo1.dmi'
		Icon_2
			icon='Makyo2.dmi'
		Icon_3
			icon='Makyo3.dmi'
		Icon_4
			icon='Makyo4.dmi'
	Namekian
		Icon_1
			icon='Namek1.dmi'
		Icon_2
			icon='Namek2.dmi'
		Icon_3
			icon='Namek3.dmi'
		Icon_4
			icon='Namek4.dmi'
	Demon
		Icon_1
			icon='Demon1.dmi'
		Icon_2
			icon='Demon2.dmi'
		//Icon_3
		//	icon='Demon3.dmi'
		//	Click() Creation_Click(usr)
		Icon_4
			icon='Demon4.dmi'
		Icon_5
			icon='Demon5.dmi'
		Icon_6
			icon='Demon6.dmi'
		Icon_6Female
			icon='Demon6Female.dmi'
		Icon_7
			icon='Demon7.dmi'
		Icon_8
			icon='Demon8.dmi'
		Icon_9
			icon='Demon9.dmi'
	Android
		Icon_1
			icon='Android1.dmi'
		Icon_2
			icon='Android2.dmi'
		Icon_3
			icon='Android3.dmi'
		Icon_4
			icon='Android4.dmi'
		Icon_5
			icon='Android5.dmi'
		Icon_6
			icon='Android6.dmi'
		Icon_7
			icon='Android7.dmi'
		Icon_8
			icon='Android8.dmi'
		Icon_9
			icon='Android9.dmi'
		Icon_10
			icon='Android10.dmi'
	Alien
		Icon_1
			icon='Alien1.dmi'
		Icon_2
			icon='Alien2.dmi'
		Icon_3
			icon='Alien3.dmi'
		Icon_4
			icon='Alien4.dmi'
		Icon_5
			icon='Alien5.dmi'
		Icon_6
			icon='Alien6.dmi'
		Icon_7
			icon='Alien7.dmi'
		Icon_8
			icon='Alien8.dmi'
		Icon_9
			icon='Alien9.dmi'
		Icon_10
			icon='Alien10.dmi'
		Icon_10F
			icon='Alien10F.dmi'
		Icon_11
			icon='Alien11.dmi'
		Icon_12
			icon='Alien12.dmi'
		Icon_13
			icon='Alien13.dmi'
		Icon_14
			icon='Alien14.dmi'
		Icon_15
			icon='Alien15.dmi'
		Icon_16
			icon='Alien16.dmi'
		Icon_17
			icon='Alien17.dmi'
		Icon_18
			icon='Alien18.dmi'
		Icon_19
			icon='Alien19.dmi'
	Changling
		Frieza
			icon='Frieza1.dmi'
		Cooler
			icon='Cooler1.dmi'
		King_Kold
			icon='KingKold1.dmi'

var/list/Clothes_List=new

var/list/Aura_List=new
obj/Aura_Icons
	proc/Aura_Click(mob/A)
		if(A.IconClicked==0)
			A.IconClicked=1
			var/Aura_Color=input(A,"Choose color") as color|null
			if(Aura_Color) icon+=Aura_Color
			A.Auraz("Remove")
			for(var/obj/Skills/PowerControl/Z in A.contents)
				Z.sicon=src.icon
				Z.sicon_state=src.icon_state
			A.IconClicked=0
			icon=initial(icon)
	Click() Aura_Click(usr)
	Aura_1
		icon='Auras.dmi'
		icon_state="1"
	Aura_2
		icon='Auras.dmi'
		icon_state="2"
	Aura_3
		icon='Auras.dmi'
		icon_state="3"
	Aura_4
		icon='Auras.dmi'
		icon_state="4"
	Aura_5
		icon='Auras.dmi'
		icon_state="5"
	Aura_6
		icon='Auras.dmi'
		icon_state="6"
	Aura_7
		icon='Auras.dmi'
		icon_state="7"


var/list/Charge_List=new
obj/Charge_Icons
	proc/Charge_Click(mob/A)
		if(A.IconClicked==0)
			A.IconClicked=1
			var/Blast_Color=input(A,"Choose color") as color|null
			if(Blast_Color) icon+=Blast_Color
			A.ChargeIcon=image(src.icon,src.icon_state)
			A.IconClicked=0
			icon=initial(icon)
	Click() Charge_Click(usr)
	Charge_1
		icon='BlastCharges.dmi'
		icon_state="1"
	Charge_2
		icon='BlastCharges.dmi'
		icon_state="2"
	Charge_3
		icon='BlastCharges.dmi'
		icon_state="3"
	Charge_4
		icon='BlastCharges.dmi'
		icon_state="4"
	Charge_5
		icon='BlastCharges.dmi'
		icon_state="5"
	Charge_6
		icon='BlastCharges.dmi'
		icon_state="6"
	Charge_7
		icon='BlastCharges.dmi'
		icon_state="7"
	Charge_8
		icon='BlastCharges.dmi'
		icon_state="8"
	Charge_9
		icon='BlastCharges.dmi'
		icon_state="9"










var/list/Blast_List=new
obj/Blast_Icons
	proc/Blast_Click(mob/A)
		if(A.IconClicked==0)
			A.IconClicked=1
			var/Blast_Color=input(A,"Choose color") as color|null
			if(Blast_Color) icon+=Blast_Color
			switch(input(A,"Are you sure?") in list("Yes","No"))
				if("Yes")
					var/list/Skills=new
					Skills+="Cancel"
					for(var/obj/Skills/Attacks/B in A) Skills+=B
					var/obj/B=input(A,"Add icon to which skill?") in Skills
					if(isobj(B))
						B:sicon=icon
						B:sicon_state=icon_state
					A.IconClicked=0
				if("No")
					A.IconClicked=0
			icon=initial(icon)
	Click() Blast_Click(usr)
	Blast_1
		icon='Blasts.dmi'
		icon_state="1"
	Blast_2
		icon='Blasts.dmi'
		icon_state="2"
	Blast_3
		icon='Blasts.dmi'
		icon_state="3"
	Blast_4
		icon='Blasts.dmi'
		icon_state="4"
	Blast_5
		icon='Blasts.dmi'
		icon_state="5"
	Blast_6
		icon='Blasts.dmi'
		icon_state="6"
	Blast_7
		icon='Blasts.dmi'
		icon_state="7"
	Blast_8
		icon='Blasts.dmi'
		icon_state="8"
	Blast_9
		icon='Blasts.dmi'
		icon_state="9"
	Blast_10
		icon='Blasts.dmi'
		icon_state="10"
	Blast_11
		icon='Blasts.dmi'
		icon_state="11"
	Blast_12
		icon='Blasts.dmi'
		icon_state="12"
	Blast_13
		icon='Blasts.dmi'
		icon_state="13"
	Blast_14
		icon='Blasts.dmi'
		icon_state="14"
	Blast_15
		icon='Blasts.dmi'
		icon_state="15"
	Blast_16
		icon='Blasts.dmi'
		icon_state="16"
	Blast_17
		icon='Blasts.dmi'
		icon_state="17"
	Blast_18
		icon='Blasts.dmi'
		icon_state="18"
	Blast_19
		icon='Blasts.dmi'
		icon_state="19"
	Blast_20
		icon='Blasts.dmi'
		icon_state="20"
	Blast_21
		icon='Blasts.dmi'
		icon_state="21"
	Blast_22
		icon='Blasts.dmi'
		icon_state="22"
	Blast_23
		icon='Blasts.dmi'
		icon_state="23"
	Blast_24
		icon='Blasts.dmi'
		icon_state="24"
	Blast_25
		icon='Blasts.dmi'
		icon_state="25"
	Blast_26
		icon='Blasts.dmi'
		icon_state="26"
	Blast_27
		icon='Blasts.dmi'
		icon_state="27"
	Blast_28
		icon='Blasts.dmi'
		icon_state="28"
	Blast_29
		icon='Blasts.dmi'
		icon_state="29"
	Blast_30
		icon='Blasts.dmi'
		icon_state="30"
	Blast_31
		icon='Blasts.dmi'
		icon_state="31"
	Blast_32
		icon='Blasts.dmi'
		icon_state="32"
	Blast_33
		icon='Blasts.dmi'
		icon_state="33"
	Blast_34
		icon='Blasts.dmi'
		icon_state="34"
	Blast_35
		icon='Blasts.dmi'
		icon_state="35"
	Blast_36
		icon='Blasts.dmi'
		icon_state="36"
	Blast_37
		icon='Blasts.dmi'
		icon_state="37"
	Blast_38
		icon='Blasts.dmi'
		icon_state="38"
	Blast_39
		icon='Blasts.dmi'
		icon_state="39"
	Blast_40
		icon='Blasts.dmi'
		icon_state="40"
	Blast_41
		icon='Blasts.dmi'
		icon_state="41"
	Blast_42
		icon='Blasts.dmi'
		icon_state="42"
	Blast_43
		icon='Blasts.dmi'
		icon_state="43"
	Blast_44
		icon='Blasts.dmi'
		icon_state="44"
	Blast_45
		icon='Blasts.dmi'
		icon_state="45"
	Blast_46
		icon='Blasts.dmi'
		icon_state="46"
	Blast_47
		icon='Blasts.dmi'
		icon_state="47"
	Blast_48
		icon='Blasts.dmi'
		icon_state="48"
	Blast_49
		icon='Blasts.dmi'
		icon_state="49"
	Blast_50
		icon='Blasts.dmi'
		icon_state="50"
	Blast_51
		icon='Blasts.dmi'
		icon_state="51"
	Blast_52
		icon='Blasts.dmi'
		icon_state="52"
	Blast_53
		icon='Blasts.dmi'
		icon_state="53"
	Blast_54
		icon='Blasts.dmi'
		icon_state="54"
	Blast_55
		icon='Blasts.dmi'
		icon_state="55"
	Blast_56
		icon='Blasts.dmi'
		icon_state="56"
	Blast_57
		icon='Blasts.dmi'
		icon_state="57"
	Blast_58
		icon='Blasts.dmi'
		icon_state="58"
	Blast_59
		icon='Blasts.dmi'
		icon_state="59"
	Blast_60
		icon='Blasts.dmi'
		icon_state="60"
	Blast_61
		icon='Blasts.dmi'
		icon_state="61"
	Blast_62
		icon='Blasts.dmi'
		icon_state="62"
	Blast_63
		icon='Blasts.dmi'
		icon_state="63"
	Blast_64
		icon='Blasts.dmi'
		icon_state="64"
	Blast_65
		icon='Blasts.dmi'
		icon_state="65"
	Blast_66
		icon='Blasts.dmi'
		icon_state="66"
	Blast_67
		icon='Blasts.dmi'
		icon_state="67"
	Blast_68
		icon='Blasts.dmi'
		icon_state="68"
	Blast_69
		icon='Blasts.dmi'
		icon_state="69"
	Blast_70
		icon='Blasts.dmi'
		icon_state="70"
	Blast_71
		icon='Blasts.dmi'
		icon_state="71"
	Beam_1
		icon='Beam1.dmi'
		icon_state="head"
	Beam_2
		icon='Beam2.dmi'
		icon_state="head"
	Beam_3
		icon='Beam3.dmi'
		icon_state="head"
	Beam_4
		icon='Beam4.dmi'
		icon_state="head"
	Beam_5
		icon='Beam5.dmi'
		icon_state="head"
	Beam_6
		icon='Beam6.dmi'
		icon_state="head"
	//Beam_7
	//	icon='Beam7.dmi'
	Beam_8
		icon='Beam8.dmi'
		icon_state="head"
	Beam_9
		icon='Beam9.dmi'
		icon_state="head"
	Beam_10
		icon='Beam10.dmi'
		icon_state="head"
	Beam_11
		icon='Beam11.dmi'
		icon_state="head"
	Beam_12
		icon='Beam12.dmi'
		icon_state="head"
	Beam_13
		icon='Beam13.dmi'
		icon_state="head"
	Beam_14
		icon='Beam14.dmi'
		icon_state="head"
	Beam_15
		icon='Beam15.dmi'
		icon_state="head"
	Beam_16
		icon='Beam16.dmi'
		icon_state="head"
	Beam_17
		icon='Beam17.dmi'
		icon_state="head"
	Beam_18
		icon='Beam18.dmi'
		icon_state="head"



/*mob/proc/Customize_Stats(Amount)
	Tabs="Customize Stats"
	client.show_verb_panel=0
	while(Amount)
		switch(input(src,"Increase which stat? You have [Amount] points remaining.") in list("Strength","Endurance",\
		"Force","Resistance","Speed","Efficiency","Regeneration","Recovery","Offense","Defense"))
			if("Strength") StrengthMod+=initial(StrengthMod)*0.2
			if("Endurance") Endurance+=initial(Endurance)*0.2
			if("Force") Force+=initial(Force)*0.2
			if("Resistance") Resistance+=initial(Resistance)*0.2
			if("Speed") Speed+=initial(Speed)*0.2
			if("Efficiency") Efficiency+=initial(Efficiency)*0.2
			if("Regeneration") Regeneration+=initial(Regeneration)*0.2
			if("Recovery") Recovery+=initial(Recovery)*0.2
			if("Offense") Offense+=initial(Offense)*0.2
			if("Defense") Defense+=initial(Defense)*0.2
		Amount-=1*/