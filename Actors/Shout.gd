extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	shout_pop("dfsgrg", .5)


func shout_pop(value, time):
	show()
	text = "         {0}!        ".format([value])
	yield(get_tree().create_timer(time), "timeout")
	hide()
	
