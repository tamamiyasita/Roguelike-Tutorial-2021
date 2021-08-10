extends "res://Actors/Actor.gd"

onready var particle :CPUParticles2D = $Position2D/CPUParticles2D
onready var sprit :Sprite = $Position2D/Sprite
onready var a_star_path = find_parent("Dungeon")
onready var states = preload('res://Actors/enemy_states.tres').duplicate()
onready var tex = $Position2D/TextureRect
onready var SAVE_KEY = "enemy"

var cnf = false
var cnf_turn:int = 0

var paths:Array

func _ready() -> void:
	add_to_group("actor")
#	states = states.duplicate()

func _process(delta: float) -> void:
	if cnf == true:
		tex.show()
	elif cnf == false:
		tex.hide()
		
	if !anime.is_playing():
		anime.play('idle')
	if is_dead:
		if particle.emitting == false:
#			queue_free()
			position = Vector2.ZERO
	
func take_turn(direction) -> void:
	if cnf and cnf_turn > 0:
		cnf_turn -= 1
		random_walk()
		if cnf_turn < 1:
			cnf = false
	else:
		basic_ai(direction)

func dead() -> void:
	get_tree().call_group("message", "get_massage", "The {0} is dead".format([self.name]))
#	sprit.hide()
#	$Position2D/shadow.hide()
#	particle.emitting = true
	anime.play("dead")
	is_turn_complete = true
	is_dead = true
	
func basic_ai(direction) -> void:
	state = _TURN_RUN
	paths = a_star_path.get_astar_path(global_position, direction)
	var path = paths[1]
	
	var dist = path.distance_to(direction)
	var d = (path - global_position)
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


func hp_change(value):
	self.states.hp_change(value)
#	emit_signal('hp_changed', self.states.hp)
	print(self.states.hp, " my hp")
	
	if states.hp <= 0:
		print(name, "dead!")
		dead()


func attack(collider, direction):
	anime_state = ATTACK
	position2d.attack_start(direction)
	
	var damage = (self.states.power-collider.states.defense)
	
	collider.hp_change(-damage)
	collider.anime_state = AMOUNT

	var text = [self.name, collider.name, damage]
	get_tree().call_group("message", "get_massage", "{0} hit the {1} for {2} damage!".format(text))
			
	if collider.states.hp <= 0:
		print("player dead!")
		collider.dead()

	yield(anime, "animation_finished" )
	turn_end()


func _on_Enemy_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			BaseInfo.target_enemy = self

func save(save_game: Resource):
	
	
	save_game.data["enemy"].append({
#		'experience': experience,
		"name":name,
		'hp': states.hp,
		"max_hp":states.max_hp,
		"position": position,
		"is_dead": is_dead,
		"visible": visible
#		'mana': stats.mana,
	})
func _load(save_game: Resource):

	var data_array: Array = save_game.data["enemy"]
	var data = data_array.pop_front()
	self.states = load('res://Actors/enemy_states.tres').duplicate()
	name = data["name"]
	self.states.hp = data['hp']
	self.states.max_hp = data['max_hp']
	position = data["position"]
	is_dead = data["is_dead"]
	visible = data["visible"]
	
	
