class_name Main
extends TileMap


onready var player = $Dungeon/BSP_Dungeon/Player
var enemies
var active_enemy = []

enum  {PLAYAR_TURN, ENEMY_TURN, MENUE}


var game_state = PLAYAR_TURN

var current_actor = player


func request_move(c, direction) -> void:
	c.is_turn_complete = true
	c.position += direction
	
	game_turn_start()
	
func request_pass(c) -> void:
	c.is_turn_complete = true
	game_turn_start()

func _process(delta: float) -> void:
#
	for e in active_enemy:
		yield(get_tree(),'idle_frame')
		e.take_turn()
		break

	if active_enemy.empty():
		player.is_turn_complete = false
		get_tree().call_group("actor", "turn_ready")

	active_enemy.clear()
	set_process(false)



func game_turn_start() -> void:
	enemies = $Dungeon/BSP_Dungeon/Enemies.get_children()
	if player.is_turn_complete == true:
		if enemies:
			for enemy in enemies:
				if enemy.is_turn_complete == false and enemy.visible == true:
					active_enemy.append(enemy)
					break
#	for e in active_enemy:
#		yield(get_tree(),'idle_frame')
#		e.take_turn()
#		break
#
#	if active_enemy.empty():
#		player.is_turn_complete = false
#		get_tree().call_group("actor", "turn_ready")
#
#	active_enemy.clear()
	set_process(true)
		

