extends Area2D
# TODO ドアを閉めるのはあとで実装しようかな
var is_open := false
onready var anime :AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

func open_door() -> void:
	is_open = true
	anime.play('open')
	
