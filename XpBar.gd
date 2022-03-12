extends ProgressBar

onready var Conbo = $combo
onready var STR = $STR
onready var DEF = $DEF
onready var XP = $Label
onready var level = $Level
onready var tween := $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	states_update()
	
func states_update():
	max_value = BaseInfo.Player.states.next_xp()
	value = BaseInfo.Player.states.xp
	level.text = "LEVEL "+str(BaseInfo.Player.states.level)
	STR.text = "STR "+str(BaseInfo.Player.states.power)
	DEF.text = "DEF "+str(BaseInfo.Player.states.defense)
	Conbo.text = str(BaseInfo.Player.combo_bonus)
	
func combo_pop():
	tween.interpolate_property(Conbo, "rect_scale",
	Vector2.ONE, Vector2(.5,.5), .5,
	Tween.TRANS_BOUNCE, Tween.EASE_IN)
	tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
