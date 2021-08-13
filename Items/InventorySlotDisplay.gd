extends CenterContainer

var inventory = preload("res://Items/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect
onready var equip_mark = $Equip_mark

signal useitem

var apple = preload('res://map_object/apple.tscn')
var force = preload('res://map_object/force.tscn')
var fb = preload("res://map_object/fb.tscn")
var cnf = preload("res://map_object/cnf_2.tscn")
var daggr = preload("res://map_object/Daggr.tscn")

var on_wepon := false

var item_list := [apple.instance(), force.instance(), fb.instance(), cnf.instance(), daggr.instance()]


func display_item(item):
	if item is Item or item is Wepon:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = load("res://Items/EmptyInventorySlot.png")
		
func _gui_input(event: InputEvent) -> void:
	var items :Node = BaseInfo.Items
	var player = BaseInfo.Player.states
	if event is InputEventMouseButton:
		if event.is_action_pressed('left_mous'):
			var item_index = get_index()
			var item = inventory.items[item_index]
			if item is Item:
				print(item.name)
				BaseInfo.item_use(item.name, item.use())
				inventory.remove_item(item_index)
				BaseInfo.Player.container.visible = false
			elif item is Wepon:
				if item.equipment == false:
					if on_wepon == false:
						BaseInfo.equip_wepon(item.equip())
						item.equipment = true
						equip_mark.show()
						player.wepon = item
						BaseInfo.Player.container.visible = false
						print(player.wepon, "player_wepon")
						on_wepon = true
						BaseInfo.Main.ui.wepon.texture = item.texture
						get_tree().call_group("message", "get_massage", "You equipped a {0}".format([item.name]))
				else:
					BaseInfo.dequip_wepon(item.equip())
					item.equipment = false
					equip_mark.hide()
					player.wepon = null
#					BaseInfo.Player.container.visible = false
					print(player.wepon, "player_wepon_hide")
					on_wepon = false
					get_tree().call_group("message", "get_massage", "You removed the {0}".format([item.name]))
					BaseInfo.Main.ui.wepon.texture = null
		elif event.is_action_pressed('light_mouse'):
			var item_index = get_index()
			var item = inventory.items[item_index]	
			for i in item_list:
				if item is Wepon:
					if item.equipment == true:
						print("wepon on")
						break

				if i.item_name == item.name:
					BaseInfo.Items.add_child(i)
					i.position = BaseInfo.Player.position
					inventory.remove_item(item_index)
					break
		
		get_tree().call_group("xpbar", "states_update")
		

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
	
