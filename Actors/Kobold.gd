extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 24

func _ready() -> void:
	states = preload('res://Actors/Kobold.tres').duplicate()
