extends CenterContainer

var inventory = preload("res://Items/Inventory.tres")

onready var itemTextureRect = $ItemTextureRect
onready var equip_mark = $Equip_mark
onready var maru = $Maru

signal useitem

var apple = preload('res://map_object/apple.tscn')
var cnf = preload("res://map_object/cnf_2.tscn")
var daggr = preload("res://map_object/Daggr.tscn")
var bangle = preload("res://map_object/Bangle.tscn")
var knife = preload("res://map_object/Knife.tscn")

var on_wepon = null
var on_armor = null




func display_item(item):
	if item is Item or item is Wepon or item is Armor:
		itemTextureRect.texture = item.texture
		
	else:
		itemTextureRect.texture = load("res://Items/EmptyInventorySlot.png")
		
func update_wepon():
	for i in get_parent().get_children():
		if BaseInfo.Main.ui.wepon.texture == i.itemTextureRect.texture or\
		BaseInfo.Main.ui.armor.texture == i.itemTextureRect.texture:
			i.equip_mark.show()
		else:
			i.equip_mark.hide()
				
			
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
#				BaseInfo.Player.container.visible = false
			elif item is Wepon:
				if item.equipment == false:
					if BaseInfo.Main.ui.wepon.texture == null:
						BaseInfo.equip_wepon(item.equip())
						item.equipment = true
						equip_mark.show()
#						BaseInfo.Player.container.visible = false
						on_wepon = true
						BaseInfo.Main.ui.wepon.texture = item.texture
						get_tree().call_group("message", "get_massage", "You equipped a {0}".format([item.name]))
						
				else:
#					if on_wepon == true:
					BaseInfo.dequip_wepon(item.equip())
					item.equipment = false
#					equip_mark.hide()
					on_wepon = false
					get_tree().call_group("message", "get_massage", "You removed the {0}".format([item.name]))
					BaseInfo.Main.ui.wepon.texture = null
#					BaseInfo.Player.container.visible = false
				update_wepon()
					
			elif item is Armor:
				if item.equipment == false:
#					if on_armor == false:
					if BaseInfo.Main.ui.armor.texture == null:
						BaseInfo.equip_armor(item.equip())
						item.equipment = true
#						equip_mark.show()
#						BaseInfo.Player.container.visible = false
						on_armor = item
						BaseInfo.Main.ui.armor.texture = item.texture
						get_tree().call_group("message", "get_massage", "You equipped a {0}".format([item.name]))
				else:
					BaseInfo.dequip_armor(item.equip())
					item.equipment = false
#					equip_mark.hide()
					on_armor = null
					get_tree().call_group("message", "get_massage", "You removed the {0}".format([item.name]))
					BaseInfo.Main.ui.armor.texture = null
#					BaseInfo.Player.container.visible = false
				update_wepon()
			maru.hide()
			

#
					
					
#		elif event.is_action_pressed('light_mouse'):
#			var item_index = get_index()
#			var item = inventory.items[item_index]	
#			if is_instance_valid(item):		
#				for i in item_list:
#					if item is Wepon or item is Armor:
#						if item.equipment == true:
#							print("equip on")
#							break
#
#					if i.item_name == item.name:
#						BaseInfo.Items.add_child(i)
#						i.position = BaseInfo.Player.position
#						inventory.remove_item(item_index)
#						break
#
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
	


func _on_ItemTextureRect_mouse_entered():
	maru.show()


func _on_ItemTextureRect_mouse_exited():
	maru.hide()
