extends "res://Actors/Actor.gd"


func _ready() -> void:
	pass
	
	
func random_walk() -> void:
	randomize()
	var rng = RandomNumberGenerator.new()
	var direction = Vector2(rng.randi_range(-1, 0), rng.randi_range(-1, 0))

	var direction_tile = direction * TILE_SIZE
	neighbor_search(direction_tile)
