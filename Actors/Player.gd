extends Actor


const INPUT_KEY :Dictionary = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"up_right": Vector2(1, -1),
	"up_left": Vector2(-1, -1),
	"down_right": Vector2(1, 1),
	"down_left": Vector2(-1, 1),
	}

func _ready() -> void:
	is_turn_complete = false
	
	

func _unhandled_input(event: InputEvent) -> void:
	if tween.is_active() == false and not is_turn_complete:
		for direction in INPUT_KEY.keys():
			if event.is_action_pressed(direction):
				var direction_tile = INPUT_KEY[direction] * TILE_SIZE
				neighbor_search(direction_tile)
				is_turn_complete = true


func collider_check(collider, direction) -> void:
	var tile_search = ray.get_collider().collision_layer
	print(tile_search)
	match tile_search:
		WALL:
			print("is wall")
		ENEMY:
			print("enemy pop!")
		DOOR:
			door_check(collider, direction)
			print("door open")
			
