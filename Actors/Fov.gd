extends Area2D

onready var player = get_parent()


func fov_calc(radius):
	
	var char_x = round(player.position.x / 32 )
	var char_y = round(player.position.y / 32 )
	
	var resolution = 12
	var circumference = 2 * PI * radius
	
	var radians_per_point = 2 * PI / (circumference * resolution)
	var point_count = int(round(circumference)) * resolution
	for i in range(point_count):
		var radians = i * radians_per_point
		
		var x = sin(radians) * radius + char_x
		var y = cos(radians) * radius + char_y
		
		var ray_cheks = radius
		for j in range(ray_cheks):
			var v1 = Vector2(char_x, char_y)
			var v2 = Vector2(x, y)
			var xy2 = lerp(v1, v2, j / ray_cheks)
			var x2 = round(xy2.x)
			var y2 = round(xy2.y)
			
			var pixlel_point = Vector2(x2, y2)
			
			var blocks = false
			var point_list = []
			for point in player.parent_path():
				if Vector2(round(point.global_position.x / 32), round(point.global_position.y /32)) == pixlel_point:
					point_list.append(point)
			
			for wall in point_list:
				wall.is_visible = true
				wall.occ.hide()
				blocks = true
			if blocks:
				break
			
			





























