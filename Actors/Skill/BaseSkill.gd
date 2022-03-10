class_name BaseSkill
extends TextureButton

export var skill_activation_rate := 100
export var combo_bonus := 5

var skill_power_text = {0:"small",1:"middlerate",2:"large", 3:"severe"}
export(int, "small", "middlerate","large", "severe") var skill_power

var ready_change = false



onready var skill_info := $TextureRect/Label

func _ready():
	connect("pressed", self, "_on_BaseSkill_pressed")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	yield(get_tree(),'idle_frame')
	
	var t = [name, skill_activation_rate, skill_power_text[skill_power], combo_bonus]
	skill_info.text = " Name: {0} \n Skill activation rate: {1}% \n Power: {2} \n Combo bonus: {3}".format(t)
	


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
	if get_parent().name != "Skills":
		$TextureRect.show()


func _on_mouse_exited():
	$TextureRect.hide()
