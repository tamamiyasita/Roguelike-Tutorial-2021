extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 68

func _ready() -> void:
	states = preload('res://Actors/unicorn_states.tres').duplicate()
