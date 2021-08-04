extends "res://astar_path.gd"


onready var BSP_Dungeon = $BSP_Dungeon
onready var player = get_parent().find_node("Player")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
enum {BSP}
var level_type = BSP
var Dungeon

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(player)
	if level_type == BSP:
		Dungeon = BSP_Dungeon
	Dungeon.generate()
	Dungeon.set_player_position(player)
	a_path_ready()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
