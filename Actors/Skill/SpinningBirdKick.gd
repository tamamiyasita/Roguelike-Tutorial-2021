extends BaseSkill

onready var rang := $ShortRange
var skill_anime = "spinningbirdkick"
var short_range := []

func special_skill(amount, enemy):
	for s in short_range:
		var damage = int(rand_range(1,2))
		damage += amount
		s.anime.play("damage")  
		s.hp_change(-damage)

		var text = [skill_anime, "Ling", enemy.name, damage]
		get_tree().call_group("message", "get_massage",  "{0}  {1} hit the {2} for {3} damage!".format(text))
		
func _on_ShortRange_area_entered(area):
	short_range.append(area)


func _on_ShortRange_area_exited(area):
	short_range.erase(area)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			var e = event.as_text()
			print(e, "EVENT")
			match e:
				"Up":
					rang.rotation_degrees = -90
				"Down":
					rang.rotation_degrees = 90
				"Left":
					rang.rotation_degrees = 180
				"Right":
					rang.rotation_degrees = 0

