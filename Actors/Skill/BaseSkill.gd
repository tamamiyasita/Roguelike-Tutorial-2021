class_name BaseSkill
extends TextureButton

export var skill_activation_rate := 100
export var skill_power_text := "small"
export var combo_bonus := 5

var ready_change = false

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






func _ready():
	connect("pressed", self, "_on_BaseSkill_pressed")

