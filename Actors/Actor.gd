tool
class_name Actor
extends Area2D

signal turn_change

const TILE_SIZE := 32

enum {PLAYER=1,  WALL = 2, ENEMY = 4, DOOR = 8}

onready var ray :RayCast2D = $RayCast2D
onready var sprite: Sprite = $Position2D/Sprite
onready var anime: AnimationPlayer = $AnimationPlayer

export (Texture) var texture 
export (bool) var move_anime = true

var direction

var is_turn_complete := true

func _ready() -> void:
	sprite.texture = texture
	ray.set_collide_with_areas(true)

func _process(delta: float) -> void:
	if !anime.is_playing():
		anime.play('idle')

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
	position += direction
	if not move_anime:
		turn_complete()
	else:
		move_animation(direction)


func door_check(collider, direction) -> void:
	if collider.is_open:
		move(direction)
	else:
		collider.open_door()


func move_animation(direction) -> void:

	anime.play('walk')
	yield(get_tree(),'idle_frame')
	turn_complete()


func turn_complete() -> void:
	is_turn_complete = true
	get_tree().call_group("main", "game_turn_start")
	print("turn_change 送信")



func turn_ready() -> void:
	is_turn_complete = false
	print(self.name, " ok!")






