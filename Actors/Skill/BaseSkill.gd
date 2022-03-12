class_name BaseSkill
extends TextureButton

export var skill_activation_rate := 100
export var combo_bonus := 5

var skill_power_text = {0:"small",1:"middlerate",2:"large", 3:"severe"}
export(int, "small", "middlerate","large", "severe") var skill_power

var ready_change = false


onready var skill_info := $TextureRect/Label
onready var text_texture = $TextureRect


func _ready():
	connect("pressed", self, "_on_BaseSkill_pressed")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
#	yield(get_tree(),'idle_frame')
	
	var t = [name, skill_activation_rate, skill_power_text[skill_power], combo_bonus]
	skill_info.text = " Name: {0} \n Skill Use Rate: {1}% \n Power: {2} \n Combo bonus: {3}".format(t)
	


func special_skill(damage, enemy):
	pass

func melee(direc, enemy, damage, anm, skill_anime):
	if !hit_chance():
		return
	BaseInfo.Player.anime.play(skill_anime)
	BaseInfo.Player.position2d.attack_start(BaseInfo.Player.position2d, direc, anm.current_animation_length)
	get_tree().call_group("shout", "shout_pop", name, anm.current_animation_length)
	
	yield(anm, "animation_finished" )
	special_skill(damage, enemy)
	return true
	

func range_atk(direc, enemy, damage, anm, skill_anime):
	if !hit_chance():
		return
	BaseInfo.Player.attck_pos.look_at(enemy.position)
	BaseInfo.Player.anime.play(skill_anime)
	BaseInfo.Player.position2d.range_start(BaseInfo.Player.attck_pos, direc, anm.current_animation_length)
	get_tree().call_group("shout", "shout_pop", name, anm.current_animation_length)
	BaseInfo.Player.show_obj()
	yield(anm, "animation_finished" )
	special_skill(damage, enemy)
	return true
	
func hit_chance():
	randomize()
	var chance = randi() % 101
	var hit = BaseInfo.Player.combo_bonus + skill_activation_rate
	print(name,"  chance=",str(chance),"  hit=",str(hit))
	if chance <= hit:
		get_tree().call_group("skillui", "skill_pop_up", name)
		BaseInfo.Player.combo_bonus += combo_bonus
		yield(get_tree(),'idle_frame')		
		print("Skill HIT   ", BaseInfo.Player.combo_bonus)
		get_tree().call_group("xpbar", "states_update")
		get_tree().call_group("xpbar", "combo_pop")
		return true
	else:
		print("Skill MISS")
		return
	
	


func lists_skill_press():
	print("list")
	get_tree().call_group("skillui", "active_skill_change", name)


func active_skill_press():
	print("act")
	get_tree().call_group("skillui", "skill_window_open")
	ready_change = true




func _on_BaseSkill_pressed():
	if get_parent().name == "SkillLists":
		lists_skill_press()
	elif get_parent().name == "ActiveSkills":
		active_skill_press()
	else:
		print("non")


func _on_mouse_entered():
	if "@" in name:
		return
	if get_parent().name != "Skills" and name != "BaseSkill":
		text_texture.show()

func _on_mouse_exited():
	text_texture.hide()
