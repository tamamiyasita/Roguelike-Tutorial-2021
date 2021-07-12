extends Area2D
# TODO ドアを閉めるのはあとで実装しようかな
var is_open := false
onready var anime :AnimationPlayer = $AnimationPlayer
onready var occ :LightOccluder2D = $LightOccluder2D

func _ready() -> void:
	pass

func open_door() -> void:
	is_open = true
	$CollisionPolygon2D.disabled = true
	occ.hide()
	anime.play('open')
	
