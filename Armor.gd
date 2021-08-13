class_name Wepon
extends Resource


export(String) var name = ""
export(Texture) var texture
var position:Vector2 = Vector2.ZERO
export(bool) var equipment := false


func equip():
	print("equip")
	equipment = !equipment
