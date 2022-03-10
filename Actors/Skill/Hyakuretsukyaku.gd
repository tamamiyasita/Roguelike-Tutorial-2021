extends BaseSkill


var skill_anime = "hyakuretsukyaku"


func play(direc, enemy, damage, anm):
	melee(direc, enemy, damage, anm, skill_anime)


func special_skill(amount, enemy):
	var d = 0
	var damage = amount
	for i in range(4):
		randomize()
		damage += int(rand_range(0,1))
		enemy.anime.play("damage")  
		enemy.damage_text.show_value(damage)
		d += damage
		
	enemy.hp_change(-damage)
	var text = ["Ling's", name, enemy.name, d]
	get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))
