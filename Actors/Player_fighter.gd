extends Resource
class_name PlayerStates

signal health_changed(value)
signal max_changed(value)

#export(int) var max_hp = 10 setget set_max
#onready var hp = max_hp setget set_current
export var max_hp = 15
export var hp = 10
export var power = 2
export var defense = 0
export var xp = 0
export var level = 1
var next_level := {2:25, 3:60, 4:80, 5:100, 6:150, 7:210, 8:320, 9:200, 10:900}

#var wepon = null
#var armer = null

func _ready() -> void:
	next_xp()
	
func reset():
	hp = max_hp
#
func next_xp():
	return next_level[level+1]
	
func hp_change(value):
	if value + hp > max_hp:
		hp = max_hp
	else:
		hp += value

func states_change():
	return {"max_hp":max_hp, "power":power, "defense":defense}
#
#func set_max(new_max) -> void:
#	max_hp = new_max
#	max_hp = max(1, new_max)
#	emit_signal('max_changed', max_hp)
#
#
#func set_current(new_value):
#	hp = new_value
#	hp = clamp(hp, 0, max_hp)
#	emit_signal('health_changed', hp)

