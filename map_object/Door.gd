extends Area2D
# TODO ドアを閉めるのはあとで実装しようかな
var is_open := false
onready var anime :AnimationPlayer = $AnimationPlayer
onready var occ :LightOccluder2D = $LightOccluder2D
onready var light : Light2D = $Light2D
onready var SAVE_KEY: String = "door" + name
onready var sprite:Sprite = $Sprite
onready var coll: CollisionPolygon2D = $CollisionPolygon2D


func open_door() -> void:
	is_open = true
	coll.disabled = true
	occ.hide()
	light.texture = load("res://image/wood_door2.png")
	anime.play('open')
	
	

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		"is_open":is_open,
		"collsion":coll.disabled,
		"occ": occ.visible,
		"position": position,
		"texture": sprite.texture,
		"light": light.texture
	}
	print(sprite.texture)
	
func _load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	is_open = data["is_open"]
	coll.disabled = data["collsion"]
	occ.visible = data["occ"]
	position = data["position"]
	sprite.texture = data["texture"]
	light.texture = data["light"]

	print(sprite.texture)
