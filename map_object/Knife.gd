extends Itembase


const is_item = preload('res://Items/knife.tres')
const weight = 70
const level = 1
var item_name = "knife"
onready var img = $image

func _ready() -> void:
	img.texture = is_item.texture
