extends Area2D

onready var pos  = $Position2D.position
onready var occ : LightOccluder2D = $LightOccluder2D 
onready var light : Light2D = $Light2D
var is_visible = false
func _ready() -> void:
	pass