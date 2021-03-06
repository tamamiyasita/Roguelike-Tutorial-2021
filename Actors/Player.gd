extends Actor

onready var fov :Area2D = $Fov
onready var inventory = preload("res://Items/Inventory.tres")
onready var states = preload('res://Actors/player_states.tres')
onready var skill_anime = $SkillAnimation
onready var skills = $Skills
onready var fov_ray :RayCast2D = $RayCast2D

onready var attck_pos = $attack_pos

onready var container = $CanvasLayer/InventoryContainer
onready var canvas = $CanvasLayer
onready var anime2 = $anime2

signal hp_changed
signal states_changed
onready var SAVE_KEY: String = "player"

var combo_bonus := 0
var base_conbo := 0
var enemies := []
var areas := []
var floor_items := []
var enemy 

var on_stairs := false

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
	self.states.reset()
	print(self.states.max_hp)
	skill_clear()
	yield(get_tree(),'idle_frame')
	skill_set("Punch")
#	use_item.connect('useitem', container, "setup")
	
	
func _process(delta: float) -> void:
	if !container.visible:
		BaseInfo.Main.ui.pop.hide()


		
func states_reset():
	var c_states = self.states.states_change()
	emit_signal('states_changed', c_states)
	


		
func start_positon(point):
	position = point

	
func parent_path():
	return get_parent().walls.get_children()


func save(save_game: Resource):
	save_game.data[SAVE_KEY].append({
		"name": name,
		'hp': states.hp,
		"max_hp":states.max_hp,
		"position": position,
		"items": inventory.items
#		'mana': stats.mana,
	})
	
func _load(save_game: Resource):
	var data_array: Array = save_game.data[SAVE_KEY]
	var data = data_array.pop_front()
	
	name = data["name"]
	self.states.hp = data['hp']
	self.states.max_hp = data['max_hp']
	position = data["position"]
	inventory.items = data["items"]
	
	print("load")
	hp_change(0)
	container.disp.update_inventory_display()
#	stats.mana = data['mana']


func _unhandled_input(event: InputEvent) -> void:
	if not is_turn_complete and state == _TURN_READY:
		for direction in INPUT_KEY.keys():

			if event.is_action_pressed('rest'):
				turn_end()

#			elif event.is_action_pressed("get"):
#				get_item()
#				turn_end()
#				break
#			elif event.is_action_pressed('inv'):
#				container.visible = !container.visible
#				for i in inventory.items:
#					if i == null:
#						BaseInfo.Main.ui.pop.hide()
#					else:
#						BaseInfo.Main.ui.pop.show()
#						break

				break
			elif event.is_action(direction):
				state = _TURN_RUN
				$Position2D/Camera2D.current = true
				
				var direction_tile = INPUT_KEY[direction] * TILE_SIZE
				neighbor_search(direction_tile)
				area_check(areas)
				enemies_visible_check(enemies)
		


func collider_check(collider, direction) -> void:
	var tile_search = ray.get_collider().collision_layer
	match tile_search:
		WALL:
			print("is wall")
			state = _TURN_READY
		ENEMY:
			if not collider.is_dead:
				print("enemy depop!")
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
			

func get_item():
	if !floor_items.empty():
		var item = floor_items[0].is_item
		for i in inventory.items.size():
			if inventory.items[i] == null:
				inventory.set_item(i, item)
				get_tree().call_group("sfx", "get_item")
				get_tree().call_group("message", "get_massage", "You picked up an {0} ".format([item.name]))
				floor_items[0].position = Vector2.ZERO
				floor_items[0].queue_free()
				break
			else:
				continue

func hp_change(value):
	damage_text.show_value(value)
	anime.play("damage")
	yield(anime, "animation_finished" )	
	self.states.hp_change(value)
	emit_signal('hp_changed', self.states.hp)
	print(self.states.hp, " my hp")
	if self.states.hp <= 0:
		print("player dead!")
		dead()

func skill_clear():
	for s in skills.get_children():
		s.queue_free()
func skill_set(node_name):
	if "@" in node_name:
		return
	var Skill = load(SkillInfo.return_instance(node_name))
	var skill = Skill.instance()
	skill.texture_normal = null
	skills.add_child(skill)
	for s in skills.get_children():
		if "@" in s.name:
			s.queue_free()
		


func attack(collider, direction):
	$Position2D/Camera2D.current = false
	for s in skills.get_children():
		if !is_instance_valid(collider) or collider.states.hp <= 0:
			combo_bonus = base_conbo
			state = _TURN_END
			return
		if s.name == "BaseSkill":
			continue
			
		enemy = collider
		yield(get_tree(),'idle_frame')
		var power = int(rand_range(1, self.states.power))
		var regist  = int(rand_range(0, collider.states.defense))
		var damage := 0



		damage = int(clamp(power-regist, 0, self.states.power))
		
		if !s.play(direction, enemy, damage, anime):
			combo_bonus = base_conbo
			state = _TURN_END
			return
		get_tree().call_group("sfx", "skill")

		yield(anime, "animation_finished" )
		
		yield(get_tree().create_timer(0.2), "timeout")
		if !is_instance_valid(collider) or collider.states.hp <= 0:
			combo_bonus = base_conbo
			state = _TURN_END
			return
	if !state == _TURN_INPUT:
		state = _TURN_END
	combo_bonus = base_conbo
	yield(get_tree(),'idle_frame')

func show_obj():
	attck_pos.show()
#	$attack_pos/Object.flip_h = sprite.flip_h
	yield(anime, "animation_finished" )
	attck_pos.hide()


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
#	get_tree().quit()
	get_tree().change_scene("res://GameOver.tscn")





func _on_Player_area_entered(area: Area2D) -> void:
	if area.collision_layer == 32:
		print("get_ok")
		floor_items.append(area)
		get_item()
		
		print(floor_items)
	else:
		print("is_stairs")
		on_stairs = true
		get_tree().call_group("next_map", "next_map")


func _on_Player_area_exited(area: Area2D) -> void:
#	if "is_item" in area.get_parent():
	if area.collision_layer == 32:
		print("rere_ok")
		floor_items.erase(area)
		print(floor_items)
	else:
		print("not_stairs")
		on_stairs = false


