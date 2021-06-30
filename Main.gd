class_name Main
extends Node


onready var actors = $Dungeon/Enemy.get_children()
onready var player = $Dungeon/Player

enum GAME_STATE {PLAYAR_TURN, ENEMY_TURN, MENUE}


func turn_change() -> void:
	print("turn_change_start")
#	actors.append(player)
	
	for actor in actors:
		if actor.is_turn_complete:
			continue
		elif actor != player:
			print(actor.name, " 開始")
			actor.take_turn()
			yield(actor.tween, "tween_completed")
			print(actor.name, " 終了")
		elif actor == player:
			print(actor.name, " 開始")
			yield(player.tween, "tween_completed")
			print(actor.name, " 終了")

	all_turn_end_check()
	
func all_turn_end_check() -> void:
	if player.is_turn_complete:
		get_tree().call_group("actor", "turn_ready")

	for actor in actors:
		if not actor.is_turn_complete:
			break
		player.is_turn_complete = false
		print("turn_change_end")


