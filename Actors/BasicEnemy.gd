extends "res://Actors/Actor.gd"



func _ready() -> void:
	add_to_group("enemy")
	
	
func take_turn() -> void:
	random_walk()


func turn_ready() -> void:
	is_turn_complete = false


func random_walk() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var direction = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))
	print(direction, "enemy direction")

	var direction_tile = direction * TILE_SIZE
	neighbor_search(direction_tile)


func collider_check(collider) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
			turn_complete()
		ENEMY:
			pass
		DOOR:
			pass
