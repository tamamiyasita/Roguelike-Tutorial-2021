extends TileMap

export(int) var map_w := 40
export(int) var map_h := 40
export(int) var min_room_size := 5
export(float, 0.2, 0.5) var min_room_factor := 0.4

export(bool) var redraw setget redraw

var WALL :int = 0
var FLOOR :int = 1

var Util = preload("res://Util.tscn").instance()

var tree := {}
var leaves := []
var leaf_id :int = 0
var rooms := []

var tiles := {}
var obstacles = []

onready var enemies :Node = $Enemies
onready var items:Node = $Items
onready var doors :Node = $Doors
onready var walls :Node = $Walls
onready var floors :Node = $Floors
onready var stairs :Node = $Stairs

var rats = preload('res://Actors/CheeseRat.tscn')
var dogs = preload('res://Actors/Dog.tscn')
var apples = preload('res://map_object/apple.tscn')
var forces = preload('res://map_object/force.tscn')
var fbs = preload("res://map_object/fb.tscn")
var cnfs = preload("res://map_object/cnf_2.tscn")
var daggrs = preload("res://map_object/Daggr.tscn")
var bangles = preload("res://map_object/Bangle.tscn")

var door = preload('res://map_object/Door.tscn')
var stairs_obj = preload('res://map_object/Stairs.tscn')
var wall_obj = preload('res://map_object/Wall.tscn')
var floor_obj = preload('res://map_object/Floor.tscn')

onready var SAVE_KEY: String = "dungeon" + name
#func _ready() -> void:
#	generate()
#
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


func generate() -> void:
	delete_children(walls)
	delete_children(items)
	delete_children(enemies)
	delete_children(doors)
	rooms = []
	tiles = {}
	obstacles = []
	clear()
	fill_roof()
	start_tree()
	create_leaf(0)
	create_rooms()
	join_rooms()
	clear_deadends()
	entity_set()
	enemy_place(rooms)
	item_place(rooms)
	door_place()
	add_stairs()

func add_stairs():
	var last_point = rooms[-1].center
	var second_point = rooms[0].center
	var s1 = stairs_obj.instance()
	s1.position = map_to_world(last_point)
	stairs.add_child(s1)
	var s2 = stairs_obj.instance()
	s2.position = map_to_world(second_point+Vector2(2,2))
	stairs.add_child(s2)
	
	
	
func set_player_position(player)->void:
	var point = rooms[0].center
	player.position = map_to_world(point)
	
	var apple = apples.instance()
	apple.position = map_to_world(point + Vector2(0,1))
	items.add_child(apple)
	
#	var daggr = daggrs.instance()
#	daggr.position = map_to_world(point + Vector2(0,2))
#	items.add_child(daggr)
#
#	var bangle = bangles.instance()
#	bangle.position = map_to_world(point + Vector2(1,1))
#	items.add_child(bangle)
	
#	var force = forces.instance()
#	force.position = map_to_world(point +Vector2.ONE)
#	items.add_child(force)
#
#	var fb = fbs.instance()
#	fb.position = map_to_world(point + Vector2(2,1))
#	items.add_child(fb)
#
#	var cnf = dogs.instance()
#	cnf.position = map_to_world(point+ Vector2(2,2))
##	items.add_child(cnf)
#	enemies.add_child(cnf)



func entity_set():
	for tile in tiles:
		if tiles[tile] == WALL:
			set_cellv(tile, tiles[tile])
			obstacles.append(Vector2(tile))

			var wall = wall_obj.instance()
			wall.position = map_to_world(tile)
			walls.add_child(wall)
		elif tiles[tile] == FLOOR:
			set_cellv(tile, tiles[tile])
#			var f = floor_obj.instance()
#			f.position = map_to_world(tile)
#			floors.add_child(f)

func enemy_place(rooms) -> void:
	var max_enemy = [[0,2], [2,3],[3,4]]
	var enemy_point := []
	var choice_num = 0
	randomize()
	
	
	for room in rooms:
		if room == rooms[0]:
			continue
			
		for e in max_enemy:
			if e[0] > BaseInfo.Main.dungeon_Lv:
				break
			else:
				choice_num = e[1]
				
		for r in range(choice_num):
			var center_x = int(room.center[0])
			var center_y = int(room.center[1])
			var x = randi() % int(room["w"]) + room.x
			var y = randi() % int(room["h"]) + room.y
			if get_cell(x, y) == FLOOR:
				var point :Vector2 = Vector2(x, y)
				if !(point) in enemy_point:
					enemy_point.append(point)
					
	for p in enemy_point:

		var rat = rats.instance()
		var dog = dogs.instance()

		var dungeon_lv = BaseInfo.Main.dungeon_Lv
		var item_array = [dog, rat]
		var rng = rand_range(1,100+dungeon_lv)
		for i in item_array:
			if i.level > dungeon_lv+1:
				continue
			if rng > i.weight:
				enemies.add_child(i, true)
				i.position = map_to_world(p)
				print(i.name, "ENEMY!")
				break
			else:
				var e = item_array[-1]
				enemies.add_child(e, true)
				e.position = map_to_world(p)
				print(e.name, "ENEMY!")
				break

		
	if BaseInfo.Main.dungeon_Lv == 5:
		pass

		
		
		


func get_random_entities(chances, entities, level):
	var entity_weight_chance = {}
	for key in chances.keys():
		if key > level:
			break
		else:
			for v in chances.values():
				var rng = RandomNumberGenerator.new()
				var r = rng.randi_range(1,100)
				if r > v[1]:
					pass
		
	


func item_place(rooms) -> void:

	var item_chances :Dictionary = {
		0:["apple", 35],
		1:["force", 25],
		3:["fb", 25],
		4:["cnf", 15]
	} 
	
	var max_item = [[0,1], [1,1],[2,2]]
	
	var item_point := []
	var choice_num := 0
	randomize()
	for room in rooms:
		if room == rooms[0]:
			continue
		for i in max_item:
			if i[0] > BaseInfo.Main.dungeon_Lv:
				break
			else:
				var some_array = [i[1],i[1], 0]
				choice_num = some_array[randi() % some_array.size()]
				print(choice_num, "Choice")
				get_random_entities(item_chances, choice_num, BaseInfo.Main.dungeon_Lv)
				
		for r in range(choice_num):
			var center_x = int(room.center[0])
			var center_y = int(room.center[1])
			var x = randi() % int(room["w"]) + room.x
			var y = randi() % int(room["h"]) + room.y
			if get_cell(x, y) == FLOOR:
				var point :Vector2 = Vector2(x, y)
				if !(point) in item_point:
					item_point.append(point)
		print(item_point, "= item_point")
	if item_point.size() < 2:
		item_place(rooms)
		
	if BaseInfo.Main.dungeon_Lv == 0:
		var bangle = bangles.instance()
		var point = item_point.pop_back()
		items.add_child(bangle)
		bangle.position = map_to_world(point)
	elif BaseInfo.Main.dungeon_Lv == 1:
		var daggr = daggrs.instance()
		var point = item_point.pop_back()
		items.add_child(daggr)
		daggr.position = map_to_world(point)
			
	if item_point.size() >= 2:
		for p in item_point:
			var apple = apples.instance()
			var force = forces.instance()
			var cnf = cnfs.instance()
			var fb = fbs.instance()
			var item_array = [cnf, fb, force, apple]
			var rng = rand_range(1,70)
			for i in item_array:
				if i.level > BaseInfo.Main.dungeon_Lv+1:
					continue
				if rng < i.weight:
					i.position = map_to_world(p)
					items.add_child(i)
					print(i, "ITEM!")
					break
				
					
#			elif rng+2 < 7:
#				force.position = map_to_world(p)
#				items.add_child(force)
#			elif rng+2 < 8:
#				fb.position = map_to_world(p)
#				items.add_child(fb)
func door_place() -> void:
	var door_point_list := []
	for x in range(0, map_w):
		for y in range(0, map_h):
			if get_cell(x, y) == FLOOR:
				var door_point 
				
				if get_cell(x+1, y) == WALL and get_cell(x-1, y) == WALL and \
				 get_cell(x, y+1) == FLOOR and get_cell(x, y-1) == FLOOR:
					if get_cell(x, y+2) == FLOOR and get_cell(x, y-2) == FLOOR:
						
						if get_cell(x+1, y+1) == FLOOR or get_cell(x-1, y-1) == FLOOR or \
							get_cell(x+1, y-1) == FLOOR or get_cell(x-1, y+1) == FLOOR: 
								
							if get_cell(x+2, y+2) == FLOOR or get_cell(x-2, y-2) == FLOOR or \
							get_cell(x+2, y-2) == FLOOR or get_cell(x-2, y+2) == FLOOR: 
								if next_door(Vector2(x,y), door_point_list):
									door_point = Vector2(x,y)
									door_point_list.append(door_point)

						elif get_cell(x-1, y+1) == FLOOR or get_cell(x-1, y-1) == FLOOR: 
							if get_cell(x-2, y+2) == FLOOR or get_cell(x-2, y-2) == FLOOR: 
								if next_door(Vector2(x,y), door_point_list):
									door_point = Vector2(x,y)
									door_point_list.append(door_point)
					
				if get_cell(x+1, y) == FLOOR and get_cell(x-1, y) == FLOOR and \
				 get_cell(x, y+1) == WALL and get_cell(x, y-1) == WALL:
					if get_cell(x+2, y) == FLOOR and get_cell(x-2, y) == FLOOR:
						
						if get_cell(x+1, y+1) == FLOOR or get_cell(x-1, y-1) == FLOOR or \
							get_cell(x+1, y-1) == FLOOR or get_cell(x-1, y+1) == FLOOR: 
								
							if get_cell(x+2, y+2) == FLOOR or get_cell(x-2, y-2) == FLOOR or \
							get_cell(x+2, y-2) == FLOOR or get_cell(x-2, y+2) == FLOOR: 
								if next_door(Vector2(x,y), door_point_list):
									door_point = Vector2(x,y)
									door_point_list.append(door_point)
								
						elif get_cell(x-1, y+1) == FLOOR or get_cell(x-1, y-1) == FLOOR: 
							if get_cell(x-2, y+2) == FLOOR or get_cell(x-2, y-2) == FLOOR: 
								if next_door(Vector2(x,y), door_point_list):
									door_point = Vector2(x,y)
									door_point_list.append(door_point)
				
								
	for point in door_point_list:
		var d = door.instance()
		d.position = map_to_world(point)
		doors.add_child(d)
		
func next_door(point, door_point):
	for d in door_point:
		if d.x+1 == point.x and d.y == point.y:
			return false
		if d.x-1 == point.x and d.y == point.y:
			return false

		if d.y+1 == point.y and d.x == point.x:
			return false		
		if d.y-1 == point.y and d.x == point.x:
			return false		
	return true
	
			
func redraw(value=null):
	
	if !Engine.is_editor_hint():
		return
	generate()
	
	
	
func fill_roof() -> void:
	for x in range(0, map_w):
		for y in range(0, map_h):
			tiles[Vector2(x,y)] = WALL

			

func start_tree() -> void:
	rooms = []
	tree = {}
	leaves = []
	leaf_id = 0
	
	tree[leaf_id] = {"x": 1, "y": 1, "w": map_w - 2, "h": map_h - 2}
	leaf_id += 1
	

func create_leaf(parent_id):
	var x = tree[parent_id].x
	var y = tree[parent_id].y
	var w = tree[parent_id].w
	var h = tree[parent_id].h

	tree[parent_id].center = { x = floor(x + w / 2), y = floor(y + h / 2)}
	
	var can_split = false
	
	var split_type = Util.choose(["h", "v"])
	if min_room_factor * w < min_room_size:
		split_type = "h"
	elif min_room_factor * h < min_room_size:
		split_type = "v"
		
	var leaf1 = {}
	var leaf2 = {}
	
	if split_type == "v":
		var room_size = min_room_factor * w
		if room_size >= min_room_size:
			var w1 = Util.randi_range(room_size, (w - room_size))
			var w2 = w - w1
			leaf1 = { x = x, y = y, w = w1, h = h, split = "v"}
			leaf2 = { x = x + w1, y = y, w = w2, h = h, split = "v"}
			can_split = true
	else:
		var room_size = min_room_factor * h
		if room_size >= min_room_size:
			var h1 = Util.randi_range(room_size, (h - room_size))
			var h2 = h - h1
			leaf1 = { x = x, y = y, w = w, h = h1, split = "h"}
			leaf2 = { x = x, y = y + h1, w = w, h = h2, split = "h"}
			can_split = true
			
	if can_split:
		leaf1.parent_id = parent_id
		tree[leaf_id] = leaf1
		tree[parent_id].l = leaf_id
		leaf_id += 1
		
		leaf2.parent_id = parent_id
		tree[leaf_id] = leaf2
		tree[parent_id].r = leaf_id
		leaf_id += 1
		
		leaves.append([tree[parent_id].l, tree[parent_id].r])
		
		create_leaf(tree[parent_id].l)
		create_leaf(tree[parent_id].r)


func create_rooms() -> void:
	for leaf_id in tree:
		var leaf = tree[leaf_id]
		if leaf.has("l"):
			continue
		
		if Util.chance(75):
			var room = {}
			room.id = leaf_id
			room.w = Util.randi_range(min_room_size, leaf.w) - 1
			room.h = Util.randi_range(min_room_size, leaf.h) - 1
			room.x = leaf.x + floor((leaf.w - room.w) / 2) + 1
			room.y = leaf.y + floor((leaf.h - room.h) / 2) + 1
			room.split = leaf.split
			
			room.center = Vector2()
			room.center.x = floor(room.x + room.w / 2)
			room.center.y = floor(room.y + room.h / 2)
			rooms.append(room)
	
	for i in range(rooms.size()):
		var r = rooms[i]
		for x in range(r.x, r.x + r.w):
			for y in range(r.y, r.y + r.h):
				tiles[Vector2(x, y)] = FLOOR
#				set_cell(x, y, FLOOR)
				
	

func join_rooms() -> void:
	for sister in leaves:
		var leaf1 = sister[0]
		var leaf2 = sister[1]
		connect_leaves(tree[leaf1], tree[leaf2])
		

func connect_leaves(leaf1, leaf2) -> void:
	var x = min(leaf1.center.x, leaf2.center.x)
	var y = min(leaf1.center.y, leaf2.center.y)
	var w = 1
	var h = 1
	
	if leaf1.split == "h":
		x -= floor(w / 2) + 1
		h = abs(leaf1.center.y - leaf2.center.y)
	else:
		y -= floor(h / 2) + 1
		w = abs(leaf1.center.x - leaf2.center.x)
	
	x = 0 if x < 0 else x
	y = 0 if y < 0 else y
	
	for i in range(x , x + w):
		for j in range(y, y + h):
			if tiles[Vector2(i, j)] == WALL:
				tiles[Vector2(i, j)] = FLOOR
#
#			if get_cell(i, j) == WALL:
#				set_cell(i, j, FLOOR)
				

func clear_deadends() -> void:
	var done = false
	
	while !done:
		done = true
	
		for cell in get_used_cells():
			if get_cellv(cell) != FLOOR:
				continue
			var floor_count = check_nearby(cell.x, cell.y)
			if floor_count == 3:
				set_cellv(cell, WALL)
				done = false


func check_nearby(x, y) -> int:
	var count = 0
	if get_cell(x, y - 1) == WALL:
		count += 1		
	if get_cell(x, y + 1) == WALL:
		count += 1		
	if get_cell(x - 1, y) == WALL:
		count += 1		
	if get_cell(x + 1, y) == WALL:
		count += 1	
	return count	
	












		
	




















	
