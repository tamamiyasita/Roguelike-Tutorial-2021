extends 'res://Actors/BasicEnemy.gd'

var level = 2
var weight = 45
var xp = 14

func _ready() -> void:
	states = preload('res://Actors/MonsterCarrot.tres').duplicate()
