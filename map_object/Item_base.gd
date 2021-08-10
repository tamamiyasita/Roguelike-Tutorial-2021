extends Area2D
class_name Itembase

onready var SAVE_KEY: String = "items"

func _ready() -> void:
	pass


	
	
func save(save_game: Resource):
	save_game.data["items"].append({
		"name": name,
		"position": position,
		"visible": visible,
	})
	
	
func _load(save_game: Resource):

	var data_array: Array = save_game.data["items"]
	var data = data_array.pop_front()
	
	name = data["name"]
	position = data["position"]
	visible = data["visible"]
