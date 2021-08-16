extends Position2D
onready var my_owner = get_parent()
onready var tween = $Tween
var offset_pos = Vector2(16,16)

func _ready() -> void:
	pass
	
func attack_start(direction):
	tween.interpolate_property(
		self,
		"position",
		position,
		(direction/2) + position,
		0.2,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()
	yield(tween, "tween_all_completed" )
	global_position = my_owner.global_position + offset_pos
	
func move_start(pos, direction):
	tween.interpolate_property(
		self,
		"global_position",
		global_position,
		pos+direction+offset_pos,
		0.1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
#	if is_instance_valid(old_pos):		
#		position = old_pos
	pass

func ranged_attack_start(direction, ammo):
	tween.interpolate_property(
		ammo,
		"position",
		position,
		(direction) + position,
		0.2,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()
#	yield(tween, "tween_all_completed" )
#	global_position = my_owner.global_position + offset_pos
