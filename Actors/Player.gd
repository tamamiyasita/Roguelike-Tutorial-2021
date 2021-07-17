extends Actor

onready var fov_ray :RayCast2D = $Fovray
onready var fov :Area2D = $Fov

var enemies := []
var areas := []

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
	fov_ray.set_collide_with_areas(true)


		
func start_positon(point):
	position = point

	
func parent_path():
	return get_parent().walls.get_children()



func _unhandled_input(event: InputEvent) -> void:
	if not is_turn_complete and state == IDLE:
		for direction in INPUT_KEY.keys():
			if event.is_action_pressed(direction):
				var direction_tile = INPUT_KEY[direction] * TILE_SIZE
				neighbor_search(direction_tile)
				area_check(areas)
				enemies_visible_check(enemies)


func collider_check(collider, direction) -> void:
	var tile_search = ray.get_collider().collision_layer
	print(tile_search)
	match tile_search:
		WALL:
			print("is wall")
		ENEMY:
			print("enemy depop!")
			attack(collider, direction)
		DOOR:
			door_check(collider, direction)
			print("door open")
			

func attack(collider, direction):
	state = ATTACK
	position2d.attack_start(direction)
	
	collider.fighter.hp -= (self.fighter.power-collider.fighter.defense)

	print(collider.name," HP: ", collider.fighter.hp)
	if collider.fighter.hp <= 0:
		collider.dead()
		print("enemy dead!")




func area_check(areas):
	if areas:
		for area in areas:
			if is_instance_valid(area):
				fov_ray.cast_to = area.global_position - global_position
				fov_ray.force_raycast_update()
				var look = fov_ray.get_collider()
				if is_instance_valid(look):		
					if look.collision_layer == 2 or look.collision_layer == 8:
						look.light.visible = true
		areas = []

func enemies_visible_check(enemies) -> void:
			
	for enemy in enemies:
		if is_instance_valid(enemy):
			fov_ray.cast_to = enemy.position - position
			fov_ray.force_raycast_update()
			var look = fov_ray.get_collider()
			if look == enemy:
				look.visible = true


func _on_Fov_area_entered(area: Area2D) -> void:
	if area.collision_layer == 4:
		if !enemies in area:
			enemies.append(area)
	if area.collision_layer == 2 or area.collision_layer == 8:
		areas.append(area)

		

func _on_Fov_area_exited(area: Area2D) -> void:
	if area.collision_layer == 4:
		area.visible = false
			
#	if area.collision_layer == 2 or area.collision_layer == 8:
#		area.light.visible = false


