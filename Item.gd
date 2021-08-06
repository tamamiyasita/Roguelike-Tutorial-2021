class_name Item
extends Resource


export(String) var name = ""
export(Texture) var texture
var position:Vector2 = Vector2.ZERO




func _ready() -> void:
	pass
	

func use():
	print("used")
