extends TextureRect


var inventory = preload("res://Items/Inventory.tres")
onready var disp = $CenterContainer/Inventory_Display

func can_drop_data(_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("item")
	

func drop_data(_position: Vector2, data) -> void:
	inventory.set_item(data.item_index, data.item)



func _on_CloseButton_pressed():
	BaseInfo.Main.ui.inventory.hide()
