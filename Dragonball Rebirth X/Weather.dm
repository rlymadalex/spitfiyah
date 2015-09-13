area
	mouse_opacity=0
	var/WeatherOn=1
	icon='Weather.dmi'
	Outside
		New()
			layer=5
			var/list/Weathers=new
			if(istype(src,/area/Outside/Planet/Earth))
				Weathers.Add("Rain","Fog","Storm")
			if(istype(src,/area/Outside/Planet/Namek))
				Weathers.Add("Namek Rain")
			if(istype(src,/area/Outside/Planet/Vegeta))
				Weathers.Add("Rain","Fog","Storm")
			if(istype(src,/area/Outside/Planet/Ice))
				Weathers.Add("Snow","Blizzard","Night Snow")
			if(istype(src,/area/Outside/Planet/Arconia))
				Weathers.Add("Rain","Fog","Storm")
			if(istype(src,/area/Outside/Planet/Afterlife))
				Weathers.Add("")
			if(istype(src,/area/Outside/Planet/Heaven))
				Weathers.Add("Sunset","Sunrise")
			if(istype(src,/area/Outside/Planet/Hell))
				Weathers.Add("Blood Rain","Dark")
			spawn if(src)if(istype(src,/area/Outside/Planet))Weather(30000,70,Weathers)
		Planet
			var/Drillable=1
			var/Rate
			Earth
				Rate=1.1
			Namek
				Rate=1.5
			Vegeta
				Rate=0.8
			Ice
				Rate=2.4
			Arconia
				Rate=1.2
			Afterlife
				Rate=0.5
			Heaven
				Rate=0.4
			Hell
				Rate=0.6
	Inside
	proc/Weather(Timer,Clear_Weather,list/Weathers)
		icon='Weather.dmi'
		if(Weathers)
			while(src)
				sleep(Timer)
				if(prob(Clear_Weather)) icon_state=""
				else
					if(WeatherOn)
						icon_state=pick(Weathers)