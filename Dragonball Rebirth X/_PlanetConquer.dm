obj
	PlanetFlag
		var/Zz
		Grabbable=0
		Savable=1
		Health=1.#INF
		layer=6
		icon='Flag.dmi'
		Pole
			layer=2
			var/flag
			icon_state="Pole"
		verb
			Action()
				set src in view(1)
				if(!src.Owner)
					src.Owner=usr.key
					usr<<"You have claimed this flag!"
					src.Flagize()
				else if(src.Owner==usr.key)
					src.Flagize()
				else
					usr<<"Claiming flag..."
					spawn(60)
						if(usr in view(1,src))
							if(src.Owner!=usr.key)
								src.overlays-=overlays
								usr<<"Flag claimed!"
								src.Owner=usr.key
								src.Flagize()
		proc
			Flagize()
				src.overlays-=overlays
				var/NP=copytext(input("Input the name to represent your planet!"),1,30)
				var/buh=copytext(input("Input the TWO LETTERS to put on the flag."),1,3)
				if(length(buh)!=2)
					usr<<"Wrong input! Must be two letters, no less, no more!"
					return
				var/obj/PlanetFlag/Q=new
				var/obj/PlanetFlag/L1=new
				var/obj/PlanetFlag/L2=new
				var/obj/PlanetFlag/P=new
				L1.layer=8
				L2.layer=8
				P.icon_state="Pole2"
				var/polecolor = input("Pole color?") as color
				P.icon+=polecolor
				src.icon='Flag.dmi'
				src.icon_state="Pole"
				src.icon+=polecolor
				src.overlays+=image(P,pixel_y=32)
				var/flagcolor = input("What color do you want to have as the flag background?") as color
				Q.icon += flagcolor
				Q.icon_state="Flag"
				var/lettercolor = input("Color for the flag letters?") as color
				L1.icon += lettercolor
				L2.icon += lettercolor
				L1.icon_state="[uppertext(copytext(buh,1,2))]"
				L2.icon_state="[uppertext(copytext(buh,2,3))]"
				Q.overlays+=image(L1,pixel_x=-8)
				Q.overlays+=image(L2,pixel_x=8)
				src.overlays+=image(Q,pixel_y=32)
				for(var/obj/Planets/Alien/W in world)
					if(W.Zz==src.Zz)
						W.name=NP
						src.name="[NP] Flag"
						W.overlays-=W.overlays
						W.overlays+=image(Q,pixel_y=32,pixel_x=32)