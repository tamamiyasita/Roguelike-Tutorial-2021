extends BaseSkill

onready var rang := $ShortRange
var skill_anime = "spinningbirdkick"
var short_range := []


func play(direc, enemy, damage, anm):
	return melee(direc, enemy, damage, anm, skill_anime)


func special_skill(amount, enemy):
	for s in short_range:
		var d = 0
		var damage = amount
		for i in range(3):
			randomize()
			damage += int(rand_range(0,2))
			s.anime.play("damage")  
			s.damage_text.show_value(damage)
			d += damage
			
		s.hp_change(-d)
		var text = ["Ling's", name, enemy.name, d]
		get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))

		
func _on_ShortRange_area_entered(area):
	short_range.append(area)


func _on_ShortRange_area_exited(area):
	short_range.erase(area)

func _unhandled_input(event):
	if is_instance_valid(rang):
		if InputMap.action_has_event("up",event):
			rang.rotation_degrees = -90
		if InputMap.action_has_event("down",event):
			rang.rotation_degrees = 90
		if InputMap.action_has_event("left",event):
			rang.rotation_degrees = 180
		if InputMap.action_has_event("right",event):
			rang.rotation_degrees = 0
		if InputMap.action_has_event("up_right",event):
			rang.rotation_degrees = -90
		if InputMap.action_has_event("up_left",event):
			rang.rotation_degrees = -90
		if InputMap.action_has_event("down_right",event):
			rang.rotation_degrees = 90
		if InputMap.action_has_event("down_left",event):
			rang.rotation_degrees = 90
		
			
			
			
#		for e in InputMap.get_actions():
#		if event is InputEventKey:
#			if event.pressed:
#				var e = event.as_text()
#				print(e, "EVENT")
#				match e:
#					"Up":
#						rang.rotation_degrees = -90
#					"Down":
#						rang.rotation_degrees = 90
#					"Left":
#						rang.rotation_degrees = 180
#					"Right":
#						rang.rotation_degrees = 0

