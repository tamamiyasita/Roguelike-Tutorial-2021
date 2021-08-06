extends Node

const SaveGame = preload("res://SaveGame.gd")

var SAVE_FOLDER : String = "res://save"
var SAVE_NAME_TEMPLATE : String = "save_%03d.tres"

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
	for node in get_tree().get_nodes_in_group("save"):
		node._load(save_game)
	
	
