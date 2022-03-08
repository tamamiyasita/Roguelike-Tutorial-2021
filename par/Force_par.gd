extends CPUParticles2D


func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if emitting == false:
		queue_free()

func start() ->void:
	emitting = true
	set_process(true)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('down'):
		position = Vector2(200,200)
		start()
