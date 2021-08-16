extends Control


func _ready() -> void:
	pass

#func _gui_input(event: InputEvent) -> void:
		
#func _unhandled_input(event: InputEvent) -> void:
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed('left_mous'):
			get_tree().quit()
