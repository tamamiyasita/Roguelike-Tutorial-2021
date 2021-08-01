extends TextureRect


var inventory = preload("res://Items/Inventory.tres")

func can_drop_data(_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("item")
	

func drop_data(_position: Vector2, data) -> void:
	inventory.set_item(data.item_index, data.item)
