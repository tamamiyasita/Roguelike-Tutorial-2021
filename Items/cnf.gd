extends "res://Item.gd"

var par = preload("res://par/cnf_par.tscn")

func _ready() -> void:
	var part = par.instance()

func use():
#	part.start()
	return 3

