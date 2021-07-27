class_name Main
extends TileMap


onready var player = $Player
onready var lifebar = $UI/Position2D/LifeBar
var enemies
var active_actor


func _ready() -> void:
	set_process(false)
	game_turn_start()
	player.connect('hp_changed', lifebar, "set_target_value")
	player.connect('states_changed', lifebar, "setup")
	

func request_move(c, direction) -> void:
#	c.position += direction
#	game_turn_start()
	pass

	
func request_pass(c) -> void:
#	game_turn_start()
	pass
	
	
func actor_ready_on():
	enemies = $Dungeon/BSP_Dungeon/Enemies.get_children()
	for e in enemies:
		e.turn_ready()


func _process(delta: float) -> void:
#	if is_instance_valid(active_actor):
	if active_actor.is_turn_complete == true:
		set_process(false)
		game_turn_start()

func actor_sefe_check(actor) -> bool:
	return actor.is_turn_complete == false\
		and actor.is_dead == false and is_instance_valid(actor)
		
func enemy_path_check(enemy) -> bool:
	return enemy.is_visible() or enemy.paths
	


func game_turn_start() -> void:
	enemies = $Dungeon/BSP_Dungeon/Enemies.get_children()
	active_actor = null
	if enemies:
		for enemy in enemies:
			if actor_sefe_check(enemy):
				if enemy_path_check(enemy):
					active_actor = enemy
					active_actor.take_turn(player.position)
					break
	yield(get_tree(),'idle_frame')# 原因はコレがないから同時判定になってしまったのか
					
	if active_actor == null:
		player.turn_ready()
		active_actor = player
		actor_ready_on()

	set_process(true)
		

