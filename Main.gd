class_name Main
extends Node


onready var enemies = $Dungeon/Enemy.get_children()
onready var player = $Dungeon/Player

enum  {PLAYAR_TURN, ENEMY_TURN, MENUE}


var game_state = PLAYAR_TURN

var actors := []

func _ready() -> void:
	turn_switch()


func turn_switch() -> void:
	if game_state == ENEMY_TURN:
		for enemy in enemies:
			if enemy.is_turn_complete == false:
				enemy.take_turn()
				break
			
				
	elif game_state == PLAYAR_TURN:
		if player.is_turn_complete == true:
			get_tree().call_group("actor", "turn_ready")
			player.is_turn_complete = false
			
		



func game_turn_start() -> void:
	
	actors.append_array(enemies)
	
	for actor in actors:
		if actor.is_turn_complete == false:
			game_state = ENEMY_TURN
			break
		game_state = PLAYAR_TURN
		
	turn_switch()


