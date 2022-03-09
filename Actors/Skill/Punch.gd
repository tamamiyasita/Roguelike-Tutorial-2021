extends BaseSkill

var skill_anime = "punch"

onready var skill_info := $TextureRect/Label

func _ready():
	var t = [name, skill_activation_rate, skill_power_text, combo_bonus]
	skill_info.text = " Name: {0} \n Skill activation rate: {1}% \n Power: {2} \n Combo bonus: {3}".format(t)
	
	
func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(1,2))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))




func _on_Punch_mouse_entered():
	if get_parent().name != "Skills":
		$TextureRect.show()


func _on_Punch_mouse_exited():
	$TextureRect.hide()
