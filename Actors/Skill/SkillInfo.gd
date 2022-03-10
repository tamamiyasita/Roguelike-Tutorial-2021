extends Node

onready var Punch = "res://Actors/Skill/Punch.tscn"

onready var Kick = "res://Actors/Skill/Kick.tscn"

onready var Enpty = "res://Actors/Skill/BaseSkill.tscn"

var skill_list_name := []

onready var skill_dict = {
	"BaseSkill":"res://Actors/Skill/BaseSkill.tscn",
	"Punch":"res://Actors/Skill/Punch.tscn",
	
#	"Kick":"res://Actors/Skill/Kick.tscn",
#	"SomersaultKick":'res://Actors/Skill/SomersaultKick.tscn',
#	"SpinningBirdKick":'res://Actors/Skill/SpinningBirdKick.tscn',
#	"WhirlwindKick":'res://Actors/Skill/WhirlwindKick.tscn',
#	"Shoryuken":'res://Actors/Skill/Shoryuken.tscn',
#	"Hyakuretsukyaku":"res://Actors/Skill/Hyakuretsukyaku.tscn",
#	"Dankukyaku":"res://Actors/Skill/Dankukyaku.tscn",
#	"BurnKnuckle":"res://Actors/Skill/BurnKnuckle.tscn",
#	"ShiningFinger":"res://Actors/Skill/ShiningFinger.tscn",
#	"Hadouken":"res://Actors/Skill/Hadouken.tscn",
	"Gadouken":"res://Actors/Skill/Gadouken.tscn"
}

func return_instance(skill_name):
	if "@" in skill_name:
		return
	print(skill_dict[skill_name])
	return skill_dict[skill_name]

func _ready() -> void:
	yield(get_tree(),'idle_frame')
	for s in skill_dict:
		if s == "Punch" or s == "BaseSkill":
			continue
		skill_list_name.append(s)
	skill_list_name = Util.shuffle(skill_list_name)
