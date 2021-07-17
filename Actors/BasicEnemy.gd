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
	sprit.hide()
	$Position2D/shadow.hide()
	particle.emitting = true
	is_turn_complete = true
	is_dead = true
	
func basic_ai(direction) -> void:
	var path = a_star_path.get_astar_path(global_position, direction)
	path = path[1]
	var dist = path.distance_to(direction)
	var d = (path - global_position)
	print(d)
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
			get_tree().call_group("main", "request_pass",self)
		PLAYER:
			attack(collider, direction)
			print("tyu-! player-!")
		ENEMY:
			get_tree().call_group("main", "request_pass",self)
#			print("tyu-!3")
		DOOR:
			get_tree().call_group("main", "request_pass",self)
#			print("tyu-!4")

func attack(collider, direction):
	state = ATTACK
	position2d.attack_start(direction)
	
	collider.fighter.hp -= (self.fighter.power-collider.fighter.defense)

	print("player HP: ", collider.fighter.hp)
	if collider.fighter.hp <= 0:
		collider.dead()
		print("player dead!")
