var
	Gains=20
	IntRate=30
	EnergyGains=10
	StatGains=10
	EXPGains=10
	SpeedEffect=1
	ControlRegen=1
	ControlRecov=1
	LeechHard=50
	DrainHard=2
	MasteryHard=3
	DeclineGains=100
	GetUpVar=1.3

mob/Health=100
mob/var
	tmp/mob/Transfering
	Special=0
	asexual=0
	Warp=1
	list/GenRaces=new
	Rewarded
	tmp/Digging=0
	Regenerate=0
	list/Parents=new
	tmp/Observing=0
	tmp/SaveDelay
	ThirdEyeReq=0
	OFReq=0
	Gender
	DisplayKey
	StrFocus="Balanced"
	ForFocus="Balanced"
	OffFocus="Balanced"
	KaiokenMastery=1
	KaiokenMod=1
	KaiokenBP
	PowerUp=0
	PowerDown=0
	image/ChargeIcon
	AbsorbPower
	SSJ=0
	EXP=1
	Potential=1
	FlySkill=1
	FlySkillMod=1
	ZanzokenSkill=1
	ZanzokenSkillMod=1
	Race
	Class="Fighter"
	KO
	Build=0
	Inside=1
	Sight_Range=10
	Spawn="Earth"
	BodyType="Medium"
	tmp/IconClicked=0
	tmp/Attacking
	tmp/mob/Grab
	tmp/mob/SparGuy
	PrimeAge=20.
	Power_Multiplier=1 //This changes temporarily with the use of power altering abilities.
	BaseMod=1 //The inherent power of the race this person is playing
	StrengthMod=1
	Strength=1
	EnduranceMod=1
	Endurance=1
	ForceMod=1
	Force=1
	Resistance=1
	ResistanceMod=1
	SenseReq=2
	GravityMastered=1
	GravityMod=1
	Base=1
	RPPower=1 //Multiplies overall power, edited by admins to increase power when it is suited to do so.
	Gravity_Power=1
	Body=1
	EnergyMax=100
	Energy=100
	EnergyMod=1
	Regeneration=1
	Recovery=1
	ControlPower=100
	Anger=0
	AngerMax=1
	Grow_Rate=1
	Decline=50
	Decline_Rate=1
	OffenseMod=1
	Age=0.1
	Birth_Year=0
	Log_Year=0
	//Offense listed under 'atom'
	DefenseMod=1
	Defense=1
	SpeedMod=1
	//Speed listed under 'atom
	//Skill=1 //This raisable stat multiplies Offense and Defense effect.
	Tail
	tmp/mob/Opponent
	tmp/mob/Target
	tmp/obj/Control //An object your controlling
	Dead
	KeepBody
	Flying
	Charged_Power=0
	Charge_Icon
	Intelligence=1
	IntelligenceLevel=1
	IntelligenceEXP=0
	IntelligenceEXPNeeded=1000
	IntFocus=0
	tmp/mob/Zenkai //The person you will gain Zenkai from, derived from your Opponent usually.
	Last_Zenkai
	ZenkaiAmount=0
	Zenkai_Rate=1
	Training_Rate=1 //How fast a player catches up to a superior when being taught
	Meditation_Rate=1
atom/var
	AdminInviso=0
	Power=1 //Current available power, a compilation of many factors. Editing will do nothing
	Offense=1
	Skill=1
	Speed=1
	Efficiency=1 //Lessens the drain from energy draining abilities.
	Health
	Refire=20
	Gravity
	Password
	Level=1
	Savable
	Builder
	Buildable=1
	Stealable
	Grabbable=1
	Using
	Distance=15
	Damage_Multiplier=1
	tmp/mob/Owner
	tmp/turf/Spawn_Location
	Spawn_Timer=0
	Tabs

atom/movable/New()
	Set_Respawn(src)
	..()
atom/movable/Del()
	Respawn(src)
	..()
proc/Set_Respawn(mob/P) if(P.Spawn_Timer) P.Spawn_Location=P.loc
proc/Respawn(mob/P)
	if(P.Spawn_Timer&&P.Spawn_Location&&!P.Builder) Remake(P.type,P.Spawn_Location,P.Spawn_Timer)
	P.Spawn_Location=null
proc/Remake(Type,turf/Location,Timer) spawn(Timer) if(!Location.Builder)
	for(var/obj/A in Location) return
	new Type(Location)