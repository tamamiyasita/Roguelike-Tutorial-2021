extends Node


onready var Player = get_node("/root/Main/Player")
onready var Main = get_node("/root/Main/")
onready var Enemies = get_node('/root/Main/Dungeon/BSP_Dungeon/Enemies')
var force = preload("res://par/Force_par.tscn")

func _ready() -> void:
	print(Player)
	
	print(Enemies, "Enume")

func item_use(name, value=null):
	match name:
		"apple":
			Player.hp_change(value)
			get_tree().call_group("message", "get_massage", "You ate an apple and recovered 5 HP")
		"force":
			print("ban!")
			for e in Player.enemies:
				if is_instance_valid(e):		
					if e.visible:
						e.hp_change(value)
						get_tree().call_group("message", "get_massage", "You read the Force scroll")			
						print(e, e.states.hp, " baban")
						force.inidfs
						break
				else:
					continue
		_:
			Player.turn_end()
