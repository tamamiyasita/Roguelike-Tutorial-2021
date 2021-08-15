class_name Main
extends TileMap


onready var player = $Player
onready var lifebar = $UI/Position2D/LifeBar
onready var enemies = $Dungeon/BSP_Dungeon/Enemies
onready var walls = $Dungeon/BSP_Dungeon/Walls
onready var doors = $Dungeon/BSP_Dungeon/Doors
onready var items = $Dungeon/BSP_Dungeon/Items
onready var dungeon_level = $UI/Dungeonlevel
onready var ui = $UI
onready var dungeon = $Dungeon
var dungeon_Lv = 0

var active_actor
var current_cell = Vector2.ZERO


func _ready() -> void:
	set_process(false)
	game_turn_start()
	player.connect('hp_changed', lifebar, "set_target_value")
	player.connect('states_changed', lifebar, "setup")
	player.states_reset()
	dungeon.connect("level", dungeon_level,"dungeon_level_up")
	dungeon.connect("save_p", dungeon_level,"save_pop")
	dungeon.connect("load_p", dungeon_level,"load_pop")

	
func actor_ready_on():
	enemies = $Dungeon/BSP_Dungeon/Enemies
	for e in enemies.get_children():
		e.turn_ready()


func _process(delta: float) -> void:
	if active_actor.is_turn_complete == true:
		set_process(false)
		game_turn_start()

func actor_sefe_check(actor) -> bool:
	return actor.is_turn_complete == false\
		and actor.is_dead == false and is_instance_valid(actor)
		
func enemy_path_check(enemy) -> bool:
	return enemy.is_visible() or enemy.paths
	


func game_turn_start() -> void:
	enemies = $Dungeon/BSP_Dungeon/Enemies
	active_actor = null
	if enemies.get_children():
		for enemy in enemies.get_children():
			if actor_sefe_check(enemy):
				if enemy_path_check(enemy):
					active_actor = enemy
					active_actor.take_turn(player.position)
					break
	yield(get_tree(),'idle_frame')
					
	if active_actor == null:
		player.turn_ready()
		active_actor = player
		actor_ready_on()

	set_process(true)
		

