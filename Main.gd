class_name Main
extends TileMap


onready var player = $Dungeon/BSP_Dungeon/Player
var enemies

enum  {PLAYAR_TURN, ENEMY_TURN, MENUE}


var game_state = PLAYAR_TURN

var current_actor = player

func _ready() -> void:
	turn_switch(player)


func turn_switch(current_actor) -> void:
	if current_actor == player:
		game_state = PLAYAR_TURN
	else:
		game_state = ENEMY_TURN
		
		
	if game_state == PLAYAR_TURN:
		if player.is_turn_complete == true:
			player.is_turn_complete = false
			
	elif game_state == ENEMY_TURN:
		current_actor.take_turn()


func game_turn_start() -> void:
	enemies = $Dungeon/BSP_Dungeon/Enemies.get_children()
	current_actor = player
	if enemies:
		for enemy in enemies:
			if enemy.is_turn_complete == false:
				current_actor = enemy
				break
				
	if current_actor == player:
		get_tree().call_group("actor", "turn_ready")
		
	turn_switch(current_actor)


