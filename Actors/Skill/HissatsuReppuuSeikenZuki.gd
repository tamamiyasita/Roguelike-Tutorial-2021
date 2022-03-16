extends BaseSkill


var skill_anime = "hissatsureppuuseikenzuki"


func play(direc, enemy, damage, anm):
	if melee(direc, enemy, damage, anm, skill_anime):
		range_fake_atk(direc, enemy, damage, anm, "DoubleBlizzard")
		return true


func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(15,29))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))
