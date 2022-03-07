extends "res://Item.gd"

var par = preload("res://par/Force_par.tscn")

func _ready() -> void:
	var part = par.instance()

func use():
#	part.start()
	print("a")
	return -7

