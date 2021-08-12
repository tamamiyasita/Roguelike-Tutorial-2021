extends Label


func dungeon_level_up(level):
	text = "Dungeon Level {str}".format({"str":level})
	$AnimationPlayer.play("Next")
	
func save_pop():
	$AnimationPlayer.play('SAVE')
func load_pop():
	$AnimationPlayer.play('LOAD')
