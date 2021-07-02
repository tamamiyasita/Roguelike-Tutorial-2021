tool
class_name Actor
extends Area2D

signal turn_change

const TILE_SIZE := 32

enum {PLAYER=1,  WALL = 2, ENEMY = 4, DOOR = 8}

onready var ray :RayCast2D = $RayCast2D
onready var sprite: Sprite = $Sprite
onready var tween: Tween = $Tween
onready var anime: AnimationPlayer = $AnimationPlayer

export (Texture) var texture 
export (bool) var move_anime = true

var direction

var is_turn_complete := false

func _ready() -> void:
	sprite.texture = texture
	ray.set_collide_with_areas(true)


func flip_h_switching(direction) -> void:
	if direction.x > 0:
		$Sprite.flip_h = false
	elif direction.x < 0:
		$Sprite.flip_h = true


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
	is_turn_complete = true


func door_check(collider, direction) -> void:
	if collider.is_open:
		move(direction)
	else:
		collider.open_door()
	

	
func move_animation(direction) -> void:
	print(position," pos")
	print(direction," dir")
	
	anime.play('walk')
	
	tween.interpolate_property(
		anime,
		"position",
		Vector2.ZERO,
		direction,
		anime.current_animation_length,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		
	)
	tween.start()

	


func turn_complete() -> void:
	get_tree().call_group("main", "game_turn_start")
	print("turn_change 送信")



func turn_ready() -> void:
	is_turn_complete = false
	print(self.name, " ok!")


func _on_Tween_tween_all_completed() -> void:
	turn_complete()
