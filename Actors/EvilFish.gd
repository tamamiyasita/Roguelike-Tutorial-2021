extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 29

func _ready() -> void:
	states = preload('res://Actors/EvilFish.tres').duplicate()
