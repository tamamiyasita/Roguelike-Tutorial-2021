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
signal level
signal save_p
signal load_p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	next_map()
	

func next_map():
	if level_type == BSP:
		Dungeon = BSP_Dungeon
	Dungeon.generate()
	Dungeon.set_player_position(player)
	a_path_ready()
	BaseInfo.Main.dungeon_Lv += 1
	player.hp_change(int(player.states.max_hp/2))
	emit_signal('level', BaseInfo.Main.dungeon_Lv)
	
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed('stairs'):
		if player.on_stairs:
			next_map()
	if Input.is_action_just_pressed("save"):
		emit_signal('save_p')
		gamesaver.save(1)
	if Input.is_action_just_pressed("load"):
		emit_signal('load_p')
		for e in BSP_Dungeon.enemies.get_children():
			e.queue_free()
		for w in BSP_Dungeon.walls.get_children():
			w.queue_free()
		for d in BSP_Dungeon.doors.get_children():
			d.queue_free()
		for i in BSP_Dungeon.items.get_children():
			i.queue_free()			
		for s in BSP_Dungeon.stairs.get_children():
			s.queue_free()			
		gamesaver._load(1)
