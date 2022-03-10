extends Position2D

onready var player = get_parent()
onready var tween = $Tween
var offset_pos = Vector2(16,16)


func _ready() -> void:
	pass
	
func attack_start(node, direction, length = 0.4, derec = 1.2):
	tween.interpolate_property(
		node,
		"position",
		node.position,
		(direction/derec) + position,
		length,
		Tween.TRANS_BACK,
		Tween.EASE_OUT_IN
	)
	tween.start()
	yield(tween, "tween_all_completed" )
	node.global_position = player.global_position + offset_pos
	
func move_start(pos, direction):
	tween.interpolate_property(
		self,
		"global_position",
		global_position,
		pos+direction+offset_pos,
		0.1,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	tween.start()
#	yield(tween, "tween_all_completed" )

func _on_Tween_tween_all_completed() -> void:
#	position = old_pos
	pass
