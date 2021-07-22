extends "res://Actors/Actor.gd"

onready var particle :CPUParticles2D = $Position2D/CPUParticles2D
onready var sprit :Sprite = $Position2D/Sprite
onready var a_star_path = find_parent("Dungeon")


func _ready() -> void:
	add_to_group("actor")	

func _process(delta: float) -> void:
	if !anime.is_playing():
		anime.play('idle')
	if is_dead:
		if particle.emitting == false:
			queue_free()
	
func take_turn(direction) -> void:
#	random_walk()
	basic_ai(direction)

func dead() -> void:
	get_tree().call_group("message", "get_massage", "The {0} is dead".format([self.name]))
	sprit.hide()
	$Position2D/shadow.hide()
	particle.emitting = true
	is_turn_complete = true
	is_dead = true
	
func basic_ai(direction) -> void:
	state = _TURN_RUN
	var path = a_star_path.get_astar_path(global_position, direction)
	path = path[1]
	var dist = path.distance_to(direction)
	var d = (path - global_position)
	print(d, "_path_")
	neighbor_search(d)
	


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
			state = _TURN_END
		PLAYER:
			attack(collider, direction)
			print("tyu-! player-!")
		ENEMY:
			state = _TURN_END
#			print("tyu-!3")
		DOOR:
			state = _TURN_END
#			print("tyu-!4")

func attack(collider, direction):
	anime_state = ATTACK
	position2d.attack_start(direction)
	
	var damage = (self.fighter.power-collider.fighter.defense)
	
	collider.fighter.hp -= damage
	collider.anime_state = AMOUNT

	var text = [self.name, collider.name, damage]
	get_tree().call_group("message", "get_massage", "{0} hit the {1} for {2} damage!".format(text))
			
	if collider.fighter.hp <= 0:
		print("player dead!")
		collider.dead()

	yield(anime, "animation_finished" )
	turn_end()
