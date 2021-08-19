extends "res://Actors/ranged_ai.gd"

var level = 3
var weight = 60
var xp = 100

func _ready() -> void:
	
	states = preload('res://Actors/Cecile_states.tres').duplicate()

func _process(delta: float) -> void:
	if self.states.hp < 1:
		get_tree().current_scene.queue_free()
		get_tree().change_scene("res://GameClear.tscn")
		
