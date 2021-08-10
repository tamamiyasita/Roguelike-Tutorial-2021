extends "res://astar_path.gd"

onready var gamesaver = $GameSaver
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

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("save"):
		gamesaver.save(1)
	if Input.is_action_just_pressed("load"):
		for e in BSP_Dungeon.enemies.get_children():
			e.queue_free()
		for w in BSP_Dungeon.walls.get_children():
			w.queue_free()
		for d in BSP_Dungeon.doors.get_children():
			d.queue_free()
		for i in BSP_Dungeon.items.get_children():
			i.queue_free()			
		gamesaver._load(1)
