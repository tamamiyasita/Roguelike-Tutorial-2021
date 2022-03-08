extends Resource
class_name States



export var max_hp = 3
export var hp = 3
export var power = 1
export var defense = 1
var ai


func _ready() -> void:
	pass


func hp_change(value):
	hp += value
