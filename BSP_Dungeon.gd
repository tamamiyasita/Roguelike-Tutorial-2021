extends TileMap

export(int) var map_w := 40
export(int) var map_h := 40
export(int) var min_room_size := 8
export(float, 0.2, 0.5) var min_room_factor := 0.4

var WALL :int = tile_set.find_tile_by_name("wall_0")
var FLOOR :int = tile_set.find_tile_by_name("floor_0")

var UT = preload("res://Util.tscn")
var Util = UT.instance()

var tree := {}
var leaves := []
var leaf_id :int = 0
var rooms := []

onready var player :Area2D = $Player

func _ready() -> void:
	generate()

func generate() -> void:
	clear()
	fill_roof()
	start_tree()
	create_leaf(0)
	create_rooms()
	join_rooms()
	clear_deadends()
	
	
	var point = rooms[0].center
	player.position = map_to_world(point)
	
func fill_roof() -> void:
	for x in range(0, map_w):
		for y in range(0, map_h):
			set_cell(x, y, WALL)
			

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
				set_cell(x, y, FLOOR)
	

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
			if get_cell(i, j) == WALL:
				set_cell(i, j, FLOOR)
				

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
	












		
	




















	
