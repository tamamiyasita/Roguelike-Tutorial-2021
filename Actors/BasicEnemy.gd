extends "res://Actors/Actor.gd"


func _ready() -> void:
	add_to_group("actor")	

#func _process(delta: float) -> void:
#	set_process(false)
#	set_process(true)

	
func take_turn() -> void:
	random_walk()


func random_walk() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var direction = Vector2(rng.randi_range(-1, 1), rng.randi_range(-1, 1))

	var direction_tile = direction * TILE_SIZE
	neighbor_search(direction_tile)


func collider_check(collider, direction) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
#			print("tyu-!1")
			get_tree().call_group("main", "request_pass",self)
		PLAYER:
			get_tree().call_group("main", "request_pass",self)
			print("tyu-!2")
		ENEMY:
			get_tree().call_group("main", "request_pass",self)
#			print("tyu-!3")
		DOOR:
			get_tree().call_group("main", "request_pass",self)
#			print("tyu-!4")
