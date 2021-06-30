tool
class_name Actor
extends Area2D

signal turn_change

const TILE_SIZE := 32

enum {WALL = 2, ENEMY = 4, DOOR = 8}

onready var ray :RayCast2D = $RayCast2D
onready var sprite: Sprite = $Sprite
onready var tween: Tween = $Tween

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
		collider_check(collider)


func collider_check(collider) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
			pass
		ENEMY:
			pass
		DOOR:
			pass
	

func move(direction) -> void:
	if not move_anime:
		position += direction
		turn_complete()
	else:
		move_animation(direction)
	
	
func move_animation(direction) -> void:
	tween.interpolate_property(
		self,
		"position",
		position,
		position + direction,
		0.1,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		
	)
	tween.start()


func turn_complete() -> void:
	is_turn_complete = true
	get_tree().call_group("main", "turn_change")
	print("complete")
	

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	turn_complete()
	print("tween")



#func _on_Tween_tween_all_completed() -> void:
#	turn_complete()
