extends Node


var inv_data = {}


func _ready() -> void:
	var inv_data_file = File.new()
	inv_data_file.open("user/://Data/ItemData - Sheet1.json", File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
