extends Label


func _ready() -> void:
	pass


func _on_LifeBar_value_changed(value) -> void:
	var t = str(value)
	text = "HP: "+t
