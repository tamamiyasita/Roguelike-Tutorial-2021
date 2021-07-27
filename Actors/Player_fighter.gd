extends Resource
class_name PlayerStates

signal health_changed(value)
signal max_changed(value)

export(int) var max_hp = 10 setget set_max
#onready var hp = max_hp setget set_current
export var hp = 10
export var defense = 1
export var power = 2

func _ready() -> void:
	max_hp = 20
	hp = max_hp
	defense = 1
	power = 2
	_initialize()

func reset():
	hp = max_hp

func hp_change(value):
	hp = value

func set_max(new_max) -> void:
	max_hp = new_max
	max_hp = max(1, new_max)
	emit_signal('max_changed', max_hp)
	
	
func set_current(new_value):
	hp = new_value
	hp = clamp(hp, 0, max_hp)
	emit_signal('health_changed', hp)


func _initialize():
	emit_signal('max_changed',hp, max_hp)
	emit_signal('health_changed', hp)
	

