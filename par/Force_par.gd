extends CPUParticles2D


func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if emitting == false:
		queue_free()

func start() ->void:
	emitting = true
	set_process(true)
