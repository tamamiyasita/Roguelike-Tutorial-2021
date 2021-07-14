extends TileMap

const PATH_LINE_WIDTH = 2.0
const DRAW_COLOR = Color.ghostwhite

# グローバルマップサイズ
export(Vector2) var map_size = Vector2.ONE * 40

# path変数にはセッターメソッドを使う
var path_start_position = Vector2() setget _set_path_start_position
var path_end_position = Vector2() setget _set_path_end_position

var _point_path = []


# A*Nodeはコードからのみ作成出来る
onready var astar_node = AStar2D.new()

# get_used_cells_by_id()メソッドで壁になっているタイルセットIDをリストで得る
onready var obstacles = get_used_cells_by_id(1)
onready var _half_cell_size = cell_size / 2

func _ready() -> void:
	var walkable_cell_list = astar_add_walkable_cells(obstacles)
	astar_connect_walkable_cells(walkable_cell_list)
	
func _draw() -> void:
	if not _point_path:
		return
	var point_start = _point_path[0]
	var point_end = _point_path[len(_point_path) - 1]
	
	set_cell(point_start.x, point_start.y, 1)
	set_cell(point_end.x, point_end.y, 2)
	
	var last_point = map_to_world(Vector2(point_start.x, point_start.y)) + _half_cell_size
	for index in range(1, len(_point_path)):
		var current_point = map_to_world(Vector2(_point_path[index].x, _point_path[index].y)) + _half_cell_size
		draw_line(last_point, current_point, DRAW_COLOR, PATH_LINE_WIDTH, true)
		draw_circle(current_point, PATH_LINE_WIDTH * 2.0, DRAW_COLOR)
		last_point = current_point
		
# マップの障害物(obstacles)を覗いた全てのポイントをAstarNodeに追加する
func astar_add_walkable_cells(obstacle_list = []):
	var points_array = []
	for y in range(map_size.y):
		for x in range(map_size.x):
			var point = Vector2(x, y)
			if point in obstacle_list:
				continue
			points_array.append(point)
			# Astarクラスはインデックスを点で参照する
			# 点の座標からインデックスを計算する関数で同じ入力点なら同じインデックスが得られるようにする
			var point_index = calculate_point_index(point)
			astar_node.add_point(point_index, Vector2(point.x, point.y))
			
	return points_array
	






























