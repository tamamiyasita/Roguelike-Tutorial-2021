extends "res://Item.gd"

var states = preload('res://Actors/player_states.tres')

signal health_change

func _ready() -> void:
	pass

func use():
	return self.name

