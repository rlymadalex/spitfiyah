var/list/Turfs=new
turf/var/InitialType
turf/Del()
	var/Type=type
	if(InitialType) Type=InitialType
	spawn InitialType=Type
	Builder=null
	Turfs-=src
	..()



var/image/Glare=image(icon='Misc.dmi',icon_state="Glare",layer=5)
proc/Destroy(turf/A)
	if(isturf(A)) if(A.type!=/turf/Dirt&&A.Destructable)
		new/turf/Dirt(locate(A.x,A.y,A.z))
	else if(isobj(A))
		new/obj/Effects/Crater(locate(A.x,A.y,A.z))
		del(A)
	else if(ismob(A)) del(A)

turf/var
	Destructable=1
	FlyOverAble=1
	Water
obj/Turfs
	Savable=0
	Spawn_Timer=3000
obj/Turfs/Edges/Grabbable=0
obj/Turfs/Surf/Grabbable=0






obj/Planets
	Health=1.#INF
	proc/Orbit()
		set background=1
		while(src)
			step_rand(src)
			sleep(rand(1000,2000))
	New()
		..()
		var/icon/b=new(src.icon)
		if(b.Width()>32)
			src.pixel_x=(b.Width()-32)/-2
		if(b.Height()>32)
			src.pixel_y=(b.Height()-32)/-2
		spawn(rand(1000,2000))src.Orbit()

	var/Zz
	Buildable=0
	Savable=1
	density=1
	icon='Planets.dmi'
	Earth
		icon_state="Earth"
		Zz=1
	Namek
		icon_state="Namek"
		Zz=2
	Vegeta
		icon_state="Vegeta"
		Zz=3
	Arconia
		icon_state="Arconia"
		Zz=5
	Ice
		icon_state="Ice"
		Zz=4
	Alien
		icon_state="Alien"


mob/var/tmp/UpgradeTime=0

turf/verb/Upgrade()
	set src in oview(1)
	set category=null
	set background=1
	if(usr.UpgradeTime)
		usr<<"You cannot upgrade your walls again at this time, please wait!"
		return
	if(!(usr.client.mob in range(1,src))) return
	if(src.Builder)
		usr.UpgradeTime=1
		var/buh
		if(src.Builder==usr.ckey)
			buh=input("Do you want to make your roofs flyoverable?")in list("Yes","No")
		spawn(1500)usr.UpgradeTime=0
		for(var/turf/q in world)
			if(q.Builder==src.Builder)
				if(buh)
					if(buh=="Yes")
						q.FlyOverAble=1
					if(buh=="No")
						q.FlyOverAble=0
				q.Health=max(q.Health,usr.IntelligenceLevel*usr.IntelligenceLevel*1000000)
		for(var/obj/q in world)
			if(q.Builder==src.Builder)
				q.Health=max(q.Health,usr.IntelligenceLevel*usr.IntelligenceLevel*1000000)
		view(10,usr)<<"[usr] upgraded [src.Builder]'s walls that aren't to higher durability to level [usr.IntelligenceLevel]."


turf
	IconsX
		icon='NewTurfs.dmi'
		Icon1
			icon_state="1"
		Icon2
			icon_state="2"
		Icon3
			icon_state="3"
		Icon4
			icon_state="4"
		Icon5
			icon_state="5"
		Icon6
			icon_state="6"
		Icon7
			icon_state="7"
		Icon8
			icon_state="8"
			density=1
		Icon9
			icon_state="9"
		Icon10
			icon_state="10"
		Icon11
			icon_state="11"
		Icon12
			icon_state="12"
		Icon13
			icon_state="13"
		Icon14
			icon_state="14"
		Icon15
			icon_state="15"
		Icon16
			icon_state="16"
		Icon17
			icon_state="17"
		Icon18
			icon_state="18"
		Icon19
			icon_state="19"
		Icon20
			icon_state="20"
		Icon21
			icon_state="21"
		Icon22
			icon_state="22"
		Icon23
			icon_state="23"
		Icon24
			icon_state="24"
		Icon25
			icon_state="25"
		Icon26
			icon_state="26"
		Icon27
			icon_state="27"
		Icon28
			icon_state="28"
		Icon29
			icon_state="29"
		Icon30
			icon_state="30"
		Icon31
			icon_state="31"
		Icon32
			icon_state="32"
		Icon33
			icon_state="33"
		Icon34
			icon_state="34"
		Icon35
			icon_state="35"
		Icon36
			icon_state="36"
		Icon37
			icon_state="37"
		Icon38
			icon_state="38"
		Icon39
			icon_state="39"
		Icon40
			icon_state="40"
		Icon41
			icon_state="41"
		Icon42
			icon_state="42"
		Icon43
			icon_state="43"
		Icon44
			icon_state="44"
		Icon45
			icon_state="45"
		Icon46
			icon_state="46"
		Icon47
			icon_state="47"
		Icon48
			icon_state="48"
		Icon49
			icon_state="49"
		Icon50
			icon_state="50"
		Icon51
			icon_state="51"
		Icon52
			icon_state="52"
		Icon53
			icon_state="53"
		Icon54
			icon_state="54"
		Icon55
			icon_state="55"
		Icon56
			icon_state="56"
			density=1
		Icon57
			icon_state="57"
		Icon58
			icon_state="58"
		Icon59
			Enter(mob/M)
				if(istype(M,/mob))
					if(!M.Flying)
						if(prob(50))usr.loc=locate(usr.x,usr.y,7)
				return ..()
			icon_state="59"
		Icon60
			icon_state="60"
		Icon61
			icon_state="61"
		Icon62
			icon_state="62"
		Icon63
			icon_state="63"
		Icon64
			icon_state="64"
		Icon65
			icon_state="65"
		Icon66
			icon_state="66"
		Icon67
			icon_state="67"










	Bridge1V
		icon='Turf.dmi'
		icon_state="BridgeV"
	Bridge1H
		icon='Turf.dmi'
		icon_state="BridgeH"
	Bridge2V
		icon='Turf.dmi'
		icon_state="Bridge2V"
	Bridge2H
		icon='Turf.dmi'
		icon_state="Bridge2H"
	Dirt
		icon='Turf.dmi'
		icon_state="Dirt"
	GroundIce
		icon='Turf.dmi'
		icon_state="IceSnow"
	GroundIce2
		icon='Turf.dmi'
		icon_state="Ice"
	DirtSand
		icon='Turf.dmi'
		icon_state="SandDirt"
	GroundSnow
		icon='Turf.dmi'
		icon_state="Snow"
	Ground4
		icon='Turf.dmi'
		icon_state="Desert"
	Ground10
		icon='Turf.dmi'
		icon_state="Desert2"
	Ground17
		icon='Turf.dmi'
		icon_state="Dirt2"
	Ground18
		icon='Turf.dmi'
		icon_state="HellFloor"
	Ground19
		icon='Turf.dmi'
		icon_state="DarkTile"
	GroundIce3
		icon='Turf.dmi'
		icon_state="Ice2"
	GroundHell
		icon='Turf.dmi'
		icon_state="HellFloor2"
	Ground16
		icon='Turf.dmi'
		icon_state="Flagstone"
	Ground12
		icon='Turf.dmi'
		icon_state="Dirt3"
	Ground13
		icon='Turf.dmi'
		icon_state="Dirt3Rock"
		density=1
	GroundPebbles
		icon='Turf.dmi'
		icon_state="Sand"
	Ground11
		icon='Turf.dmi'
		icon_state="Dirt3Crack"
		density=1
	GroundSandDark
		icon='Turf.dmi'
		icon_state="Desert3"
		density=0
	Ground3
		icon='Turf.dmi'
		icon_state="DarkDesert"
		density=0
	Grass9
		icon='Turf.dmi'
		icon_state="Grass"
	Grass13
		icon='Turf.dmi'
		icon_state="Grass2"
	Grass7
		icon='Turf.dmi'
		icon_state="Grass3"
	Grass5
		icon='Turf.dmi'
		icon_state="Grass4"
	Grass11
		icon='Turfs.dmi'
		icon_state="Grass5"
	Grass12
		icon='Turf.dmi'
		icon_state="Grass6"
	Grass1
		icon='Turf.dmi'
		icon_state="Grass7"
	Grass8
		icon='Turf.dmi'
		icon_state="Grass8"
	Grass3
		icon='Turf.dmi'
		icon_state="Grass9"
	Grass4
		icon='Turf.dmi'
		icon_state="Grass10"
	GrassNamek
		icon='Turf.dmi'
		icon_state="Grass11"
	Grass2
		icon='Turfs 5.dmi'
		icon_state="grass"
	Grass10
		icon='turfs.dmi'
		icon_state="ngrass"
	Ground14
		icon='Turfs 2.dmi'
		icon_state="desert"
	Grass14
		icon='Turfs 96.dmi'
		icon_state="grass a"
	Grass10
		icon='Turfs 1.dmi'
		icon_state="Grass!"
	Wall12
		icon='Turfs 3.dmi'
		icon_state="cliff"
		density=1
	Wall10
		icon='Turfs 4.dmi'
		icon_state="ice cliff"
		density=1
	Wall8
		icon='Turfs 15.dmi'
		icon_state="wall2"
		density=1
	Wall3
		icon='Turfs 4.dmi'
		icon_state="wall"
		density=1
	Wall17
		icon='Turf 57.dmi'
		icon_state="1"
		density=1
	Wall7
		icon='Turfs 1.dmi'
		icon_state="cliff"
		density=1
	Wall2
		icon='Turfs 1.dmi'
		icon_state="wall6"
		opacity=0
		density=1
	WallSand
		icon='Turf 50.dmi'
		icon_state="3.2"
		density=1
	WallStone
		icon='Turf 57.dmi'
		icon_state="stonewall2"
		density=1
	WallStone2
		icon='Turf 57.dmi'
		icon_state="stonewall4"
		density=1
	WallStone3
		icon='Turfs 96.dmi'
		icon_state="wall3"
		density=1
	WallTech
		icon='Space.dmi'
		icon_state="bottom"
		density=1
	Wall18
		icon='Turf 57.dmi'
		icon_state="2"
		density=1
	Wall19
		icon='Turf 57.dmi'
		icon_state="3"
		density=1
	Wall20
		icon='Turf 57.dmi'
		icon_state="6"
		density=1
	Wall13
		icon='turfs.dmi'
		icon_state="wall8"
		density=1
	Wall16
		icon='Turf 50.dmi'
		icon_state="2.6"
		density=1
	Wall11
		icon='Turfs 18.dmi'
		icon_state="stone"
		density=1
	Wall5
		icon='turfs.dmi'
		icon_state="tile1"
		density=1
	Wall6
		icon='Turfs 2.dmi'
		icon_state="brick2"
		density=1
	Wall15
		icon='Turf1.dmi'
		icon_state="1"
		density=1
	Wall1
		icon='turfs.dmi'
		icon_state="tile5"
		density=1
		opacity=0
	RoofTech
		icon='Space.dmi'
		icon_state="top"
		density=1
		opacity=1
		Enter(atom/A)
			if(FlyOverAble) return ..()
			else return
	Roof1
		icon='Turfs 96.dmi'
		icon_state="roof3"
		density=1
		opacity=1
		Enter(atom/A)
			if(FlyOverAble) return ..()
			else return
	Roof2
		icon='Turfs.dmi'
		icon_state="roof2"
		density=1
		opacity=1
		Enter(atom/A)
			if(FlyOverAble) return ..()
			else return
	Roof3
		icon='Turfs 96.dmi'
		icon_state="roof4"
		density=1
		opacity=1
		Enter(atom/A)
			if(FlyOverAble) return ..()
			else return
	RoofWhite
		icon='turfs.dmi'
		icon_state="block_wall1"
		density=1
		opacity=1
		Enter(atom/A)
			if(FlyOverAble) return ..()
			else return
	TileWood
		icon='Turfs 96.dmi'
		icon_state="woodfloor"
	TileBlue
		icon='turfs.dmi'
		icon_state="tile11"
	Tile26
		icon='turfs.dmi'
		icon_state="tile9"
	Tile25
		icon='Turfs 4.dmi'
		icon_state="cooltiles"
	Tile21
		icon='Turfs 12.dmi'
		icon_state="Girly Carpet"
	Tile23
		icon='Turfs 12.dmi'
		icon_state="Wood_Floor"
	Tile17
		icon='turfs.dmi'
		icon_state="roof4"
	Tile15
		icon='Turfs 12.dmi'
		icon_state="stonefloor"
	Tile6
		icon='Turfs 12.dmi'
		icon_state="floor4"
	Tile14
		icon='turfs.dmi'
		icon_state="tile10"
	Tile22
		icon='FloorsLAWL.dmi'
		icon_state="SS Floor"
	TileStone
		icon='Turf 57.dmi'
		icon_state="55"
	Tile13
		icon='Turfs 1.dmi'
		icon_state="ground"
	TileWood
		icon='Turf 57.dmi'
		icon_state="woodfloor"
	Tile19
		icon='Turfs 12.dmi'
		icon_state="floor2"
	Tile20
		icon='turfs.dmi'
		icon_state="tile4"
	Tile2
		icon='FloorsLAWL.dmi'
		icon_state="Tile"
	Tile12
		icon='Turfs 15.dmi'
		icon_state="floor7"
	TileBlue2
		icon='turfs.dmi'
		icon_state="tile12"
	Tile13
		icon='Turfs 15.dmi'
		icon_state="floor6"
	Tile24
		icon='turfs.dmi'
		icon_state="bridgemid2"
	Tile10
		icon='FloorsLAWL.dmi'
		icon_state="Flagstone Vegeta"
	Tile11
		icon='Turfs 2.dmi'
		icon_state="dirt"
	Tile18
		icon='Turfs 12.dmi'
		icon_state="Aluminum Floor"
	Tile8
		icon='Turfs 1.dmi'
		icon_state="woodenground"
	Tile16
		icon='Turfs 14.dmi'
		icon_state="Stone"
	Tile27
		icon='turfs.dmi'
		icon_state="tile7"
	Tile28
		icon='turfs.dmi'
		icon_state="floor"
	TileGold
		icon='Turf 55.dmi'
		icon_state="goldfloor"
	Tile9
		icon='Turfs 18.dmi'
		icon_state="wooden"
	Tile8
		icon='Turfs 18.dmi'
		icon_state="diagwooden"
	Tile1
		icon='Turfs 12.dmi'
		icon_state="Brick_Floor"
	//TileWhite icon='White.dmi'
	Tile2
		icon='Turfs 12.dmi'
		icon_state="Stone Crystal Path"
	Tile3
		icon='Turfs 12.dmi'
		icon_state="Stones"
	Tile4
		icon='Turfs 12.dmi'
		icon_state="Black Tile"
	Tile5
		icon='Turfs 12.dmi'
		icon_state="Dirty Brick"
	Stairs1
		icon='Turfs 96.dmi'
		icon_state="steps"
	StairsHell
		icon='Turf 57.dmi'
		icon_state="hellstairs"
	Stairs4
		icon='Turfs 1.dmi'
		icon_state="stairs1"
	Stairs5
		icon='Turfs 1.dmi'
		icon_state="earthstairs"
	Stairs3
		icon='Turfs 1.dmi'
		icon_state="stairs2"
	Stairs2
		icon='Turfs 12.dmi'
		icon_state="Steps"
turf/Waters
	//Enter(mob/M)
		//if(ismob(M)) if(M.Flying||!M.density) return ..()
		//else return ..()
	icon='Waters.dmi'
	WaterReal
		icon_state="4"
		Water=1
	Water5
		icon_state="5"
		Water=1
	WaterFall
		icon_state="waterfall"
		density=1
		layer=MOB_LAYER+1
		Water=1
	Water6
		icon_state="6"
		Water=1
	Water3
		icon_state="3"
		Water=1
	Water8
		icon_state="8"
		Water=1
	Water1
		icon_state="1"
		Water=1
	Water11
		icon_state="11"
		Water=1
	Water7
		icon_state="7"
		density=0
	Water2
		icon_state="2"
		Water=1
	Water12
		icon_state="12"
		Water=1
	Water9
		icon_state="9"
		Water=1
	Water10
		icon_state="10"
		Water=1





obj/Turfs
	IconsXLBig
		icon='NewOther.dmi'
		Icon1
			icon_state="1"
		Icon2
			icon_state="2"
		Icon3
			icon_state="3"
		Icon4
			icon_state="4"
		Icon5
			icon_state="5"
		Icon6
			icon_state="6"
		Icon7
			icon_state="7"
		Icon8
			icon_state="8"
		Icon9
			icon_state="9"
		Icon10
			icon_state="10"
		Icon11
			icon_state="11"
		Icon12
			icon_state="12"
		Icon13
			icon_state="13"
		Icon14
			icon_state="14"
		Icon15
			icon_state="15"
		Icon16
			icon_state="16"
		Icon17
			icon_state="17"
		Icon18
			icon_state="18"
		Icon19
			icon_state="19"
		Icon20
			icon_state="20"
		Icon21
			icon_state="21"
		Icon22
			icon_state="22"
		Icon23
			icon_state="23"
		Icon24
			icon_state="24"
		Icon25
			icon_state="25"
		Icon26
			icon_state="26"
		Icon27
			icon_state="27"
		Icon28
			icon_state="28"
		Icon29
			icon_state="29"
		Icon30
			icon_state="30"
		Icon31
			icon_state="31"
		Icon32
			icon_state="32"
		Icon33
			icon_state="33"
		Icon34
			icon_state="34"
		Icon35
			icon_state="35"
		Icon36
			icon_state="36"
		Icon37
			icon_state="37"
		Icon38
			icon_state="38"
		Icon39
			icon_state="39"
		Icon40
			icon_state="40"
		Icon41
			icon_state="41"
		Icon42
			icon_state="42"
		Icon43
			icon_state="43"
		Icon44
			icon_state="44"
		Icon45
			icon_state="45"
		Icon46
			icon_state="46"
		Icon47
			icon_state="47"
		Icon48
			icon_state="48"
		Icon49
			icon_state="49"
		Icon50
			icon_state="50"
		Icon51
			icon_state="51"
		Icon52
			icon_state="52"
		Icon53
			icon_state="53"
		Icon54
			icon_state="54"
		Icon55
			icon_state="55"
		Icon56
			icon_state="56"
		Icon57
			icon_state="57"
		Icon58
			icon_state="58"
		Icon59
			icon_state="59"
		Icon60
			icon_state="60"
		Icon61
			icon_state="61"
		Icon62
			icon_state="62"
		Icon63
			icon_state="63"
		Icon64
			icon_state="64"
		Icon65
			icon_state="65"
		Icon66
			icon_state="66"
		Icon67
			icon_state="67"
		Icon68
			icon_state="68"
		Icon69
			icon_state="69"
		Icon70
			icon_state="70"
		Icon71
			icon_state="71"
		Icon72
			icon_state="72"
		Icon73
			icon_state="73"
			layer = MOB_LAYER+1
			density=1
		Icon74
			icon_state="74"
			layer = MOB_LAYER+1
			density=1
		Icon75
			icon_state="75"
			layer = MOB_LAYER+1
			density=1

	IconsX
		icon='NewObjects.dmi'
		Icon1
			icon_state="1"
			density=1
		Icon2
			icon_state="2"
			density=1
		Icon3
			icon_state="3"
			density=1
		Icon4
			icon_state="4"
			density=1
		Icon5
			icon_state="5"
			density=1
		Icon6
			icon_state="6"
			density=1
		Icon7
			icon_state="7"
			density=1
		Icon8
			icon_state="8"
		Icon9
			icon_state="9"
		Icon10
			icon_state="10"
		Icon11
			icon_state="11"
			density=1
		Icon12
			icon_state="12"
			density=1
		Icon13
			icon_state="13"
			density=1
		Icon14
			icon_state="14"
			density=1
		Icon15
			icon_state="15"
			density=1
		Icon16
			icon_state="16"
			density=1
		Icon17
			icon_state="17"
			density=1
		Icon18
			icon_state="18"
			density=1
		Icon19
			icon_state="19"
			density=1
		Icon20
			icon_state="20"
		Icon21
			icon_state="21"
		Icon22
			icon_state="22"
		Icon23
			icon_state="23"
		Icon24
			icon_state="24"
		Icon25
			icon_state="25"
			density=1
		Icon26
			icon_state="26"
			density=1
		Icon27
			icon_state="27"
		Icon28
			icon_state="28"
			density=1
			layer = MOB_LAYER+1
		Icon29
			icon_state="29"
			density=1
		Icon30
			icon_state="30"
			density=1
		Icon31
			icon_state="31"
			density=1
		Icon32
			icon_state="32"
			density=1
		Icon33
			icon_state="33"
			density=1
		Icon34
			icon_state="34"
			density=1
		Icon35
			icon_state="35"
			density=1
		Icon36
			icon_state="36"
			density=1
		Icon37
			icon_state="37"
			density=1
		Icon38
			icon_state="38"
		Icon39
			icon_state="39"
		Icon40
			icon_state="40"
		Icon41
			icon_state="41"
		Icon42
			icon_state="42"
			density=1
		Icon43
			icon_state="43"
			density=1
		Icon44
			icon_state="44"
			density=1
		Icon45
			icon_state="45"
			density=1
		Icon46
			icon_state="46"
			density=1
		Icon47
			icon_state="47"
			density=1
		Icon48
			icon_state="48"
			density=1
		Icon49
			icon_state="49"
			density=1
		Icon50
			icon_state="50"
			density=1
		Icon51
			icon_state="51"
			density=1
		Icon52
			icon_state="52"
			density=1
		Icon53
			icon_state="53"
			density=1
		Icon54
			icon_state="54"
			density=1
		Icon55
			icon_state="55"
			density=1
		Icon56
			icon_state="56"
		Icon57
			icon_state="57"
		Icon58
			icon_state="58"
		Icon59
			icon_state="59"
		Icon60
			icon_state="60"
		Icon61
			icon_state="61"
		Icon62
			icon_state="62"
		Icon63
			icon_state="63"
		Icon64
			icon_state="64"
		Icon65
			icon_state="65"
		Icon66
			icon_state="66"
		Icon67
			icon_state="67"
		Icon68
			icon_state="68"
		Icon69
			icon_state="69"
		Icon70
			icon_state="70"
		Icon71
			icon_state="71"
		Icon72
			icon_state="72"
		Icon73
			icon_state="73"
		Icon74
			icon_state="74"
		Icon75
			icon_state="75"
		Icon76
			icon_state="76"
		Icon77
			icon_state="77"
		Icon78
			icon_state="78"
			density=1
		Icon79
			icon_state="79"
		Icon80
			icon_state="80"
		Icon81
			icon_state="81"
		Icon82
			icon_state="82"
		Icon83
			icon_state="83"
			density=1
		Icon84
			icon_state="84"
			density=1
		Icon85
			icon_state="85"
			density=1
		Icon86
			icon_state="86"
			density=1
		Icon87
			icon_state="87"
		Icon88
			icon_state="88"
		Icon89
			icon_state="89"
		Icon90
			icon_state="90"
		Icon91
			icon_state="91"
			density=1
		Icon92
			icon_state="92"
		Icon93
			icon_state="93"
			density=1
		Icon94
			icon_state="94"
			density=1
		Icon95
			icon_state="95"
		Icon96
			icon_state="96"
		Icon97
			icon_state="97"
		Icon98
			icon_state="98"
			density=1
		Icon99
			icon_state="99"
		Icon100
			icon_state="100"
		Icon101
			icon_state="101"
			density=1
		Icon102
			icon_state="102"
			density=1
		Icon103
			icon_state="103"
		Icon104
			icon_state="104"
		Icon105
			icon_state="105"
		Icon106
			icon_state="106"
		Icon107
			icon_state="107"
		Icon108
			icon_state="108"
		Icon109
			icon_state="109"
		Icon110
			icon_state="110"
		Icon111
			icon_state="111"
		Icon112
			icon_state="112"
			density=1
		Icon113
			icon_state="113"
			density=1
		Icon114
			icon_state="114"
			density=1
		Icon115
			icon_state="115"
			density=1
		Icon116
			icon_state="116"
		Icon117
			icon_state="117"
		Icon118
			icon_state="118"
		Icon119
			icon_state="119"
		Icon120
			icon_state="120"
		Icon121
			icon_state="121"
			density=1
		Icon122
			icon_state="122"
			density=1
		Icon123
			icon_state="123"
		Icon124
			icon_state="124"
		Icon125
			icon_state="125"
			density=1
		Icon126
			icon_state="126"
		Icon127
			icon_state="127"
			density=1
		Icon128
			icon_state="128"
			density=1
		Icon129
			icon_state="129"
			density=1
		Icon130
			icon_state="130"
			density=1
		Icon131
			icon_state="131"
			density=1
		Icon132
			icon_state="132"
			layer = MOB_LAYER-1
		Icon133
			icon_state="133"
		Icon134
			icon_state="134"
		Icon135
			icon_state="135"
		Icon136
			icon_state="136"
		Icon137
			icon_state="137"
		Icon138
			icon_state="138"
		Icon139
			icon_state="139"
		Icon140
			icon_state="140"
		Icon141
			icon_state="141"
			density=1
		Icon142
			icon_state="142"
		Icon143
			icon_state="143"
			density=1
		Icon144
			icon_state="144"
		Icon145
			icon_state="145"
			density=1
		Icon146
			icon_state="146"
			density=1
		Icon147
			icon_state="147"
			density=1
		Icon148
			icon_state="148"
		Icon149
			icon_state="149"
		Icon150
			icon_state="150"
		Icon151
			icon_state="151"
		Icon152
			icon_state="152"
			density=1
		Icon153
			icon_state="153"
			density=1
		Icon154
			icon_state="154"
		Icon155
			icon_state="155"
			density=1
		Icon156
			icon_state="156"
			density=1
		Icon157
			icon_state="157"
			density=1
		Icon158
			icon_state="158"
		Icon159
			icon_state="159"
			density=1
		Icon160
			icon_state="160"
			density=1
		Icon161
			icon_state="161"
			density=1
		Icon162
			icon_state="162"
		Icon163
			icon_state="163"
		Icon164
			icon_state="164"
		Icon165
			icon_state="165"
		Icon166
			icon_state="166"
		Icon167
			icon_state="167"
		Icon168
			icon_state="168"
		Icon169
			icon_state="169"
		Icon170
			icon_state="170"
		Icon171
			icon_state="171"
		Icon172
			icon_state="172"
		Icon173
			icon_state="173"
		Icon174
			icon_state="174"
		Icon175
			icon_state="175"
		Icon176
			icon_state="176"





	Door/Door2
		icon='Doors.dmi'
		icon_state="Closed2"
		density=1
	Door
		var/typee
		density=1
		icon='Doors.dmi'
		icon_state="Closed1"
		New()
			Open()
			..()
		Click()
			..()
			if(usr in oview(1,src))
				oview(10,src)<<"<font color=yellow><small>There is a knock on the door!"

		proc/Open()
			density=0
			opacity=0
			if(istype(src,/obj/Turfs/Door/Door2))
				typee=2
			else
				typee=1
			if(icon=='Doors.dmi')
				flick("Opening[typee]",src)
				icon_state="Open[typee]"
			else
				flick("Opening",src)
				icon_state="Open"
			spawn(50) Close()
		proc/Close()
			density=1
			opacity=1
			if(icon=='Doors.dmi')
				flick("Closing[typee]",src)
				icon_state="Closed[typee]"
			else
				flick("Closing",src)
				icon_state="Closed"
	Sign
		icon='Objects.dmi'
		icon_state="Sign"
		density=1
		Click() if(desc) usr<<desc
		Information_Panel
			icon='Objects.dmi'
			icon_state="Sign2"
		Sign3
			icon='Objects.dmi'
			icon_state="Sign3"
		Sign4
			icon='Objects.dmi'
			icon_state="Sign4"
		Sign5
			icon='Objects.dmi'
			icon_state="Sign5"
		Sign6
			icon='Objects.dmi'
			icon_state="Sign6"
	Rock
		icon='Gardening.dmi'
		icon_state="Rock1"
	LargeRock
		density=1
		icon='Gardening.dmi'
		icon_state="Rock2"
	firewood
		icon='Gardening.dmi'
		icon_state="Firewood"
		density=1
	WaterRock
		density=1
		icon='Gardening.dmi'
		icon_state="Rock4"
	HellRock
		density=1
		icon='Gardening.dmi'
		icon_state="Hellrock1"
	HellRock2
		density=1
		icon='Gardening.dmi'
		icon_state="Hellrock2"
	HellRock3
		density=1
		icon='Gardening.dmi'
		icon_state="Hellrock3"
	LargeRock2
		density=1
		icon='Gardening.dmi'
		icon_state="Rock3"
	Rock1
		icon='Gardening.dmi'
		icon_state="Rock5"
		density=1
	Rock2
		icon='Gardening.dmi'
		icon_state="Rock6"
		density=1
	Stalagmite
		density=1
		icon='Gardening.dmi'
		icon_state="Stalagmite"
	Fence
		density=1
		icon='Gardening.dmi'
		icon_state="Fence"
	Rock3
		icon='Gardening.dmi'
		icon_state="Rock6"
		density=1
	Rock4
		icon='Gardening.dmi'
		icon_state="Rock7"
		density=1
	Flowers
		icon='Gardening.dmi'
		icon_state="FlowerBed"
	Rock6
		icon='Gardening.dmi'
		icon_state="Rock8"
		density=1
	Bush1
		icon='Gardening.dmi'
		icon_state="Bush1"
		density=1
	Bush2
		icon='Gardening.dmi'
		icon_state="Bush2"
		density=1
	Bush3
		icon='Gardening.dmi'
		icon_state="Bush3"
		density=1
	Bush4
		icon='Gardening.dmi'
		icon_state="Bush4"
		density=1
	Bush5
		icon='Gardening.dmi'
		icon_state="Bush5"
		density=1
	SnowBush
		icon='Gardening.dmi'
		icon_state="Bush6"
		density=1
	Plant12
		icon='Gardening.dmi'
		icon_state="Plant1"
		density=1
	Plant11
		icon='Gardening.dmi'
		icon_state="Plant2"
		density=1
	Plant10
		icon='Gardening.dmi'
		icon_state="Plant3"
		density=1
	Plant16
		icon='Gardening.dmi'
		icon_state="Flowers1"
	Plant15
		icon='Gardening.dmi'
		icon_state="Flowers2"
	Plant2
		icon='Gardening.dmi'
		icon_state="Plant4"
		density=1
	Plant3
		icon='Gardening.dmi'
		icon_state="Plant5"
	Plant4
		icon='Gardening.dmi'
		icon_state="Plant6"
	Plant5
		icon='Gardening.dmi'
		icon_state="Plant7"
	Plant13
		icon='Gardening.dmi'
		icon_state="Bush7"
	Plant14
		icon='Gardening.dmi'
		icon_state="Tree1"
		density=1
	Plant18
		icon='Gardening.dmi'
		icon_state="Tree2"
		density=1
	Plant6
		icon='Gardening.dmi'
		icon_state="Hellrock4"
		density=1
	Plant20
		icon='Gardening.dmi'
		icon_state="Hellrock5"
		density=1
	Plant19
		icon='Gardening.dmi'
		icon_state="Hellrock6"
		density=1
	Plant7
		icon='Gardening.dmi'
		icon_state="Tree3"
		density=1
	Plant8
		icon='Gardening.dmi'
		icon_state="Tree4"
		density=1
	Plant9
		icon='Gardening.dmi'
		icon_state="Tree5"
		density=1
	Table7
		icon='Objects.dmi'
		icon_state="Table1"
		density=1
	Table8
		icon='Objects.dmi'
		icon_state="Table2"
		density=1
	Table9
		icon='Objects.dmi'
		icon_state="Table3"
		density=1
	Whirlpool
		icon='Misc.dmi'
		icon_state="Whirlpool"
	bridgeN
		icon='Edges.dmi'
		icon_state="N"
		density=1
	bridgeS
		icon='Edges.dmi'
		icon_state="S"
		density=1
	bridgeE
		icon='Edges.dmi'
		icon_state="E"
		density=1

	bridgeW
		icon='Edges.dmi'
		icon_state="W"
		density=1
	Chest
		icon='Objects.dmi'
		icon_state="Chest"
	HellPot
		icon='Objects.dmi'
		icon_state="Pot1"
		density=1
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="Pot2",pixel_y=32)
			overlays.Remove(A)
			overlays.Add(A)
			..()
	RugLarge
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="Rug1",pixel_x=-16,pixel_y=16,layer=MOB_LAYER-1)
			var/image/B=image(icon='Objects.dmi',icon_state="Rug2",pixel_x=16,pixel_y=16,layer=MOB_LAYER-1)
			var/image/C=image(icon='Objects.dmi',icon_state="Rug3",pixel_x=-16,pixel_y=-16,layer=MOB_LAYER-1)
			var/image/D=image(icon='Objects.dmi',icon_state="Rug4",pixel_x=16,pixel_y=-16,layer=MOB_LAYER-1)
			overlays.Remove(A,B,C,D)
			overlays.Add(A,B,C,D)
			..()
	Apples
		icon='Objects.dmi'
		icon_state="Apples"
	Book
		icon='Objects.dmi'
		icon_state="Book"
	Light
		icon='Objects.dmi'
		icon_state="Light"
		density=1
	Glass
		icon='Objects.dmi'
		icon_state="Glass"
		density=1
		layer=MOB_LAYER+1
	Table6
		icon='Objects.dmi'
		icon_state="Table4"
		density=1
	Table5
		icon='Objects.dmi'
		icon_state="TableL"
		density=1
	Table3
		icon='Objects.dmi'
		icon_state="TableR"
		density=1
	Table4
		icon='Objects.dmi'
		icon_state="TableM"
		density=1
	Log
		density=1
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="Log1",pixel_x=-16)
			var/image/B=image(icon='Objects.dmi',icon_state="Log2",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
			..()
	FancyCouch
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="CouchL",pixel_x=-16)
			var/image/B=image(icon='Objects.dmi',icon_state="CouchR",pixel_x=16)
			overlays.Remove(A,B)
			overlays.Add(A,B)
			..()

	Jugs
		icon='Objects.dmi'
		icon_state="Jugs"
		density=1
	Hay
		icon='Objects.dmi'
		icon_state="Hay"
		density=1
	Clock
		icon='Objects.dmi'
		icon_state="Clock"
		density=1

	Waterpot
		icon='Objects.dmi'
		icon_state="PotWater"
		density=1

	Stove
		icon='Objects.dmi'
		icon_state="Stove"
		density=1
	Drawer
		icon='Objects.dmi'
		icon_state="Drawers"
		density=1
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="DrawersT",pixel_y=32)
			overlays.Remove(A)
			overlays.Add(A)
			..()
	Bed
		icon='Objects.dmi'
		icon_state="BedT"
		New()
			var/image/A=image(icon='Objects.dmi',icon_state="Bed",pixel_y=-32)
			overlays.Remove(A)
			overlays.Add(A)
			..()
	Torch1
		icon='Objects.dmi'
		icon_state="Torch1"
		density=1
	Torch2
		icon='Objects.dmi'
		icon_state="Torch2"
		density=1
	Torch3
		icon='Objects.dmi'
		icon_state="Torch3"
		density=1
	Fire
		icon='Objects.dmi'
		icon_state="Fire"
		density=1
	barrel
		icon='Objects.dmi'
		icon_state="Barrel"
		density=1
	chair
		icon='Objects.dmi'
		icon_state="Chair"
	box2
		icon='Objects.dmi'
		icon_state="Box"
		density=1
obj/Turfs/Trees
	SmallPine
		icon='Trees.dmi'
		icon_state="P2"
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="P5",pixel_y=0,pixel_x=32,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="P1",pixel_y=0,pixel_x=-32,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="P0",pixel_y=-32,pixel_x=0,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="P3",pixel_y=32,pixel_x=-32,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="P4",pixel_y=32,pixel_x=0,layer=5)
			overlays.Remove(A,B,C,D,E)
			overlays.Add(A,B,C,D,E)
			..()
	RedTree
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="R1",pixel_y=32,pixel_x=-32,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="R2",pixel_y=0,pixel_x=0,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="R3",pixel_y=32,pixel_x=32,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="R4",pixel_y=0,pixel_x=-32,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="R5",pixel_y=32,pixel_x=0,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="R6",pixel_y=0,pixel_x=32,layer=5)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			..()
	BigHousePlant
		density=1
		icon='Gardening.dmi'
		icon_state="Plant"
		New()
			var/image/A=image(icon='Gardening.dmi',icon_state="PlantT",pixel_y=32,pixel_x=0,layer=5)
			overlays.Remove(A)
			overlays.Add(A)
			..()
	Oak
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="Z1",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="Z2",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="Z3",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="Z4",pixel_y=32,pixel_x=16,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="Z5",pixel_y=64,pixel_x=-16,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="Z6",pixel_y=64,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			..()
	RoundTree
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="01",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="02",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="03",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="04",pixel_y=32,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D)
			overlays.Add(A,B,C,D)
			..()
	Tree
		density=1
		icon='Trees.dmi'
		icon_state="Bottom"
		New()
			var/image/B=image(icon='Trees.dmi',icon_state="Middle",pixel_y=32,pixel_x=0,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="Top",pixel_y=64,pixel_x=0,layer=5)
			overlays.Remove(B,C)
			overlays.Add(B,C)
			..()
	Palm
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="A1",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="A2",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="A3",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="A4",pixel_y=32,pixel_x=16,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="A5",pixel_y=64,pixel_x=-16,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="A6",pixel_y=64,pixel_x=16,layer=5)
			var/image/G=image(icon='Trees.dmi',icon_state="A7",pixel_y=96,pixel_x=-16,layer=5)
			var/image/H=image(icon='Trees.dmi',icon_state="A8",pixel_y=96,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D,E,F,G,H)
			overlays.Add(A,B,C,D,E,F,G,H)
			..()
	LargePine
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="X1",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="X2",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="X3",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="X4",pixel_y=32,pixel_x=16,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="X5",pixel_y=64,pixel_x=-16,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="X6",pixel_y=64,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			..()
	LargePineSnow
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="S1",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="S2",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="S3",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="S4",pixel_y=32,pixel_x=16,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="S5",pixel_y=64,pixel_x=-16,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="S6",pixel_y=64,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			..()
	RedPine
		density=1
		New()
			var/image/A=image(icon='Trees.dmi',icon_state="A1",pixel_y=0,pixel_x=-16,layer=5)
			var/image/B=image(icon='Trees.dmi',icon_state="A2",pixel_y=0,pixel_x=16,layer=5)
			var/image/C=image(icon='Trees.dmi',icon_state="A3",pixel_y=32,pixel_x=-16,layer=5)
			var/image/D=image(icon='Trees.dmi',icon_state="A4",pixel_y=32,pixel_x=16,layer=5)
			var/image/E=image(icon='Trees.dmi',icon_state="A5",pixel_y=64,pixel_x=-16,layer=5)
			var/image/F=image(icon='Trees.dmi',icon_state="A6",pixel_y=64,pixel_x=16,layer=5)
			overlays.Remove(A,B,C,D,E,F)
			overlays.Add(A,B,C,D,E,F)
			..()

	NamekTree
		density=1
		New()
			overlays=null
			switch(pick(1,2,3,4))
				if(1)
					var/image/A=image(icon='Trees.dmi',icon_state="NT2",pixel_y=32,layer=5)
					var/image/B=image(icon='Trees.dmi',icon_state="NT1")
					overlays.Add(A,B)
				if(2)
					var/image/A=image(icon='Trees.dmi',icon_state="Bottom1")
					var/image/B=image(icon='Trees.dmi',icon_state="Middle1",pixel_y=32)
					var/image/C=image(icon='Trees.dmi',icon_state="Top1",pixel_y=64)
					overlays.Add(A,B,C)
				if(3)
					var/image/A=image(icon='Trees.dmi',icon_state="T0")
					var/image/B=image(icon='Trees.dmi',icon_state="T1",pixel_y=32)
					var/image/C=image(icon='Trees.dmi',icon_state="T2",pixel_y=64)
					var/image/D=image(icon='Trees.dmi',icon_state="T3",pixel_y=64,pixel_x=32)
					overlays.Add(A,B,C,D)
				if(4)
					var/image/A=image(icon='Trees.dmi',icon_state="N1")
					var/image/B=image(icon='Trees.dmi',icon_state="N2",pixel_y=32)
					var/image/C=image(icon='Trees.dmi',icon_state="N3",pixel_y=64)
					var/image/D=image(icon='Trees.dmi',icon_state="N4",pixel_y=32,pixel_x=32)
					var/image/E=image(icon='Trees.dmi',icon_state="N5",pixel_y=64,pixel_x=32)
					overlays.Add(A,B,C,D,E)
			..()

turf/Special
	Buildable=0
	Blank
		opacity=1
		Enter(mob/A)
			if(ismob(A))
				if(A.Admin>0)
					return ..()
				else
					return
			else del(A)
	Black
	CaveEntrance
		icon='Turf.dmi'
		icon_state="EntranceC"
	MountainCave
		density=1
		icon='Turf.dmi'
		icon_state="EntranceMC"
	PDTurf
		icon='PDTurf.dmi'
		icon_state="1"

	Stars
		icon = 'StarPixel.dmi'
		icon_state="2"
		Health=1.#INF
		Enter(mob/m)
			if(istype(m,/mob/Players))
				if(!(m.Race in list("Android","Bio Android","Changling","Majin","Dragon")))
					if(prob(50))
						for(var/obj/Items/Tech/SpaceMask/Q in usr)
							if(Q.suffix)
								return ..()
						m.Death(null,"suffocating in space!")
			return ..()

	Orb
		icon='Misc.dmi'
		icon_state="Spirit"
		density=0
	Ladder
		icon='Turf.dmi'
		icon_state="Ladder"
		density=0
	Sky1
		icon='Misc.dmi'
		icon_state="Sky"
		Enter(mob/M)
			if(ismob(M)) if(M.Flying||!M.density) return ..()
			else return ..()
	Sky2
		icon='Misc.dmi'
		icon_state="Clouds"
		Enter(mob/M)
			if(!Builder&&ismob(M)&&prob(20)&&(!M.Flying||M.density)) M.z=6
			return ..()
	Teleporter
		var/X
		var/Y
		var/Z
		Enter(mob/A)
			if(istype(A,/mob))
				A.loc=locate(X,Y,Z)
			else
				del(A)


obj/Turfs/Edges
	RockEdgeN
		icon='Edges.dmi'
		icon_state="1"
		dir=NORTH
	RockEdgeS
		icon='Edges.dmi'
		icon_state="1"
		dir=SOUTH
	RockEdgeW
		icon='Edges.dmi'
		icon_state="1"
		dir=WEST
	RockEdgeE
		icon='Edges.dmi'
		icon_state="1"
		dir=EAST
	RockEdge2N
		icon='Edges.dmi'
		icon_state="2"
		dir=NORTH
	RockEdge2S
		icon='Edges.dmi'
		icon_state="2"
		dir=SOUTH
	RockEdge2W
		icon='Edges.dmi'
		icon_state="2"
		dir=WEST
	RockEdge2E
		icon='Edges.dmi'
		icon_state="2"
		dir=EAST
	Edge3N
		icon='Edges.dmi'
		icon_state="3"
		dir=NORTH
	Edge3S
		icon='Edges.dmi'
		icon_state="3"
		dir=SOUTH
	Edge3W
		icon='Edges.dmi'
		icon_state="3"
		dir=WEST
	Edge3E
		icon='Edges.dmi'
		icon_state="3"
		dir=EAST
	Edge4N
		icon='Edges.dmi'
		icon_state="4"
		dir=NORTH
	Edge4S
		icon='Edges.dmi'
		icon_state="4"
		dir=SOUTH
	Edge4W
		icon='Edges.dmi'
		icon_state="4"
		dir=WEST
	Edge4E
		icon='Edges.dmi'
		icon_state="4"
		dir=EAST
	Edge5N
		icon='Edges.dmi'
		icon_state="5"
		dir=NORTH
	Edge5S
		icon='Edges.dmi'
		icon_state="5"
		dir=SOUTH
	Edge5W
		icon='Edges.dmi'
		icon_state="5"
		dir=WEST
	Edge5E
		icon='Edges.dmi'
		icon_state="5"
		dir=EAST
	Edge6N
		icon='Edges.dmi'
		icon_state="6"
		dir=NORTH
	Edge6S
		icon='Edges.dmi'
		icon_state="6"
		dir=SOUTH
	Edge6W
		icon='Edges.dmi'
		icon_state="6"
		dir=WEST
	Edge6E
		icon='Edges.dmi'
		icon_state="6"
		dir=EAST



obj/Turfs/Surf
	icon='Surf.dmi'
	Water10Surf
		icon_state="1"
	Water10Surf2
		icon_state="1N"
	Water9Surf
		icon_state="6"
	Water9Surf2
		icon_state="6N"
	Water2Surf
		icon_state="2"
	Water2Surf2
		icon_state="2N"
	Water8Surf
		icon_state="4"
	Water8Surf2
		icon_state="4N"
	Water3Surf
		icon_state="3"
	Water3Surf2
		icon_state="3N"
	Water5Surf
		icon_state="5"
	Water5Surf2
		icon_state="5N"
obj/Effects
	Health=1.#INF
	Explosion
		icon='Explosion.dmi'
		layer=MOB_LAYER+1
		New()
			pixel_x=rand(-8,8)
			pixel_y=rand(-8,8)
			spawn(rand(4,6)) if(src) del(src)
			..()
	Crater
		density=0
		icon='Craters.dmi'
		icon_state="Center"
		Grabbable=0
		Savable=0
		New()
			for(var/obj/Effects/Crater/A in view(2,src)) if(A!=src) del(src)
			var/image/A=image(icon='Craters.dmi',icon_state="N",pixel_y=32)
			var/image/B=image(icon='Craters.dmi',icon_state="S",pixel_y=-32)
			var/image/C=image(icon='Craters.dmi',icon_state="E",pixel_x=32)
			var/image/D=image(icon='Craters.dmi',icon_state="W",pixel_x=-32)
			var/image/E=image(icon='Craters.dmi',icon_state="NE",pixel_y=32,pixel_x=32)
			var/image/F=image(icon='Craters.dmi',icon_state="NW",pixel_y=32,pixel_x=-32)
			var/image/G=image(icon='Craters.dmi',icon_state="SE",pixel_y=-32,pixel_x=32)
			var/image/H=image(icon='Craters.dmi',icon_state="SW",pixel_y=-32,pixel_x=-32)
			overlays.Add(A,B,C,D,E,F,G,H)
			spawn(100) if(src) del(src)
	Lightning
		icon='LightningStrike.dmi'
		icon_state="Front"
		Grabbable=0
		Savable=0
		New()
			//for(var/obj/Effects/Lightning/A in view(2,src)) if(A!=src) del(src)
			var/image/A=image(icon='LightningStrike.dmi',icon_state="End",pixel_y=64)
			var/image/B=image(icon='LightningStrike.dmi',icon_state="Middle",pixel_y=32)
			overlays.Add(A,B)
			walk(src,SOUTH,1)
			spawn(50) if(src) del(src)
	PDEffect
		Grabbable=0
		Savable=0
		density=1

	Tornado
		icon='Effects.dmi'
		icon_state="Tornado"
		Grabbable=0
		Savable=0
		New()
			var/image/A=image(icon='Effects.dmi',icon_state="Tornado",pixel_y=64)
			var/image/B=image(icon='Effects.dmi',icon_state="Tornado",pixel_y=32)
			overlays.Add(A,B)
			walk_rand(src,4)
			spawn(75) if(src) del(src)
	DeadZone
		Grabbable=0
		Savable=0
		icon='Portal.dmi'
		icon_state="center"
		New()
			var/image/A=image(icon='Portal.dmi',icon_state="n")
			var/image/B=image(icon='Portal.dmi',icon_state="e")
			var/image/C=image(icon='Portal.dmi',icon_state="s")
			var/image/D=image(icon='Portal.dmi',icon_state="w")
			var/image/E=image(icon='Portal.dmi',icon_state="ne")
			var/image/F=image(icon='Portal.dmi',icon_state="nw")
			var/image/G=image(icon='Portal.dmi',icon_state="sw")
			var/image/H=image(icon='Portal.dmi',icon_state="se")
			A.pixel_y+=32
			B.pixel_x+=32
			C.pixel_y-=32
			D.pixel_x-=32
			E.pixel_y+=32
			E.pixel_x+=32
			F.pixel_y+=32
			F.pixel_x-=32
			G.pixel_y-=32
			G.pixel_x-=32
			H.pixel_y-=32
			H.pixel_x+=32
			overlays+=A
			overlays+=B
			overlays+=C
			overlays+=D
			overlays+=E
			overlays+=F
			overlays+=G
			overlays+=H
			spawn while(src)
				sleep(1)
				for(var/mob/M in oview(12,src)) if(prob(20))
					//M.move=1
					step_towards(M,src)
				for(var/mob/M in view(0,src))
					if(MakyoStar)
						M.loc=locate(rand(282,284),rand(44,46),1)
					else
						view(12,src)<<"[M] is sucked into the dead zone!!"
						M.loc=locate(rand(282,284),rand(44,46),10)
				if(prob(0.5)) del(src)