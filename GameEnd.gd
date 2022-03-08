extends Control

var current_scene = preload("res://Main.tscn")


func _on_TextureRect_gui_input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed('left_mous'):
			get_tree().quit()
#			yield(current_scene, "tree_exited")
#			get_tree().get_root().add_child(current_scene.instance())
#			get_tree().change_scene("res://Main.tscn")

