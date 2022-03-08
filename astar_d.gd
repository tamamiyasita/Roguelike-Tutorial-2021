extends "res://astar_path.gd"

onready var BSP_Dungeon = $BSP_Dungeon
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum {BSP}
var level_type = BSP


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level_type == BSP:
		BSP_Dungeon.generate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
