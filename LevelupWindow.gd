extends Control




func _on_maxhp_pressed() -> void:
	yield(get_tree(),'idle_frame')
	BaseInfo.Player.states.max_hp += 5
	BaseInfo.Player.states.hp += 5
	self.hide()
	BaseInfo.Player.state = 2
	get_tree().call_group("lifebar", "hp_update")
	yield(get_tree(),'idle_frame')
	queue_free()

func _on_str_pressed() -> void:
	BaseInfo.Player.states.power += 1
	self.hide()
	BaseInfo.Player.state = 2
	get_tree().call_group("xpbar", "states_update")
	yield(get_tree(),'idle_frame')
	queue_free()

func _on_def_pressed() -> void:
	BaseInfo.Player.states.defense += 1
	self.hide()
	BaseInfo.Player.state = 2
	get_tree().call_group("xpbar", "states_update")
	yield(get_tree(),'idle_frame')
	queue_free()
