extends Node

const SaveGame = preload("res://SaveGame.gd")

var SAVE_FOLDER : String = "res://save"
var SAVE_NAME_TEMPLATE : String = "save_%03d.tres"

var apples = preload('res://map_object/apple.tscn')
var cnfs = preload("res://map_object/cnf_2.tscn")

var door = preload('res://map_object/Door.tscn')
var wall_obj = preload('res://map_object/Wall.tscn')

var rats = preload('res://Actors/CheeseRat.tscn')


func save(id : int):
	var save_game := SaveGame.new()
	save_game.game_varsion = ProjectSettings.get_setting("application/config/varsion")
	for node in get_tree().get_nodes_in_group("save"):
		node.save(save_game)
		
	var diretory : Directory = Directory.new()
	if not diretory.dir_exists(SAVE_FOLDER):
		diretory.make_dir_recursive(SAVE_FOLDER)
		
	var save_path = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var errer : int = ResourceSaver.save(save_path, save_game)
	if errer != OK:
		print("errer")
	
func _load(id : int):
	var save_file_path : String = SAVE_FOLDER.plus_file(SAVE_NAME_TEMPLATE % id)
	var file : File = File.new()
	if not file.file_exists(save_file_path):
		print("save")
		return
		
	var save_game : Resource = load(save_file_path)
	for entites in save_game.data.values():
		for entity in entites:
			print(entity.name , "NAME")

		
			if "Rat" in entity.name:
				var r = rats.instance()
				BaseInfo.Main.enemies.add_child(r, true)
				r._load(save_game)
				
			if "Wall" in entity.name:
				var w = wall_obj.instance()
				BaseInfo.Main.walls.add_child(w, true)
				w._load(save_game)

			if "Door" in entity.name:
				var d = door.instance()
				BaseInfo.Main.doors.add_child(d, true)
				d._load(save_game)
				
			if "Apple" in entity.name:
				var a = apples.instance()
				BaseInfo.Main.items.add_child(a, true)
				a._load(save_game)
				
