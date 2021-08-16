class_name Actor
extends Area2D

signal turn_change

const TILE_SIZE := 32

enum {PLAYER=1,  WALL = 2, ENEMY = 4, DOOR = 8}
enum {_TURN_READY, _TURN_RUN, _TURN_END, _TURN_INPUT}
enum {IDLE, MOVE, ATTACK, RANGED_ATTACK, AMOUNT, CNF}
var state = _TURN_READY
var anime_state = IDLE
onready var ray :RayCast2D = $RayCast2D
onready var sprite: Sprite = $Position2D/Sprite
onready var anime: AnimationPlayer = $AnimationPlayer
onready var position2d: Position2D = $Position2D
onready var tween: Tween = $Position2D/Tween

var is_dead := false

export (Texture) var texture 

var direction

var is_turn_complete := true

func _ready() -> void:
	sprite.texture = texture
	ray.set_collide_with_areas(true)
	

func _process(delta: float) -> void:
			
	if anime_state == ATTACK:
		anime.play("attack")
		yield(anime, "animation_finished" )
		anime_state = IDLE

		
	if anime_state == MOVE:
		anime.play('walk')
		yield(anime, "animation_finished" )
		anime_state = IDLE

		
	if anime_state == AMOUNT:
		anime.play('damage')
		yield(anime, "animation_finished" )
		anime_state = IDLE

		
#	if anime_state == CNF:
#		anime.play("cnf")
	
	if !anime.is_playing() :
		anime_state = IDLE
		position2d.global_position = self.global_position+Vector2(16,16)
		anime.play('idle')
		
	if state == _TURN_INPUT:
		pass
		
	if state == _TURN_END:
		is_turn_complete = true


func turn_end() -> void:
	state = _TURN_END
	is_turn_complete = true	
#	yield(get_tree(),'idle_frame')
#
#	get_tree().call_group("main", "request_pass",self)

func flip_h_switching(direction, node=sprite) -> void:
	if direction.x > 0:
		node.flip_h = false
	elif direction.x < 0:
		node.flip_h = true


func neighbor_search(direction) -> void:
	flip_h_switching(direction)
	
	ray.cast_to = direction
	ray.force_raycast_update()
	var collider = ray.get_collider()
	if not collider:
		move(direction)
	else:
		collider_check(collider, direction)


func collider_check(collider, direction) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
			pass
		ENEMY:
			pass
		DOOR:
			pass
	

func move(direction) -> void:
	anime_state = MOVE
	position2d.move_start(position, direction)
	position += direction
#	yield(get_tree(),'idle_frame')
	state = _TURN_END
#
#	yield(get_tree().create_timer(0.1), "timeout")
#	turn_end()
#	get_tree().call_group("main", "request_move",self, direction)
	
	
	yield(anime, "animation_finished" )
	
	is_turn_complete = true	
	
#	anime_state = IDLE


func door_check(collider, direction) -> void:
	if collider.is_open:
		move(direction)
	else:
		collider.open_door()



func turn_ready() -> void:
	if is_dead == false:
		state = _TURN_READY
		is_turn_complete = false





