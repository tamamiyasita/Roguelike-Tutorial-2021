extends Control

onready var skill_window = $SkillWindow
onready var skill_lists := $SkillWindow/SkillLists
onready var active_skills := $ActiveSkills

func skill_window_open():
	skill_window.show()
	

func add_skill_list():
	var add_skill = SkillInfo.skill_list_name.pop_back()
	if add_skill == null:
		return
	var Skill = load(SkillInfo.return_instance(add_skill))
	var skill = Skill.instance()
	skill_lists.add_child(skill)
	
	
#	var Skill = load(SkillInfo.return_instance(value))
#	var skill = Skill.instance()
#	skill_lists.add_child(skill)

func active_skill_change(node_name):

	for a in active_skills.get_children():
		if a.name == node_name:
			print("syoutyuudesu")
			return

	for s in active_skills.get_children():
		if s.ready_change == true:
			var Skill = load(SkillInfo.return_instance(node_name))
			var skill = Skill.instance()
			
			s.replace_by(skill)
	
	get_tree().call_group("player", "skill_clear")
	yield(get_tree().create_timer(0.1), "timeout")	
	for s in active_skills.get_children():
		get_tree().call_group("player", "skill_set", s.name)
	skill_window.hide()
			


func _on_CloseButton_pressed() -> void:
	skill_window.hide()
