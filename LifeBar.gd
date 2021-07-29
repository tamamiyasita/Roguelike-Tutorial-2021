extends ProgressBar

export var fill_rate := 1.0

var target_value := 0.0 setget set_target_value

onready var _tween: Tween = $Tween
onready var _anime_player: AnimationPlayer = $AnimationPlayer
onready var hp_value:Label = $Label

func _ready() -> void:
	_anime_player.play("normal")

func setup(states) -> void:
	max_value = states["max_hp"]
	value = max_value
	target_value = max_value
	hp_value.text = ("HP " +str(value)+"/"+ str(max_value))
	
func set_target_value(amount: float) -> void:
	if value > 0.7 * max_value:
		_anime_player.play('damage')
	elif value <= 0.7 * max_value:
		_anime_player.play('damage1')
	elif value < 0.3 * max_value:
		_anime_player.play('damage2')


	target_value = amount
	if is_instance_valid(hp_value):		
		hp_value.text = ("HP " +str(target_value)+"/"+ str(max_value))
	if is_instance_valid(_tween):		
		if _tween.is_active():
			_tween.stop_all()
			
		var duration := abs(target_value - value) / max_value * fill_rate
		
		_tween.interpolate_property(self, "value", value, target_value, duration, Tween.TRANS_QUAD)
		_tween.start()
		


func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	yield(_anime_player, "animation_finished" )
	if value < 0.3 * max_value:
		_anime_player.play("danger")
	elif value <= 0.7 * max_value:
		_anime_player.play("warning")
	elif value > 0.7 * max_value:
		_anime_player.play("normal")

