extends BaseSkill



var skill_anime = "kick"


func play(direc, enemy, damage, anm):
	melee(direc, enemy, damage, anm, skill_anime)


func special_skill(amount, enemy):
	var damage = amount
	damage += int(rand_range(1,3))
	enemy.anime.play("damage")  
	enemy.damage_text.show_value(damage)
	
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, damage]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))
