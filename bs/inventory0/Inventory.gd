extends Control


var template_inv_slot = preload('res://InventorySlot.tscn')

onready var gridcontainer = $Background/M/V/ScrollContainer/GridContainer


func _ready() -> void:
	for i in PlayerData.inv_data.keys():
		var inv_slot_new = template_inv_slot.instance()
		if PlayerData.inv_data[i]["Item"] != null:
			var item_name = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]
			var icon_texture = load("res://Assets/Icon_Items/" + item_name + ".png")
			inv_slot_new.get_node('Icon').set_texture(icon_texture)
		gridcontainer.add_child(inv_slot_new, true)
