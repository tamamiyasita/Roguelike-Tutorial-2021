extends Itembase


const is_item = preload('res://Items/bangle.tres')
const weight = 70
const level = 1
var item_name = "stone bangle"
onready var img = $image

func _ready() -> void:
	img.texture = is_item.texture
