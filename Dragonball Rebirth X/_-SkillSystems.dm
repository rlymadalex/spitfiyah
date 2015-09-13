mob/var/tmp/Swim=0

mob/var/list
	Skillz=list(\
	"Unarmed"=list("Level"=1,"Next"=10,"Current"=0),
	"Sword"=list("Level"=1,"Next"=10,"Current"=0),
	"Swim"=list("Level"=1,"Next"=10,"Current"=0),
	"Warp"=list("Level"=1,"Next"=10,"Current"=0),
	"Dig"=list("Level"=1,"Next"=10,"Current"=0)
	)


mob/proc/SkillUP(var/param,var/amount)
	src.Skillz[param]["Current"]+=amount
	if(src.Skillz[param]["Current"]>=src.Skillz[param]["Next"])
		src.Skillz[param]["Level"]++
		src.Skillz[param]["Current"]=0
		src.Skillz[param]["Next"]=src.Skillz[param]["Level"]*10