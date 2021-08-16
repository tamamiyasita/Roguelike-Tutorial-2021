extends 'res://Actors/BasicEnemy.gd'

var level = 2
var weight = 50
var xp = 10

func _ready() -> void:
	states = preload('res://Actors/dog_states.tres').duplicate()
