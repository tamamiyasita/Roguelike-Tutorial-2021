extends "res://Actors/Actor.gd"





func _ready() -> void:
	add_to_group("actor")	


	
func take_turn() -> void:
	if is_turn_complete == false:
		random_walk()
	is_turn_complete = true


func random_walk() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var direction = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))

	var direction_tile = direction * TILE_SIZE
	neighbor_search(direction_tile)


func collider_check(collider) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
			turn_complete()
		PLAYER:
			print("tyu-!")
			turn_complete()
		ENEMY:
			turn_complete()
		DOOR:
			pass
