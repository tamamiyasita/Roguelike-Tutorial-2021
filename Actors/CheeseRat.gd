extends 'res://Actors/BasicEnemy.gd'

var level = 1
var weight = 80

func _ready() -> void:
	states = preload('res://Actors/enemy_states.tres').duplicate()
