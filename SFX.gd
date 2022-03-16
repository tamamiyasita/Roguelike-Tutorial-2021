extends Node


func damage():
	var r = rand_range(-1.8, 1.8)
	$damage2.pitch_scale += r
	$damage2.play()
	$damage2.pitch_scale = 1

func dead():
	$dead.play()

func get_item():
	$get.play()

func skill():
	$skill.play()

func learn():
	$Learn.play()
func eat():
	$eat.play()
