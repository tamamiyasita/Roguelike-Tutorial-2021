extends Itembase


const is_item = preload('res://Items/daggr.tres')
const weight = 70
const level = 4
var item_name = "daggr"
onready var img = $image

func _ready() -> void:
	img.texture = is_item.texture
