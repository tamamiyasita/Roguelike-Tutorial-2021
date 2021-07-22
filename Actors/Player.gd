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
	if not is_turn_complete and state == _TURN_READY:
		for direction in INPUT_KEY.keys():
			if event.is_action_pressed('rest'):
				turn_end()
			if event.is_action(direction):
				state = _TURN_RUN
				$Position2D/Camera2D.current = true
				
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
			state = _TURN_READY
		ENEMY:
			if not collider.is_dead:
				print("enemy depop!")
				anime_state = ATTACK
				state = _TURN_RUN
				attack(collider, direction)
			else:
				state = _TURN_READY
		DOOR:
			state = _TURN_READY
			door_check(collider, direction)
			anime_state = IDLE
			get_tree().call_group("message", "get_massage", "{0} opened the door".format([self.name]))
			
			print("door open")
			

func attack(collider, direction):
	$Position2D/Camera2D.current = false
	position2d.attack_start(direction)
	var damage = (self.fighter.power-collider.fighter.defense)
	
	collider.fighter.hp -= damage
	collider.anime_state = AMOUNT

	print(collider.name," HP: ", collider.fighter.hp)
	var text = [self.name, collider.name, damage]
	get_tree().call_group("message", "get_massage", "{0} hit the {1} for {2} damage!".format(text))
	if collider.fighter.hp <= 0:
		collider.dead()
		print("enemy dead!")

	yield(anime, "animation_finished" )
	turn_end()




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

func dead() -> void:
	get_tree().quit()


