extends BaseSkill


var skill_anime = "dankukyaku"

func special_skill(amount, enemy):
	var d = 0
	for i in range(3):
		randomize()
		var damage = int(rand_range(0,2))
		damage += amount
		enemy.anime.play("damage")  
		enemy.damage_text.show_value(damage)
		d += damage
		
	enemy.hp_change(-d)
	var text = ["Ling's", name, enemy.name, d]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))
