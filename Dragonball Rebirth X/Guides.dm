//ADD GIVE POWER TO KAIOSHIN AND SHIT
var/list/Rankz=list(\
"Basic"=list(/obj/Skills/Fly,/obj/Skills/Attacks/Blast,/obj/Skills/Attacks/Charge,/obj/Skills/Attacks/Beams/Beam),

"Guardian"=list(/obj/Skills/Heal,/obj/Skills/PowerControl,/obj/Skills/Materialization,/obj/Skills/Rank/Shield,/obj/Skills/Rank/GivePower,/obj/Skills/Rank/UnlockPotential,/obj/Skills/Observe,/obj/Skills/Telepathy),
"Assistant Guardian"=list(/obj/Skills/Heal,/obj/Skills/Rank/GivePower,/obj/Skills/Rank/Zanzoken,/obj/Skills/PowerControl),
"Turtle Hermit"=list(/obj/Skills/Attacks/Beams/Kamehameha,/obj/Skills/Rank/Zanzoken,/obj/Skills/Buffs/Expand,/obj/Skills/Buffs/Focus,/obj/Skills/Heal,/obj/Skills/Rank/GivePower),
"Crane Hermit"=list(/obj/Skills/Attacks/Beams/Dodompa,/obj/Skills/Rank/Taiyoken,/obj/Skills/Attacks/Kikoho,/obj/Skills/SelfDestruct,/obj/Skills/Rank/Splitform),
"Wolf Hermit"=list(/obj/Skills/Attacks/WolfFangFist,/obj/Skills/Buffs/Focus,/obj/Skills/Buffs/Expand,/obj/Skills/Rank/Zanzoken),
"Earth Teacher"=list(/obj/Skills/Rank/Shield,/obj/Skills/Heal,/obj/Skills/Attacks/Sokidan,/obj/Skills/Rank/Kiai,/obj/Skills/Attacks/Kienzan),

"Namekian Elder"=list(/obj/Skills/PowerControl,/obj/Skills/Heal,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/Shield,/obj/Skills/Rank/UnlockPotential,/obj/Skills/Rank/GivePower,/obj/Skills/NamekianFusion,/obj/Skills/Rank/Dragonballs),
"Namek Teacher"=list(/obj/Skills/Rank/Shield,/obj/Skills/Heal,/obj/Skills/Buffs/Focus,/obj/Skills/Attacks/Beams/Masenko,/obj/Skills/Attacks/Beams/Piercer,/obj/Skills/Attacks/Sokidan,/obj/Skills/Attacks/Makosen,/obj/Skills/Buffs/Expand,/obj/Skills/Rank/Zanzoken,/obj/Skills/Rank/GivePower,/obj/Skills/NamekianFusion),

"Vegeta Leader"=list(/obj/Skills/Attacks/Beams/GalicGun,/obj/Skills/Attacks/Beams/FinalFlash,/obj/Skills/Buffs/Expand,/obj/Skills/PowerControl,/obj/Skills/FalseMoon),
"Vegeta Teacher"=list(/obj/Skills/SelfDestruct,/obj/Skills/Buffs/Expand,/obj/Skills/Attacks/Barrage),

"Yardrat Master"=list(/obj/Skills/Rank/ShunkanIdo,/obj/Skills/Rank/Zanzoken,/obj/Skills/Attacks/Sokidan,/obj/Skills/Heal,/obj/Skills/Rank/Shield),
"Arconia SM"=list(/obj/Skills/Rank/Splitform,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Expand),

"Changling Lord"=list(/obj/Skills/Attacks/Kienzan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Expand,/obj/Skills/Attacks/Beams/Ray),
"Ice SM"=list(/obj/Skills/PowerControl,/obj/Skills/Rank/Shield,/obj/Skills/Buffs/Focus,/obj/Skills/Attacks/Sokidan),

"Kaioshin"=list(/obj/Skills/Buffs/Mystic,/obj/Skills/Rank/Mysticize,/obj/Skills/Rank/KaioTeleport,/obj/Skills/Attacks/HomingFinisher,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/KeepBody,/obj/Skills/Heal,/obj/Skills/Rank/Shield,/obj/Skills/Rank/UnlockPotential,/obj/Skills/Rank/RestoreYouth,/obj/Skills/Rank/Bind,/obj/Skills/Rank/GivePower,/obj/Skills/Observe,/obj/Skills/Telepathy,/obj/Skills/Attacks/SpiritGun),
"North Kaio"=list(/obj/Skills/Buffs/Mystic,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/KeepBody,/obj/Skills/Heal,/obj/Skills/Rank/Shield,/obj/Skills/Rank/Kaioken,/obj/Skills/Rank/GivePower,/obj/Skills/Observe,/obj/Skills/Telepathy),
"South Kaio"=list(/obj/Skills/Buffs/Mystic,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/KeepBody,/obj/Skills/Heal,/obj/Skills/Rank/Shield,/obj/Skills/Rank/Splitform,/obj/Skills/Rank/GivePower,/obj/Skills/Observe,/obj/Skills/Telepathy),
"East Kaio"=list(/obj/Skills/Buffs/Mystic,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/KeepBody,/obj/Skills/Heal,/obj/Skills/Rank/Shield,/obj/Skills/Buffs/Expand,/obj/Skills/Rank/GivePower,/obj/Skills/Observe,/obj/Skills/Telepathy),
"West Kaio"=list(/obj/Skills/Buffs/Mystic,/obj/Skills/Attacks/Sokidan,/obj/Skills/PowerControl,/obj/Skills/Buffs/Focus,/obj/Skills/Materialization,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/KeepBody,/obj/Skills/Heal,/obj/Skills/Rank/Shield,/obj/Skills/SelfDestruct,/obj/Skills/Rank/GivePower,/obj/Skills/Observe,/obj/Skills/Telepathy),

"Daimaou"=list(/obj/Skills/Attacks/Kienzan,/obj/Skills/Attacks/Beams/Piercer,/obj/Skills/Buffs/Majin,/obj/Skills/Rank/KaioRevive,/obj/Skills/Rank/MakeAmulet,/obj/Skills/Buffs/Expand,/obj/Skills/PowerControl,/obj/Skills/SelfDestruct,/obj/Skills/Attacks/Sokidan,/obj/Skills/Buffs/Focus,/obj/Skills/Rank/Shield,/obj/Skills/Rank/Majinize,/obj/Skills/Rank/CurseEyes,/obj/Skills/Rank/KeepBody,/obj/Skills/Materialization,/obj/Skills/Rank/Imitation,/obj/Skills/Rank/RestoreYouth,/obj/Skills/Rank/Bind,/obj/Skills/Buffs/DemonicWill,/obj/Skills/Observe,/obj/Skills/Telepathy),
"Hell SM"=list(/obj/Skills/Attacks/Kienzan,/obj/Skills/Attacks/Beams/Ray,/obj/Skills/Attacks/Sokidan,/obj/Skills/Buffs/Expand,/obj/Skills/Materialization,/obj/Skills/SelfDestruct,/obj/Skills/Buffs/DemonicWill,/obj/Skills/Rank/Imitation,/obj/Skills/Attacks/Barrage)
)



var/Ranks={"<html><body>
Earth
 <ul>
  <li>Guardian:</li>
  <li>Assistant Guardian:</li>
  <li>Turtle Hermit: </li>
  <li>Wolf Hermit: </li>
  <li>Crane Hermit: </li>
  <li>Teachers(1-2): </li>
 </ul>
Namek
 <ul>
  <li>Elder:</li>
  <li>Teachers(1-2):</li>
 </ul>
Vegeta
 <ul>
  <li>King/Queen:</li>
  <li>Teachers(1-3):</li>
 </ul>
Arconia
 <ul>
  <li>Yardrat Master:</li>
  <li>Skill Masters(1-2):</li>
 </ul>
Ice Planet
 <ul>
  <li>Changling Lord:</li>
  <li>Skill Masters(1-2):</li>
 </ul>
Heaven / Checkpoint
 <ul>
  <li>Kaioshin:</li>
  <li>North Kaio:</li>
  <li>South Kaio:</li>
  <li>East Kaio:</li>
  <li>West Kaio:</li>
 </ul>
Hell
 <ul>
  <li>Daimaous(1-2):</li>
  <li>Skill Masters(1-2):</li>
 </ul>
*Notes*<br>
Teachers and Skill Masters are the same except for one thing, Skill Masters are not obligated to teach anybody, ever.

Teachers can choose "worthy" students based on whatever criteria they want, but they still must teach, even if its only to

those they deem worthy.
<br>

</body><html>"}

var/AdminNotes={"
<html><head><title>Admin Notes</title></head><body><body bgcolor="#000000">
<font color="#CCCCCC"><center><h1>Swaggg!</h1></center><hr>
blah!
"}

var/Notes={"<html><head><title>Notes</title></head><body><body bgcolor="#000000">
<font color="#CCCCCC"><center><h1>Welcome!</h1></center>
Who are -you- to judge character? Jump into the adventure with your very own character that you can constructvely roleplay!
<br>
<b>Reasons to play:</b>
<nl>
 <li>Near-daily updates!</li>
 <li>A game for the -players-, not the admins!</li>
 <li>This game wasn't programmed by Archonex nor Dragonn! -pounce-</li>
 <li>An experienced mature owner :)</li>
</nl>

</body></html>
"}


var/Story={"

"}
var/Rules={"The rules that already reside in the Guide, and common-sense. A real rules sheet will be created in time.

"}



mob/proc/Index(var/blah)
	var/htmlz={"<body bgcolor="#000000" text="#CCCCCC" link="aqua" vlink="green" alink="white">
<font face="Tahoma" style="font-size: 8pt"> <center><big><b>[blah]</b></big></center><br>"}
	switch(blah)
		if("Index")
			src<<browse({"[htmlz]
<b>Welcome to [world.name]!</b><br>
Click on the guide(s) pertaining to your curiousity.<br><br>
<font color=red>Be <i>SURE</i> to read the Rules and if you're new I suggest the Guide!<font color=white><br><br>
<a href=?src=\ref[usr];action=Updates>Updates</a><br><hr>
<a href=?src=\ref[usr];action=Rules>Rules</a><br><hr>
<a href=?src=\ref[usr];action=Story>Story</a><br><hr>
<a href=?src=\ref[usr];action=Ranks>Ranks</a><br><hr>
<a href=?src=\ref[usr];action=Guide>Guide</a><br><hr><br>"})
		if("Story")
			src<<browse("[htmlz]<a href=?src=\ref[usr];action=Index>Return to Index</a><br><hr>[Story]<br><br>")
		if("Rules")
			src<<browse("[htmlz]<a href=?src=\ref[usr];action=Index>Return to Index</a><br><hr>[Rules]<br><br>")
		if("Ranks")
			src<<browse("[htmlz]<a href=?src=\ref[usr];action=Index>Return to Index</a><br><hr>[Ranks]<br><br>")
		if("Updates")
			src<<browse("[htmlz]<a href=?src=\ref[usr];action=Index>Return to Index</a><br><hr>[Updates]<br><br>")
		if("Guide")
			src<<browse("[htmlz]<a href=?src=\ref[usr];action=Index>Return to Index</a><br><hr>[Guide]<br><br>")

mob/Topic(A,B[])
	if(B["action"]!="edit")
		switch(B["action"])
			if("Index")
				usr.Index("Index")
			if("Guide")
				usr.Index("Guide")
			if("Story")
				usr.Index("Story")
			if("Rules")
				usr.Index("Rules")
			if("Ranks")
				usr.Index("Ranks")
			if("Updates")
				usr.Index("Updates")
	else
		..()


client/Topic(href,href_list[],hsrc)
	if(href_list["action"]=="MasterControl"&&ismob(hsrc))
		if(href_list["do"]=="PM")
			usr:PM(hsrc)
		else
			if(usr:Admin)
				if(href_list["do"])
					switch(href_list["do"])
						if("Adminize")
							usr:Adminize(hsrc)
						if("Edit")
							usr:Edit(hsrc)
						if("Mute")
							usr:Mute(hsrc)
						if("Observe")
							usr:Observe_(hsrc)
						if("Heal")
							usr:AdminHeal(hsrc)
						if("Ban")
							usr:Ban(hsrc)
						if("Give")
							usr:Give(hsrc)
						if("Revive")
							usr:AdminRevive(hsrc)
						if("Summon")
							usr:Summon(hsrc)
						if("Teleport")
							usr:Teleport(hsrc)
						if("XYZTeleport")
							usr:XYZTeleport(hsrc)
						if("Log")
							usr:PlayerLog(hsrc)
						if("Assess")
							usr<<browse(hsrc:GetAssess(),"window=Assess;size=275x650")
						if("Boot")
							usr:Delete(hsrc)
						if("KO")
							usr:AdminKO(hsrc)
						if("Kill")
							usr:AdminKill(hsrc)
						if("SendToSpawn")
							usr:SendToSpawnz(hsrc)
						if("Reward")
							usr:Reward(hsrc)
				else
					var/View={"<html><head><title>Player Control [hsrc:key]</title><body>
					<font size=3><font color=red>[hsrc:name]<hr><font size=2><font color=black>"}
					View+={"

					\[ <a href=?src=\ref[hsrc];action=MasterControl;do=Adminize>Promote/Demote</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Mute>Mute</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=PM>Admin PM</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Observe>Observe</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=SendToSpawn>Send to Spawn</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Assess>Assess | <a href=?src=\ref[hsrc];action=MasterControl;do=Give>Give</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Kill>Kill</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=KO>Knockout</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Heal>Heal<a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Revive>Revive</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Log>Check Log</a href>  | <a href=?src=\ref[hsrc];action=MasterControl;do=Reward>Reward</a href>  | <a href=?src=\ref[hsrc];action=MasterControl;do=Edit>Edit</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Summon>Summon</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Teleport>Teleport to</a href>  | <a href=?src=\ref[hsrc];action=MasterControl;do=XYZTeleport>XYZ Teleport</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Boot>Boot</a href> | <a href=?src=\ref[hsrc];action=MasterControl;do=Ban>Ban</a href> \]
					"}
					src<<browse(View,"window=Person;size=500x135")
	..()


var/Guide={"
<html>
<head><title>Guide</title></head>
<body><body bgcolor=black text=white>
<p>The guide isn't all done as you might contemplate, but its good

enough for now.</p>
 <h2>Roleplay</h2>
  <p>There is a roleplay game! Use the say verb and emote verb

frequenctly and often! Rewards in this game are based on roleplay! Sure

you could train all day and not roleplay but eventually rewards will

become more important and you will be left in the desert power-wise.</p>
<ul>
<li><b>Battle</b> Make it clear that you want to initiate battle with

someone, then allow them time to respond. DONT countdown like a panzy

unless its been awhile and you think they're stalling, its alright to

countdown then.</li>
<li><b>Stealing</b> Make your intention clear then countdown despite if

anyones around, if someone intervenes in stopping you, stop what you're

doing and reply to them, then countdown again.</li>
<li><b>Killing</b> Enter your roleplay, and if theres no one around,

kill them. However, if there is, you must hit countdown, and if anyone

intervenes you must stop what you're doing and reply to them and then

recountdown unless you make clear in your roleplay that you do not

intend to stop, in that case that person can react to you, and you can

react to the person you're trying to kill.
</ul>

 <h2>Training</h2>
  <p>There are a few ways of training: training skills, flying,

sparring, punching logs or punching bags. You can intensify and increase

the gain by using weights or using gravity!</p>
 <h2>Items</h2>
 <p>I spoon-fed you most of the skills but these you're going to have to

find out :)</p>
<h2>Mating/Breeding</h2>
 <p>I'll let you figure this one out too :)</p>
 <h2>Skills</h2>
 <p>Nearly all skills are masterable besides skills like self destruct

for obvious reasons. There are three ways to learn a skill: naturally,

observing, or being taught. After a skill is mastered 100% you may teach

it to someone using the teach verb, otherwise you can 'teach' them it be

continually using it in front of them, otherwise known as 'leeching'.

Some skills are more diffucult to leech then others, and some even have

energy reqs. before even considering if you can learn it.</p>
 <ul>
   <li><b>Beams</b>  A channeled beam of concentrated energy that

increases in distance, power, and speed when trained.
    <ol>
      <li>Basic - naturally learned</li>
      <li>Dodompa</li>
      <li>Final Flash</li>
      <li>Galic Gun - a multi-tiled beam.</li>
      <li>Kamehameha - a multi-tiled beam.</li>
      <li>Masenko</li>
      <li>Piercer</li>
      <li>Ray</li>
    </ol></li>
   <li><b>Blast</b> A basic skill, naturally learned by every race at a

certain energy req. Fires a single rapid blast that if trained can

lessen the delay for rapid fire action! </li>
   <li><b>Charge</b> A basic skill, naturally learned by every race at a

certain energy req. A single super charged ki blast. At first the blast

takes seemingly forever to charge but as its mastery increases the

tediousness decreases, a decent refire time for a well-worth charged

ball of energy!</li>
   <li><b>Expand</b> A muscle manipulation skill, allows the user to

sacrifice a bit of their recovery, skill, and speed for extra power,

strength, and endurance! Trainable up to 4 times expansion. </li>
   <li><b>Fly</b> A basic skill, naturally learned by every race at a

certain energy req. Circulates energy outward to levitate into the air

enabling flight over buildings, water, and the such. Drain is reduced

upon training.</li>
   <li><b>Focus</b> A mind enhancement skill, allows the user to

heighten their force, regeneration, speed, and power at the cost of a

steady drain! The drain lessens upon more mastery. </li>
   <li><b>Give Power</b> A power transfer skill, the user sacrifices

their well-being to give their power to another. The higher the mastery

the less percent of getting knocked out. </li>
   <li><b>Heal</b> A healing technique, the user sacrifices some of

their energy and power to restore the health of another person. The

higher the mastery the less consequence. </li>
   <li><b>Homing Finisher</b> A homing type of energy attack, creating

multiple concentrated balls of energy that target against a victim. The

higher the mastery, the more spheres and less delay. </li>
   <li><b>Invisibility</b> An invisibility rendering skill, unmasterable

at thsi time. </li>
   <li><b>Kaioken</b> A special skill devised by the North Kaio,

masterable up to 20x. </li>
   <li><b>Kienzan</b> A piercing disc of concentrated energy that will

slice through person after wall after wall after person. Trainable to

reduce charge time and delay. </li>
   <li><b>Kikoho</b> A multi-tiled huge sphere of concentrated energy,

takes a toll out of its user to use but the consequence can be lessened

upon mastery along with delay. </li>
   <li><b>Kiai</b> An energy explosion type of attack, damages people in

the area and sends them flying. Damage and distance multiplier can be

increased by mastery. </li>
   <li><b>Majinize</b> Used by the Daimaou to create servants. </li>
   <li><b>Majin</b> A buff type of skill that increases raw power but

grants servitude to the one who majinized you. </li>
   <li><b>Make Amulet</b> Used by the Daimaou to create Amulets to the

dead zone. </li>
   <li><b>Makosen</b> A series of blasts are combursted instantly. Delay

decreased and blasts increased upon mastery. </li>
   <li><b>Materialize</b> Materialize weights out of thin air! Weights

are used for training enhancements. </li>
   <li><b>Mysticize</b> Used by the kaioshin to purify their loyals.

</li>
   <li><b>Mystic</b> A buff type of skill that increases potential

rather than raw power, cancels anger. </li>
   <li><b>Namekian Fusion</b> Racial skill for namekians, pay the

ultimate price with their life, is it worth it for the power? Obviously

unmasterable.</li>
   <li><b>Observe</b> Used to observe people! Unmasterable. </li>
   <li><b>Planet Destruction</b> beh </li>
   <li><b>Power Control</b> Lower your higher your power, unmasterable

at thsi time but will change in the future. </li>
   <li><b>Regenerate</b> Namekian racial skill, unmasterable. Sacrifice

energy for increased health regeneration. </li>
   <li><b>Revive</b> Can be used to revive the dead! Unmasterable. </li>
   <li><b>Self Destruct</b> Pretty obvious, unmasterable. </li>
   <li><b>Shield</b> A skill used to lessen the severity of energy

attacks and the such- drains upon impact. Unmasterable. </li>
   <li><b>Shunkan Ido</b> A skill devised by the Master, can teleport to

any person if in their range of mastery specifications. </li>
   <li><b>Sokidan</b> A manipulation sphere of energy that you can

control by shifting your direction. Higher mastery means faster

reaction, less delay. </li>
   <li><b>Splitform</b> Can duplicate an exact replica of yourself,

clicking them gives control over their actions. Higher mastery means a

higher number of splitforms at one time. </li>
   <li><b>Taiyoken</b> A skill devised by the crane hermit, can blind

their victims. Range and severity increases upon mastery. </li>
   <li><b>Telepathy</b> Obtained by nearly everyone after a certain req,

allows communication between two people telepathically. </li>
   <li><b>Teleport</b> Used by supremacy rulers such as the kaioshin,

this is leechable as well so watch out! </li>
   <li><b>Third Eye</b> A racial skill for humans after a certain req. A

buff that increases regeneration, power, speed and the such at the

expense of lowered anger. </li>
   <li><b>Unlock Potential</b> A skill used by supremacy rulers and such

to unlock powers deep in an individual. Can only be used once on a

person. </li>
   <li><b>Zanzoken</b> Increases velocity to unimaginable heights, click

a turf to instantly 'zap' to it. Increasing mastery decreases drain.

</li>



 </ul>



</body>
</html>
"}