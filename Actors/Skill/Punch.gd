extends BaseSkill

var skill_anime = "attack"




export(bool) var obj_on = false

func play(direc, enemy, damage, anm):
	return melee(direc, enemy, damage, anm, skill_anime)




	
func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(1,2))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))


