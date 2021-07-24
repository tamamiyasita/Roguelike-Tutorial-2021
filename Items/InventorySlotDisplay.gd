extends CenterContainer

var inventory = preload("res://Items/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect

func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Items/EmptyInventorySlot.png")
		

func get_drag_data(_position: Vector2):
	pass


func can_drop_data(_position: Vector2, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position: Vector2, data):
	pass
	
