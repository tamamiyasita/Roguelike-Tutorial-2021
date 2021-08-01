extends Node

const SaveGame = preload("res://SaveGame.gd")

var SAVE_FOLDER : String = "res://save"
var SAVE_NAME_TEMPLATE : String = "save_%03d.tres"

func save(id : int):
	var save_game := SaveGame.new()
	save_game.game_varsion = ProjectSettings.get_setting("application/config/version")
	
