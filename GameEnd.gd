extends Control


func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed('left_mous'):
			get_tree().quit()
