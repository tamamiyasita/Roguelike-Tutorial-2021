extends Control

onready var skill_window = $SkillWindow
onready var skill_lists := $SkillWindow/SkillLists
onready var active_skills := $ActiveSkills
onready var back_panel := $Back

onready var Base_skill = preload("res://Actors/Skill/BaseSkill.tscn")
onready var level_light = preload("res://Level_pop_light.tscn")
onready var tween := $Tween

func _ready():
	back_show()
	level_up_skill_add()

func skill_pop_up(value):
	for a in active_skills.get_children():
		if a.name == value:
#			var skill = active_skills.get_child(value)
			tween.interpolate_property(a, "rect_scale",
			Vector2.ONE*2.5, Vector2.ONE, .6,
			Tween.TRANS_BACK, Tween.EASE_OUT_IN)
			tween.start()
	
func skill_window_open():
	if skill_window.visible:
		for s in active_skills.get_children():
			if s.ready_change == true:
				s.ready_change = false
		skill_window.hide()
	else:
		skill_window.show()
		for s in skill_lists.get_children():
			s.text_texture.hide()

func level_up_skill_add():
	if back_panel.get_child_count() > active_skills.get_child_count():
		get_tree().call_group("message", "get_massage", "New skills can now be set.")
		var base_skill = Base_skill.instance()
		active_skills.add_child(base_skill)



func back_show():
	var cnt = 0
	for p in active_skills.get_children():
		print(p.name)
		if p.name != null:
			print(back_panel.get_child(cnt))
			back_panel.get_child(cnt).show()
		else:
			back_panel.get_child(cnt).hide()
		cnt += 1

func add_skill_list():
	var add_skill = SkillInfo.skill_list_name.pop_back()
	if add_skill == null:
		return
	if "@" in add_skill:
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
			var baseskill = Base_skill.instance()
			a.replace_by(baseskill)
#			return

	for s in active_skills.get_children():

		if s.ready_change == true:

			yield(get_tree(),'idle_frame')
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
