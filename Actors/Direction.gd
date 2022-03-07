extends Position2D


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			var e = event.as_text()
			print(e, "EVENT")
			match e:
				"Up":
					rotation_degrees = -90
				"Down":
					rotation_degrees = 90
				"Left":
					rotation_degrees = 180
				"Right":
					rotation_degrees = 0
			print(rotation_degrees)
					

func return_deg():
	return rotation_degrees
