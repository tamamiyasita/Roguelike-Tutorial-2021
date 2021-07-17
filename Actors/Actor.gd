tool
class_name Actor
extends Area2D

signal turn_change

const TILE_SIZE := 32

enum {PLAYER=1,  WALL = 2, ENEMY = 4, DOOR = 8}
enum {IDLE, MOVE, ATTACK}
var state = IDLE
onready var ray :RayCast2D = $RayCast2D
onready var sprite: Sprite = $Position2D/Sprite
onready var anime: AnimationPlayer = $AnimationPlayer
onready var position2d: Position2D = $Position2D
onready var tween: Tween = $Position2D/Tween
onready var fighter: Node = $Fighter

var is_dead := false

export (Texture) var texture 

var direction

var is_turn_complete := true

func _ready() -> void:
	sprite.texture = texture
	ray.set_collide_with_areas(true)
	

func _process(delta: float) -> void:
	if state == ATTACK:
		anime.play("attack")
		turn_end()
		
	if state == MOVE:
		anime.play('walk')
		turn_end()
	
	
	if !anime.is_playing():
		state = IDLE
		anime.play('idle')

func turn_end() -> void:
	state = IDLE
	yield(anime, "animation_finished" )
	yield(tween, "tween_all_completed" )
	get_tree().call_group("main", "request_pass",self)

func flip_h_switching(direction) -> void:
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true


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
	get_tree().call_group("main", "request_move", self, direction)
	state = MOVE
#	move_animation(direction)


func door_check(collider, direction) -> void:
	if collider.is_open:
		move(direction)
	else:
		collider.open_door()


func move_animation(direction) -> void:

	anime.play('walk')


func turn_ready() -> void:
	is_turn_complete = false






