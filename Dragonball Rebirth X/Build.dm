proc/Save_Turfs()
	set background = 1
	world<<"<small>Server: Saving Map..."
	var/Amount=0
	var/E=1
	var/savefile/F=new("Saves/Map/File[E]")
	var/list/Types=new
	var/list/Healths=new
	var/list/Levels=new
	var/list/Builders=new
	var/list/Xs=new
	var/list/Ys=new
	var/list/Zs=new
	var/list/FlyOver=new
	for(var/turf/A in Turfs)
		Types+=A.type
		Healths+="[num2text(round(A.Health),100)]"
		Levels+="[num2text(A.Level,100)]"
		Builders+=A.Builder
		Xs+=A.x
		Ys+=A.y
		Zs+=A.z
		FlyOver+=A.FlyOverAble
		Amount+=1
		if(Amount % 20000 == 0)
			F["Types"]<<Types
			F["Healths"]<<Healths
			F["Levels"]<<Levels
			F["Builders"]<<Builders
			F["Xs"]<<Xs
			F["Ys"]<<Ys
			F["Zs"]<<Zs
			F["FlyOver"]<<FlyOver
			E ++
			F=new("Saves/Map/File[E]")
			Types=new
			Healths=new
			Levels=new
			Builders=new
			Xs=new
			Ys=new
			Zs=new
			FlyOver=new

	if(Amount % 20000 != 0)
		F["Types"]<<Types
		F["Healths"]<<Healths
		F["Levels"]<<Levels
		F["Builders"]<<Builders
		F["Xs"]<<Xs
		F["Ys"]<<Ys
		F["Zs"]<<Zs
		F["FlyOver"]<<FlyOver

	world<<"<small>Server: Map Saved([Amount])."

proc/Load_Turfs()
	set background = 1
	if(fexists("Saves/Map/File1"))
		world<<"<small>Server: Loading Map..."
		var/Amount=0
		var/DebugAmount= 0
		var/E=1
		load
		if(!fexists("Saves/Map/File[E]"))
			goto end
		var/savefile/F=new("Saves/Map/File[E]")
		sleep(1)
		var/list/Types=F["Types"]
		var/list/Healths=F["Healths"]
		var/list/Levels=F["Levels"]
		var/list/Builders=F["Builders"]
		var/list/Xs=F["Xs"]
		var/list/Ys=F["Ys"]
		var/list/Zs=F["Zs"]
		var/list/FlyOver=F["FlyOver"]
		Amount = 0
		for(var/A in Types)
			Amount+=1
			DebugAmount += 1
			var/turf/T=new A(locate(text2num(list2params(Xs.Copy(Amount,Amount+1))),text2num(list2params(Ys.Copy(Amount,Amount+1))),text2num(list2params(Zs.Copy(Amount,Amount+1)))))
			T.Health=text2num(list2params(Healths.Copy(Amount,Amount+1)))
			T.Level=text2num(list2params(Levels.Copy(Amount,Amount+1)))
			T.Builder=list2params(Builders.Copy(Amount,Amount+1))
			T.FlyOverAble=text2num(list2params(FlyOver.Copy(Amount,Amount+1)))
			Turfs+=T
			if(T.Builder)
				new/area/Inside(T)
			for(var/obj/Turfs/Edges/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Surf/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/Trees/B in T) if(!B.Builder) del(B)
			for(var/obj/Turfs/B in T) if(!B.Builder) del(B)



			if(Amount == 20000)
				sleep(1)
				break

		if(Amount == 20000)
			E ++
			goto load

		end
		world<<"<small>Server: Map Loaded ([DebugAmount] in [E] Files.)"
	spawn()SpawnMaterial()





var/list/Builds=new
proc/Add_Builds()
	for(var/A in typesof(/turf))
		var/turf/C=new A(locate(1,1,1))
		if(C.Buildable&&C.type!=/turf)
			if(!istype(C,/turf/IconsX))
				var/obj/Others/Build/B=new
				B.icon=C.icon
				B.icon_state=C.icon_state
				B.Creates=C.type
				B.name="-[C.name]-"
				Builds+=B
		del(C)
	for(var/A in typesof(/obj/Turfs))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs)
			if(!istype(B,/obj/Turfs/IconsX)&&!istype(B,/obj/Turfs/IconsXLBig))
				var/obj/Others/Build/C=new
				C.icon=B.icon
				C.icon_state=B.icon_state
				C.Creates=B.type
				C.name="-[B.name]-"
				Builds+=C
	/*
	for(var/A in typesof(/obj/Turfs/Trees))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs/Trees)
			var/obj/Others/Build/C=new
			C.icon=B.icon
			C.icon_state=B.icon_state
			C.Creates=B.type
			C.name="[B.name]-B"
			Builds+=C
	for(var/A in typesof(/obj/Turfs/Edges))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs/Trees)
			var/obj/Others/Build/C=new
			C.icon=B.icon
			C.icon_state=B.icon_state
			C.Creates=B.type
			C.name="[B.name]-B"
			Builds+=C
	for(var/A in typesof(/obj/Turfs/Surf))
		var/obj/B=new A
		if(B.Buildable&&B.type!=/obj/Turfs/Trees)
			var/obj/Others/Build/C=new
			C.icon=B.icon
			C.icon_state=B.icon_state
			C.Creates=B.type
			C.name="[B.name]-B"
			Builds+=C
	*/
obj/Others/Build
	var/Creates
	verb/Inside()
		set src in world
		usr<<"You will now build 'inside' turfs that will not be affected by weather."
		usr.Inside=1
	verb/Outside()
		set src in world
		usr<<"You will now build 'outside' turfs that will be affected by weather."
		usr.Inside=0
	Click()
		if(usr.Target==src)
			usr<<"You have deselected [src]"
			usr.Target=null
			return
		Build_Lay(src,usr)
		if(usr.Target!=src)
			usr.Target=src
			usr<<"You have selected [src]"
proc/Build_Lay(obj/Others/Build/O,mob/P)
	var/mob/L=P
	if(P.Control) L=P.Control
	var/atom/C=new O.Creates(locate(L.x,L.y,L.z))
	C.Builder=P.ckey
	if(istype(C,/obj/Turfs/Door))
		C.Password=input(P,"Enter a password or leave blank") as text
		if(!C) return
		if(C.Password) if(isobj(C)) C.Grabbable=0
	if(istype(C,/obj/Turfs/Sign)) C.desc=input(P,"What do you want to write on the sign?") as text
	if(!isturf(C)) C.Savable=1
	else
		C.Savable=0
		if(P.Inside) new/area/Inside(locate(L.x,L.y,L.z))
		else new/area/Outside(locate(L.x,L.y,L.z))
		for(var/obj/Turfs/E in C) del(E)
		Turfs+=C
proc/Save_Objects()
	var/foundobjects=0
	var/savefile/F=new("Saves/Itemsave")
	var/list/L=new
	for(var/obj/A) if(A.Savable&&A.z)
		foundobjects+=1
		A.Saved_X=A.x
		A.Saved_Y=A.y
		A.Saved_Z=A.z
		L+=A
	F["SavedItems"]<<L
	world<<"<small>Server: Items saved ([foundobjects] Items)"
proc/Load_Objects()
	world<<"<small>Server: Loading Items..."
	var/amount=0
	if(fexists("Saves/Itemsave"))
		var/savefile/F=new("Saves/Itemsave")
		var/list/L=new
		F["SavedItems"]>>L
		for(var/obj/A in L)
			amount+=1
			A.loc=locate(A.Saved_X,A.Saved_Y,A.Saved_Z)
	world<<"<small>Server: Items Loaded ([amount])."
obj/var
	Saved_X
	Saved_Y
	Saved_Z