extends BaseSkill




var skill_anime = "somersaultkick"

func special_skill(amount, enemy):
	var damage = int(rand_range(1,2))
	damage += amount
	enemy.anime.play("damage")  
	enemy.hp_change(-damage)

	var text = [skill_anime, "Ling", enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1} hit the {2} for {3} damage!".format(text))
