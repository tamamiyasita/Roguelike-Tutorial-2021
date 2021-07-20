extends Position2D
onready var my_owner = get_parent()
onready var tween = $Tween
var old_pos
func _ready() -> void:
	pass
	
func attack_start(direction):
	old_pos = position
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
	print(global_position, my_owner.global_position)
	global_position.x = my_owner.global_position.x +16
	global_position.y = my_owner.global_position.y +16
	
func move_start(direction):
	tween.interpolate_property(
		my_owner,
		"position",
		my_owner.position,
		(my_owner.position + direction),
		0.1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
#	if is_instance_valid(old_pos):		
#		position = old_pos
	pass


