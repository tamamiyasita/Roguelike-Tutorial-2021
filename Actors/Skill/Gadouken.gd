extends BaseSkill

var skill_anime = "gadouken"


onready var anime := $SkillAnime/AnimationPlayer
onready var tween := $SkillAnime/Tween
onready var body := $SkillAnime/Body
onready var object := $SkillAnime/Object

export(bool) var obj_on = false

func play(direc, enemy, damage, anm):
#	melee(direc, enemy, damage, anm, skill_anime)
	return range_atk(direc, enemy, damage, anm, skill_anime)



	
func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(0,3))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			var e = event.as_text()
			print(e, "EVENT")
			match e:
				"Up":
					BaseInfo.Player.attck_pos.rotation_degrees = -90
				"Down":
					BaseInfo.Player.attck_pos.rotation_degrees = 90
				"Left":
					BaseInfo.Player.attck_pos.rotation_degrees = 180
				"Right":
					BaseInfo.Player.attck_pos.rotation_degrees = 0
