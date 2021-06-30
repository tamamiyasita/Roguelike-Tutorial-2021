class_name Main
extends Node


onready var enemies = $Dungeon/Enemy.get_children()
onready var player = $Dungeon/Player

enum GAME_STATE {PLAYAR_TURN, ENEMY_TURN, MENUE}


func turn_change() -> void:
	print("turn_change_1")
	for enemy in enemies:
		if enemy.is_turn_complete:
			continue
		else:
			enemy.take_turn()
			yield(enemy.tween, "tween_completed")
			
	
	if player.is_turn_complete == true:
		player.is_turn_complete = false
		yield(player.tween, "tween_completed")
		
		get_tree().call_group("enemy", "turn_ready")
		print("turn_change_2")


