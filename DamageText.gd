extends Label
onready var tween = $Tween

func show_value(value, travel, duration, spread, crit=false):
	text = value
	var movement = travel.rotated(rand_range(-spread/2, spread/2))
	rect_pivot_offset = rect_size / 2
	
