obj/Skills
	var/sicon
	var/sicon_state
	var/Big
	var/list/Learn=new
	icon='Skillz.dmi'
	var/Teachable=1
	verb/CustomChangeSkillIcon(Z as icon)
		set category="Other"
		src.sicon_state=input("icon state?") as text
		src.sicon=Z
		usr<<"[src] icon is now changed to: [src.sicon] / [src.sicon_state]"

	verb/Teach()
		set category="Skills"
		usr.Teach(src)
	proc/Skill_Increase(Amount=1)
		Level+=1/sqrt(Level)*Amount/MasteryHard
		Level=min(Level,100)
	Absorb
		Teachable=0
		Level=100
		icon_state="Absorb"
		desc="Allows you to absorb people for their power."
		verb/Absorb()
			set category="Skills"
			usr.SkillX("Absorb",src)

	Heal
		Learn=list("energyreq"=2000,"difficulty"=3)
		icon_state="Heal"
		desc="This allows you to heal people you are facing."
		verb/Heal()
			set category="Skills"
			usr.SkillX("Heal",src)
	Fly
		Level=100
		Learn=list("energyreq"=1000,"difficulty"=2)
		icon_state="Fly"
		desc="This allows you to fly while it constantly drains your energy."
		verb/Fly()
			set category="Skills"
			usr.SkillX("Fly",src)
	Regenerate
		Teachable=0
		Level=100
		icon_state="Regenerate"
		desc="This allows you to highten your regeneration at the loss of energy."
		verb/Regenerate()
			set category="Skills"
			usr.SkillX("Regenerate",src)
	NamekianFusion
		Teachable=0
		Level=100
		desc="Combine powers with another Namekian at a fatal price!"
		verb/Fuse()
			set category="Skills"
			usr.SkillX("NamekianFusion")
	Materialization
		Learn=list("energyreq"=2000)
		Level=100
		icon_state="Materialize"
		desc="This allows you to create weights out of thin air."
		verb/Materialization()
			set category="Skills"
			usr.SkillX("Materialize",src)
	SelfDestruct
		Learn=list("energyreq"=2000)
		Level=100
		desc="The ultimate sacrifice."
		verb/SelfDestruct()
			set name="Self Destruct"
			set category="Skills"
			usr.SkillX("SelfDestruct",src)
	FalseMoon
		Learn=list("energyreq"=2500)
		Level=100
		desc="Create a false moon."
		verb/FalseMoon()
			set name="False Moon"
			set category="Skills"
			usr.SkillX("FalseMoon",src)


	Attacks
		var/Charging=0
		var/ChargeRate=0

		WolfFangFist
			Learn=list("energyreq"=2000,"difficulty"=50)
			desc="The physical art of the wolf hermit!"
			verb/WolfFangFist()
				set name="Wolf Fang Fist"
				set category="Skills"
				usr.SkillX("WolfFangFist",src)
		HomingFinisher
			Learn=list("energyreq"=2000,"difficulty"=20)
			icon_state="HF"
			sicon='Blasts.dmi'
			sicon_state="67"
			Power=0.3
			Speed=7
			Efficiency=1
			Distance=20
			verb/HomingFinisher()
				set name="Homing Finisher"
				set category="Skills"
				usr.SkillX("HomingFinisher",src)
		Makosen
			Learn=list("energyreq"=500,"difficulty"=10)
			icon_state="Makosen"
			sicon='Blasts.dmi'
			sicon_state="29"
			Power=0.2
			Speed=10
			Efficiency=1
			Distance=10
			verb/Makosen()
				set category="Skills"
				usr.SkillX("Makosen",src)
		Sokidan
			Learn=list("energyreq"=500,"difficulty"=6)
			icon_state="Sokidan"
			sicon='Blasts.dmi'
			sicon_state="57"
			desc="Manipulates an orb of energy."
			verb/Sokidan()
				set category="Skills"
				usr.SkillX("Sokidan",src)
		SpiritGun
			Learn=list("energyreq"=3000,"difficulty"=9)
			icon_state="Blast"
			sicon='BlastSpiralingKi.dmi'
			Power=1
			Speed=1
			Efficiency=1
			Distance=10
			desc="Fires a powerful blast of ki from the index finger of a hand clenched like a gun."
			verb/SpiritGun()
				set category="Skills"
				usr.SkillX("Spirit Gun",src)

		Kienzan
			Learn=list("energyreq"=2500,"difficulty"=8)
			icon_state="Kienzan"
			sicon='Blasts.dmi'
			sicon_state="71"
			desc="Charges a powerful disc of energy."
			verb/Kienzan()
				set category="Skills"
				usr.SkillX("Kienzan",src)
		Charge
			Learn=list("energyreq"=1000,"difficulty"=1.5)
			icon_state="Charge"
			sicon='Blasts.dmi'
			sicon_state="5"
			Speed=1
			desc="Charges a powerful energy blast."
			verb/Charge()
				set category="Skills"
				usr.SkillX("Charge",src)

		Blast
			icon_state="Blast"
			sicon='Blasts.dmi'
			sicon_state="5"
			Power=1
			Speed=10
			Efficiency=1
			Distance=10
			verb/Blast()
				set category="Skills"
				usr.SkillX("Blast",src)

		Barrage
			icon_state="Barrage"
			sicon='Blasts.dmi'
			sicon_state="51"
			Power=1
			Speed=10
			Efficiency=1
			Distance=10
			verb/Barrage()
				set category="Skills"
				usr.SkillX("Barrage",src)

		Kikoho
			Learn=list("energyreq"=5000,"difficulty"=50)
			icon_state="Blast"
			sicon='BlastSpiralingKi.dmi'
			Power=1
			Speed=1
			Efficiency=1
			Distance=10
			verb/Kikoho()
				set category="Skills"
				usr.SkillX("Kikoho",src)

		Beams
			Learn=list("energyreq"=2500,"difficulty"=10)
			New()
				..()
				desc="Strength:[Power]<br>Speed:[Speed]<br>Draining Effiency:[Efficiency]<br>Distance:[Distance]<br>Charge: [ChargeRate]"
			icon='Skillz.dmi'
			icon_state="Beam"
			Beam
				Power=1
				Speed=1
				Efficiency=1
				ChargeRate=0.1
				Distance=10
				sicon='Beam5.dmi'
				verb/Beam()
					set category="Skills"
					usr.SkillX("Beam",src)

			FinalFlash
				Power=3.5
				Speed=3
				Efficiency=0.5
				Distance=10
				ChargeRate=0.4
				sicon='Beam9.dmi'
				verb/FinalFlash()
					set category="Skills"
					set name="Final Flash"
					usr.SkillX("Beam",src)
			GalicGun
				Power=2.5
				Speed=6
				Efficiency=1.5
				Distance=9
				ChargeRate=2
				Big=1
				sicon='BeamBig2.dmi'
				verb/GalicGun()
					set category="Skills"
					set name="Galic Gun"
					usr.SkillX("Beam",src)
			Ray
				icon_state="Ray"
				Power=1.5
				Speed=8
				Efficiency=0.8
				Distance=20
				ChargeRate=1
				sicon='Beam8.dmi'
				verb/Ray()
					set category="Skills"
					usr.SkillX("Beam",src)
			Piercer
				icon_state="Ray"
				Power=2.2
				Speed=7
				Efficiency=0.3
				Distance=13
				ChargeRate=0.1
				sicon='Beam18.dmi'
				verb/Piercer()
					set category="Skills"
					usr.SkillX("Beam",src)
			Masenko
				Power=1.9
				Speed=6
				Efficiency=1
				Distance=7
				ChargeRate=1.2
				sicon='Beam15.dmi'
				verb/Masenko()
					set category="Skills"
					usr.SkillX("Beam",src)
			Kamehameha
				Power=3
				Speed=5
				Efficiency=1.5
				Distance=9
				ChargeRate=1.5
				sicon='BeamBig1.dmi'
				Big=1
				verb/Kamehameha()
					set category="Skills"
					usr.SkillX("Beam",src)
			Dodompa
				Power=1.2
				Speed=7
				Efficiency=2
				Distance=4
				ChargeRate=2
				sicon='Beam4.dmi'
				verb/Dodompa()
					set category="Skills"
					usr.SkillX("Beam",src)
	Observe
		Learn=list("energyreq"=10000)
		icon_state="Observe"
		desc="Allows you to watch over someone."
		Level=100
		verb/Observe()
			set category="Skills"
			usr.SkillX("Observe",src)


	Telepathy
		Learn=list("energyreq"=10000)
		icon_state="Telepathy"
		desc="Allows you to send a telepathic message to someone."
		Level=100
		verb/Telepath()
			set category="Skills"
			usr.SkillX("Telepath",src)

	PowerControl
		Level=100
		Learn=list("energyreq"=1000,"difficulty"=20)
		icon='Skillz.dmi'
		icon_state="PC"
		sicon='Auras.dmi'
		sicon_state="1"
		desc="Allows you to highten or lower your energy level."
		verb/Power_Up()
			set category="Skills"
			usr.SkillX("PowerUp",src)
		verb/Power_Down()
			set category="Skills"
			usr.SkillX("PowerDown",src)





obj/Skills/Buffs
	ThirdEye
		Level=100
		Teachable=0
		desc="This allows you to unlock your Third Eye."
		icon_state="TE"
		verb/Third_Eye()
			set category="Skills"
			usr.SkillX("ThirdEye",src)
	Sharingan
		Level=100
		Teachable=0
		desc="The eyes of the Uchiha."
		verb/Sharingan()
			set category="Skills"
			usr.SkillX("Sharingan",src)
	Rinnegan
		Level=100
		Teachable=0
		desc="Exalted eyes sent down from Heaven to cleanse the world."
		verb/Rinnegan()
			set category="Skills"
			usr.SkillX("Rinnegan",src)
	Focus
		Learn=list("energyreq"=1000,"difficulty"=5)
		desc="Allows you to focus."
		icon_state="Focus"
		verb/Focus()
			set category="Skills"
			usr.SkillX("Focus",src)
	Expand
		Learn=list("energyreq"=1000,"difficulty"=4)
		icon_state="Expand"
		var/list/Overlayz=new
		var/Iconz
		verb/Expand()
			set category="Skills"
			usr.SkillX("Expand",src)
	Mystic
		Level=100
		Teachable=0
		desc="Allows you to enter a state of pureness."
		icon_state="Mystic"
		verb/Mystic()
			set category="Skills"
			usr.SkillX("Mystic",src)
	DemonicWill
		Level=100
		Teachable=0
		desc="Demon racial trait."
		verb/DemonicWill()
			set category="Skills"
			set name="Demonic Will"
			usr.SkillX("DemonicWill",src)
	OlympianFury
		Level=100
		Teachable=0
		desc="Demi-god racial trait."
		verb/OlympianFury()
			set category="Skills"
			set name="Olympian Fury"
			usr.SkillX("OlympianFury",src)
	DivineBlessing
		Level=100
		Teachable=0
		desc="Kaio racial trait."
		verb/DivineBlessing()
			set category="Skills"
			set name="Divine Blessing"
			usr.SkillX("DivineBlessing",src)
	Majin
		Level=100
		Teachable=0
		desc="Allows you to enter a state of chaos."
		icon_state="Majin"
		verb/Majin()
			set category="Skills"
			usr.SkillX("Majin",src)




mob/proc/Shielded()
	if(locate(/obj/Skills/Rank/Shield, src.contents))
		for(var/obj/Skills/Rank/Shield/S in src.contents)
			if(S.Using)
				src.Energy-=(EnergyMax/100)
				return 0.05
			else
				return 1
	else
		return 1



obj/Skills/Rank
	Learn=list("energyreq"=10000,"difficulty"=10)
	Dragonballs
		Teachable=0
		Level=100
		verb/MakeDragonballs()
			set category="Skills"
			usr.SkillX("DBSSMake")
		verb/ScatterDragonballs()
			set category="Skills"
			usr.SkillX("DBSScatter")

	Bind
		var/LastTime
		Level=100
		desc="Condem someone to hell."
		verb/Bind()
			set category="Skills"
			usr.SkillX("Bind",src)
		verb/UnBind()
			set category="Skills"
			usr.SkillX("UnBind",src)
	RestoreYouth
		Level=100
		desc="Restores the youth of whoever."
		name="Restore Youth"
		verb/Restore_Youth()
			set category="Skills"
			usr.SkillX("RestoreYouth",src)
	UnlockPotential
		Level=100
		desc="Allows you to Unlock someone's Potentinal."
		name="Unlock Potentinal"
		verb/Unlock_Potential()
			set category="Skills"
			usr.SkillX("UnlockPotentinal",src)

	KaioRevive
		Level=100
		desc="Allows you to Revive someone."
		icon_state="Revive"
		var/LastTime
		verb/Kaio_Revive()
			set category="Skills"
			usr.SkillX("Revive",src)
	KeepBody
		Level=100
		desc="Allows you to give someone their body."
		icon_state="KeepBody"
		verb/KeepBody()
			set name="Keep Body"
			set category="Skills"
			usr.SkillX("KeepBody",src)
	KaioTeleport
		Level=100
		desc="Allows you to Teleport."
		icon_state="KT"
		verb/KaioTeleport()
			set category="Skills"
			usr.SkillX("KaioTeleport",src)
	GivePower
		Level=100
		desc="Transfers your power to another."
		verb/GivePower()
			set name="Give Power"
			set category="Skills"
			usr.SkillX("GivePower",src)
	Taiyoken
		desc="Used to blind your opponents with blinding light."
		verb/Taiyoken()
			set category="Skills"
			usr.SkillX("Taiyoken",src)

	ShunkanIdo
		Learn=list("energyreq"=30000,"difficulty"=500)
		icon_state="SI"
		verb/ShunkanIdo()
			set category="Skills"
			set name="Shunkan Ido"
			usr.SkillX("ShunkanIdo",src)

	Shield
		Learn=list("energyreq"=1000)
		Level=100
		desc="Engulfs yourself in a shield of energy."
		icon_state="Shield"
		verb/Shield()
			set category="Skills"
			usr.SkillX("Shield",src)

	Kiai
		Learn=list("energyreq"=500)
		desc="Allows you to push away your enemies."
		icon_state="Kiai"
		verb/Kiai()
			set category="Skills"
			usr.SkillX("Kiai",src)

	AlmightyPush
		desc="Blows away your enemies with the Deva Path"
		icon_state="Push"
		verb/Push()
			set category="Skills"
			usr.SkillX("AlmightyPush",src)
	Ressurect
		desc="Hold the keys of life and death with the Outer Path"
		icon_state="Revive"
		verb/Ressurect()
			set category="Skills"
			usr.SkillX("Ressurect",src)
	Condemn
		desc="Control the door of Hell with the Naraka Path"
		icon_state="Condemn"
		verb/Condemn()
			set category="Skills"
			usr.SkillX("Condemn",src)

	PlanetDestruction
		desc="Literally destroy the planet."
		icon_state="PD"
		verb/PlanetDestruction()
			set category="Skills"
			DestroyPlanet(usr.z)
	Majinize
		Level=100
		desc="Allows you to Majinize someone."
		icon_state="Majinize"
		verb/Majinize()
			set category="Skills"
			usr.SkillX("Majinize",src)
	CurseEyes
		Level=100
		desc="Allows you to give Sharingan to someone."
		icon_state="CurseEyes"
		verb/CurseEyes()
			set category="Skills"
			usr.SkillX("CurseEyes",src)
	Mysticize
		Level=100
		desc="Allows you to Mysticize someone."
		icon_state="Mysticize"
		verb/Mysticize()
			set category="Skills"
			usr.SkillX("Mysticize",src)
	MakeAmulet
		Level=100
		desc="Allows you to create an Amulet."
		icon_state="MakeAmulet"
		verb/MakeAmulet()
			set category="Skills"
			usr.SkillX("MakeAmulet",src)
	Invisibility
		desc="Allows you to enter a phase of invisibility."
		icon_state="Invisible"
		verb/Invisibility()
			set category="Skills"
			usr.SkillX("Invisible",src)
	Imitation
		Level=100
		desc="Allows you to Imitate someone."
		icon_state="Imitate"
		var/imitating
		var/imitatorname
		var/list/imitatoroverlays=new/list
		var/imitatoricon
		verb/Imitate()
			set category="Skills"
			usr.SkillX("Imitate",src)
	Splitform
		desc="Allows you to create a duplicate of yourself."
		verb/Splitform()
			set category="Skills"
			usr.SkillX("Splitform",src)


	Kaioken
		Learn=list("energyreq"=5000,"difficulty"=10)
		Level=100
		desc="Allows you to use the Legendary Kaioken technique."
		icon_state="Kaioken"
		verb/Kaioken()
			set category="Skills"
			usr.SkillX("Kaioken",src)

	Zanzoken
		Level=100
		Learn=list("energyreq"=2000)
		desc="Allows you to move at high velocities."
		icon_state="Zanzoken"
		verb/Zanzoken()
			set category="Skills"
			usr.SkillX("Zanzoken",src)





obj/Items/Amulet
	icon='Misc.dmi'
	icon_state="Amulet"
	var/tmp/using
	verb/Open()
		set src in usr
		if(!using)
			using=1
			usr.OMessage(20,"[usr] opens the amulet and a portal to the dead zone appears!!","[usr]([usr.key]) opened the deadzone.")
			new/obj/Effects/DeadZone(locate(usr.x,usr.y+4,usr.z))
			spawn(300) using=0


turf/Click(turf/T)
	if(!usr.Observing&&!usr.Control)
		if(locate(/obj/Skills/Rank/Zanzoken,usr.contents))
			for(var/obj/Skills/Rank/Zanzoken/CM in usr.contents)
				if(CM.Using==1)
					if(T) if(T.icon)
						for(var/turf/A in view(0,usr)) if(A==src) return
						if(!T.density)
							if(usr.icon_state!="Meditate"&&usr.icon_state!="Train"&&usr.icon_state!="Blast"&&usr.icon_state!="KB"&&usr.icon_state!="KO")
								flick('Dodge.dmi',usr)
								var/formerdir=usr.dir
								usr.Move(src)
								usr.dir=formerdir
								usr.Energy-=(5/usr.ZanzokenSkill)
								usr.ZanzokenSkill+=(1*usr.ZanzokenSkillMod)
								if(usr.Energy<0) usr.Energy=0
								sleep(15)