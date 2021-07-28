extends Node


onready var Player = get_node("/root/Main/Player")

func _ready() -> void:
	print(Player)
