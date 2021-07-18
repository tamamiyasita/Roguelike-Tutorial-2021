extends ProgressBar

export var fill_rate := 1.0

var target_value := 0.0 setget set_target_value

onready var _tween: Tween = $Tween
onready var _anime_player: AnimationPlayer = $AnimationPlayer


func setup(health: float, max_health: float) -> void:
	max_value = max_health
	value = health
	target_value = health
	
	_tween.connect("tween_completed", self, "_on_Tween_tween_completed") 
	
func set_target_value(amount: float) -> void:
	if target_value > amount:
		_anime_player.play('damage')
		
	target_value = amount
	if is_instance_valid(_tween):		
		if _tween.is_active():
			_tween.stop_all()
			
		var duration := abs(target_value - value) / max_value * fill_rate
		
		_tween.interpolate_property(self, "value", value, target_value, duration, Tween.TRANS_QUAD)
		_tween.start()
		


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if value < 0.2 * max_value:
		_anime_player.play("danger")


