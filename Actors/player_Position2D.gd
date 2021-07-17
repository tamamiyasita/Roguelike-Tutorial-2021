extends Position2D

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
		(direction/1.1) + position,
		0.4,
		Tween.TRANS_BACK,
		Tween.EASE_OUT_IN
	)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
	position = old_pos
