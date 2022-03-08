extends Node

onready var Punch = preload("res://Actors/Skill/Punch.tscn")
onready var punch = Punch.instance()
onready var Kick = preload("res://Actors/Skill/Kick.tscn")
onready var kick = Kick.instance()
onready var Enpty = preload("res://Actors/Skill/BaseSkill.tscn")
onready var enpty = Enpty.instance()


onready var skill_dict = {
	"enpty":enpty,
	"Punch":punch,
	"Kick":kick
}

func return_instance(skill_name):
	print(skill_dict[skill_name])
	return skill_dict[skill_name]
