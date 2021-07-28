extends CenterContainer

var inventory = preload("res://Items/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect

signal useitem



func display_item(item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Items/EmptyInventorySlot.png")
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var item_index = get_index()
		var item = inventory.items[item_index]
		if item is Item:
			print(item)
			BaseInfo.Player.hp_change(5)
			inventory.remove_item(item_index)
		

func get_drag_data(_position: Vector2):
	var item_index = get_index()
	var item = inventory.remove_item(item_index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = item_index
		var drag_preview = TextureRect.new()
		drag_preview.texture = item.texture
		set_drag_preview(drag_preview)
		inventory.drag_data = data
		
		return data


func can_drop_data(_position: Vector2, data):
	return data is Dictionary and data.has("item")
	
func drop_data(_position: Vector2, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index]
	inventory.swap_items(my_item_index, data.item_index)
	inventory.set_item(my_item_index, data.item)
	inventory.drag_data = null
	
