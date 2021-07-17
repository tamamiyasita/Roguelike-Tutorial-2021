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
		(direction/2) + position,
		0.2,
		Tween.TRANS_BACK,
		Tween.EASE_OUT
	)
	tween.start()


func _on_Tween_tween_all_completed() -> void:
	position = old_pos
