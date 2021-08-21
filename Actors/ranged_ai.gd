extends "res://Actors/BasicEnemy.gd"

var arrows = preload("res://Bullet.tscn")

onready var ranged_ray :RayCast2D = $RayCast2D2

func _ready() -> void:
	ranged_ray.set_collide_with_areas(true)


func take_turn(direction) -> void:
	if cnf and cnf_turn > 0:
		cnf_turn -= 1
		random_walk()
		if cnf_turn < 1:
			cnf = false
	else:
		ranged_ai(direction)


func ranged_ai(direction) -> void:
	state = _TURN_RUN
	
	a_star_path.a_path_ready(position)
	paths = a_star_path.get_astar_path(global_position, direction)
	
#	if paths.empty():
#		random_walk()
#	else:
#		var path = paths[-1]
#
#		var dist = path.distance_to(direction)
	var d = (BaseInfo.Player.position - global_position)
	ranged_search(d)


func ranged_search(direction) -> void:
	flip_h_switching(direction)
	
	ranged_ray.cast_to = direction
#	ray.cast_to = direction
#	ray.force_raycast_update()
	ranged_ray.force_raycast_update()
	
	var ray_target = ranged_ray.get_collider()
	var dist = global_position.distance_to(ray_target.position)
	if dist > 140:
		print(dist, "distance")
		basic_ai(direction)
	elif ray_target.collision_layer == PLAYER:
		print(dist, "distance")
		ranged_attack(ray_target, direction)
	else:
		basic_ai(direction)
	
#	else:
#		var collider = ray.get_collider()
#		if not collider:
#			move(direction)
#		else:
#			collider_check(collider, direction)
		
func ranged_attack(collider, direction):
	anime_state = ATTACK
	var arrow = arrows.instance()
	arrow.look_at(direction)
	add_child(arrow)
	position2d.ranged_attack_start(direction, arrow)
	var power = int(rand_range(0, self.states.power+1))
	var regist  = int(rand_range(0, collider.states.defense))
	var damage = int(clamp(power-regist, 0, self.states.power))
#	var damage = (self.states.power-collider.states.defense)
	
	collider.hp_change(-damage)
	collider.anime_state = AMOUNT

	var text = [self.name, collider.name, damage]
	get_tree().call_group("message", "get_massage", "{0} hit the {1} for {2} damage!".format(text))
			
	if collider.states.hp <= 0:
		print("player dead!")
		collider.dead()
	yield(tween, "tween_all_completed" )
#	yield(anime, "animation_finished" )
	arrow.queue_free()
	turn_end()
