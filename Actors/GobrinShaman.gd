extends "res://Actors/ranged_ai.gd"

var level = 3
var weight = 60
var xp = 29
func _ready() -> void:
	
	states = preload('res://Actors/GobrinShaman.tres').duplicate()
