extends Node

signal max_changed(new_max)
signal changed(new_amount)

export(int) var max_hp = 10 setget set_max
onready var hp = max_hp setget set_current
var defense
var power 

func _ready() -> void:
	get_tree()
	max_hp = 20
	hp = max_hp
	defense = 1
	power = 2
	_initialize()

func set_max(new_max) -> void:
	max_hp = new_max
	max_hp = max(1, new_max)
	emit_signal('max_changed', hp, max_hp)
	
	
func set_current(new_value):
	hp = new_value
	hp = clamp(hp, 0, max_hp)
	emit_signal('changed', hp)


func _initialize():
	emit_signal('max_changed',hp, max_hp)
	emit_signal('changed', hp)
	

