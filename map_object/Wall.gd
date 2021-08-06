extends Area2D

onready var pos  = $Position2D.position
onready var occ : LightOccluder2D = $LightOccluder2D 
onready var light : Light2D = $Light2D
var is_visible = false

onready var SAVE_KEY: String = "obj" + name
	

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		"position": position,
		"is_visible": is_visible,
		"light": light.visible
	}
	
func _load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	position = data["position"]
	is_visible = data["is_visible"]
	light.visible = data["light"]
	
