extends Area2D

onready var pos  = $Position2D.position
onready var occ : LightOccluder2D = $LightOccluder2D 
onready var light : Light2D = $Light2D
var is_visible = false
var is_item = false

onready var SAVE_KEY: String = "stairs"
	
	
func save(save_game: Resource):
	save_game.data["stairs"].append({
		"name": name,
		"position": position,
		"is_visible": is_visible,
		"light": light.visible
	})
	
	
func _load(save_game: Resource):

	var data_array: Array = save_game.data["stairs"]
	var data = data_array.pop_front()
	name = data["name"]
	position = data["position"]
	is_visible = data["is_visible"]
	light.visible = data["light"]
