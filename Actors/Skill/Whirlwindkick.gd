extends BaseSkill


var skill_anime = "whirlwindkick"
var short_range := []


func play(direc, enemy, damage, anm):
	return melee(direc, enemy, damage, anm, skill_anime)


func special_skill(amount, enemy):
	
	for s in short_range:
		var damage = amount
		damage += int(rand_range(1,2))
		s.anime.play("damage")  
		s.damage_text.show_value(damage)
		
		s.hp_change(-damage)
		var text = ["Ling's", name, enemy.name, damage]
		get_tree().call_group("message", "get_massage",  "{0}  {1}! \n        the {2} for {3} damage!".format(text))

func _on_ShortRange_area_entered(area):
	short_range.append(area)


func _on_ShortRange_area_exited(area):
	short_range.erase(area)
