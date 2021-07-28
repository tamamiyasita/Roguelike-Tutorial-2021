extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func use_item(item_name):
	if item_name == "apple":
		player.states.hp_changed(5)
		
