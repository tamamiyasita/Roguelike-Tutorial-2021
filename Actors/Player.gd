class_name Player
extends Area2D

const TILE_SIZE := 32



const INPUT_KEY :Dictionary = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
	}

onready var ray :RayCast2D = $RayCast2D

enum {WALL = 1, ENEMY = 2}

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	for direction in INPUT_KEY.keys():
		if event.is_action_pressed(direction):
			var direction_tile = INPUT_KEY[direction] * TILE_SIZE
			flip_h_switching(direction_tile)
			neighbor_search(direction_tile)


func flip_h_switching(direction):
	if direction.x == TILE_SIZE:
		$Sprite.flip_h = false
	elif direction.x == -TILE_SIZE:
		$Sprite.flip_h = true
	print(direction.x)


func neighbor_search(direction) -> void:
	ray.cast_to = direction
	ray.force_raycast_update()

	if ray.get_collider() != null:
		var tile_search = ray.get_collider().collision_mask
		match tile_search:
			WALL:
				print("is wall")
			ENEMY:
				print("enemy pop!")
			
	else:
		move(direction)
	

func move(direction):
	position += direction
