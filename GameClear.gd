extends Control


func _ready() -> void:
	pass

#func _gui_input(event: InputEvent) -> void:
		
#func _unhandled_input(event: InputEvent) -> void:



func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed('left_mous'):
			queue_free()


