extends Control

onready var skill_window = $SkillWindow
onready var skill_lists := $SkillWindow/SkillLists
onready var active_skills := $ActiveSkills
onready var back_panel := $Back

onready var Base_skill = preload("res://Actors/Skill/BaseSkill.tscn")

func _ready():
	back_show()
	level_up_skill_add()


func skill_window_open():
	skill_window.show()

func level_up_skill_add():
	var base_skill = Base_skill.instance()
	active_skills.add_child(base_skill)

func back_show():
	var cnt = 0
	for p in active_skills.get_children():
		print(p.name)
		if p.name:
			back_panel.get_child(cnt).show()
		else:
			back_panel.get_child(cnt).hide()
		cnt += 1

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
			s.queue_free()
	
	get_tree().call_group("player", "skill_clear")
	yield(get_tree().create_timer(0.1), "timeout")	
	for s in active_skills.get_children():
		get_tree().call_group("player", "skill_set", s.name)
	skill_window.hide()
	back_show()


func _on_CloseButton_pressed() -> void:
	skill_window.hide()
