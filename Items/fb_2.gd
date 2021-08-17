extends "res://Item.gd"

var par = preload("res://par/FB_par.tscn")

func _ready() -> void:
	var part = par.instance()

func use():
#	part.start()
	return -9
	BaseInfo.Main.ui.pop2.show()
