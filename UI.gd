extends CanvasLayer


onready var lifeber = $Position2D/LifeBar
onready var massage_box = $Position2D/MessageBox
onready var wepon = $Wepon
onready var armor = $Armor
onready var pop = $pops
onready var pop2 = $pops2
onready var inventory = $CanvasLayer/InventoryContainer


func _ready() -> void:
	pass



func _on_TextureButton_pressed():
	BaseInfo.Main.ui.inventory.visible = !BaseInfo.Main.ui.inventory.visible
