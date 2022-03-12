extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 40

func _ready() -> void:
	states = preload('res://Actors/PumpkinGobrin.tres').duplicate()
