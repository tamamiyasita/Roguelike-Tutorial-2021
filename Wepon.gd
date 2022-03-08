class_name Wepon
extends Resource


export(String) var name = ""
export(Texture) var texture
var position:Vector2 = Vector2.ZERO
export(bool) var equipment := false
export(int) var equip_value = 2


func equip():
	print("equip")
	equipment = !equipment
	return equip_value
