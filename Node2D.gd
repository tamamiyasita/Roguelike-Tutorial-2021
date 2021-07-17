extends Node2D
var _point = Array()
var max_point = 32
onready var line = $Line2D

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	var pos = get_viewport().get_mouse_position()
	_point.append(pos)
#	_point.append(position)
	if _point.size() > max_point:
		_point.pop_front()
		
	line.clear_points()
	for p in _point:
		line.add_point(p)
