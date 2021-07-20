class_name Main
extends TileMap


onready var player = $Player
var enemies
var active_enemy = []


func request_move(c, direction) -> void:
	c.is_turn_complete = true
	c.position += direction
	game_turn_start()

	
func request_pass(c) -> void:
	c.is_turn_complete = true
	game_turn_start()

func _process(delta: float) -> void:
	if active_enemy.empty():
		player.is_turn_complete = false
		get_tree().call_group("actor", "turn_ready")
#
	for e in active_enemy:
#		yield(get_tree(),'idle_frame')
		if e.is_dead:
			continue
		if is_instance_valid(e):		
			e.take_turn(player.position)
			break


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

	set_process(true)
		

