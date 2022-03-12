extends "res://Actors/ranged_ai.gd"

var level = 3
var weight = 60
var xp = 100
func _ready() -> void:
	
	states = preload('res://Actors/Cecile_states.tres').duplicate()


