extends Control

onready var skill_window = $SkillWindow
onready var skill_lists := $SkillWindow/SkillLists
onready var active_skills := $ActiveSkills

func skill_window_open():
	skill_window.show()



func active_skill_change(node_name):

	for a in active_skills.get_children():
		if a.name == node_name:
			print("syoutyuudesu")
			return

	for s in active_skills.get_children():
		if s.ready_change == true:
			var skill = SkillInfo.return_instance(node_name)
			s.replace_by(skill)
	skill_window.hide()
			
