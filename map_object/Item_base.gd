extends Area2D
class_name Itembase

onready var SAVE_KEY: String = "items" + name

func _ready() -> void:
	pass

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		"position": position,
	}
	
func _load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	position = data["position"]
	
