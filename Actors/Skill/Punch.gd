extends BaseSkill

var skill_anime = "punch"


onready var anime := $SkillAnime/AnimationPlayer
onready var tween := $SkillAnime/Tween
onready var body := $SkillAnime/Body
onready var object := $SkillAnime/Object

export(bool) var obj_on = false 
func play(player_pos, enemy_pos, obj = obj_on):
	anime.play("play")
	




	
func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(1,2))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))


