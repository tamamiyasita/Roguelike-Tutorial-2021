extends ProgressBar


onready var STR = $STR
onready var DEF = $DEF
onready var XP = $Label
onready var level = $Level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	states_update()
	
func states_update():
	max_value = BaseInfo.Player.states.next_xp
	value = BaseInfo.Player.states.xp
	level.text = "LEVEL "+str(BaseInfo.Player.states.level)
	STR.text = "STR "+str(BaseInfo.Player.states.power)
	DEF.text = "DEF "+str(BaseInfo.Player.states.defense)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
