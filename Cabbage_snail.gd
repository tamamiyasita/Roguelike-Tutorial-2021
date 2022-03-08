extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 28

func _ready() -> void:
	states = preload('res://Actors/cabbage_snail_states.tres').duplicate()
