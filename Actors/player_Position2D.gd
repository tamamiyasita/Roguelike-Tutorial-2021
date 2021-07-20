extends Position2D

onready var player = get_parent()
onready var tween = $Tween
func _ready() -> void:
	pass
	
func attack_start(direction):
	tween.interpolate_property(
		self,
		"position",
		position,
		(direction/1.1) + position,
		0.4,
		Tween.TRANS_BACK,
		Tween.EASE_OUT_IN
	)
	tween.start()
	yield(tween, "tween_all_completed" )
	global_position.x = player.global_position.x +16
	global_position.y = player.global_position.y +16
	
func move_start(direction):
	tween.interpolate_property(
		player,
		"position",
		player.position,
		(player.position + direction),
		0.1,
		Tween.TRANS_SINE,
		Tween.EASE_IN
	)
	tween.start()
#	yield(tween, "tween_all_completed" )

func _on_Tween_tween_all_completed() -> void:
#	position = old_pos
	pass
