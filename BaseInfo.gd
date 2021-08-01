extends Node


onready var Player = get_node("/root/Main/Player")
onready var Main = get_node("/root/Main/")
onready var Enemies = get_node('/root/Main/Dungeon/BSP_Dungeon/Enemies')
var force = preload("res://par/Force_par.tscn")
var fb = preload("res://par/FB_par.tscn")
var cnf = preload("res://par/cnf_par.tscn")
var current_item: Dictionary = {}
var target_enemy

func _ready() -> void:
	print(Player)
	
	print(Enemies, "Enume")
	set_process(false)


func _process(delta: float) -> void:
	if current_item.has("Fireball scroll"):
		var damage = current_item["Fireball scroll"]
		if target_enemy:
			for e in Main.enemies:
				if 50 > target_enemy.position.distance_to(e.position):
					print("hai")
					e.hp_change(damage)
			get_tree().call_group("message", "get_massage", "You read the Fire scroll \n Inflicted 9 damage")			
			var f = fb.instance()
			add_child(f)
			f.position = target_enemy.position+Vector2(16,-10)
			f.start()
#					target_enemy.hp_change(current_item["fb"])
					
	
			set_process(false)
			Player.turn_end()
			target_enemy = null
		else:
			Player.state = 0
	
	elif current_item.has("Scroll of confusion"):
		if target_enemy:
			get_tree().call_group("message", "get_massage", "You read a scroll of confusion")			
			var c = cnf.instance()
			add_child(c)
			c.position = target_enemy.position+Vector2(16,-1)
			c.start()
			target_enemy.cnf = true
			target_enemy.cnf_turn = 7
			target_enemy = null
#			yield(get_tree().create_timer(1.0), "timeout")
			Player.turn_end()
	
			


func item_use(name, value=null):
	match name:
		"apple":
			Player.hp_change(value)
			get_tree().call_group("message", "get_massage", "You ate an apple and recovered 5 HP")
		"Force scroll":
			print("ban!")
			for e in Player.enemies:
				if is_instance_valid(e):		
					if e.visible:
						e.hp_change(value)
						get_tree().call_group("message", "get_massage", "You read the Force scroll")			
						var f = force.instance()
						add_child(f)
						f.position = e.position+Vector2(16,-10)
						f.start()
						break
				else:
					continue
					
		"Fireball scroll":
			Player.state = 3
			print(Player.state)
			current_item = {"Fireball scroll":value}
			set_process(true)
			
		"Scroll of confusion":
			Player.state = 3
			current_item = {"Scroll of confusion":value}
			set_process(true)
			
		_:
			Player.turn_end()
	Player.container.hide()
