extends 'res://Actors/BasicEnemy.gd'

var level = 3
var weight = 30
var xp = 0

func _ready() -> void:
	states = preload('res://Actors/MasterRou.tres').duplicate()
	
func _process(delta: float) -> void:
	if self.states.hp < 1:
#		get_tree().current_scene.queue_free()
		get_tree().change_scene("res://GameClear.tscn")
#		get_tree().change_scene(get_tree().current_scene.filename)
		
