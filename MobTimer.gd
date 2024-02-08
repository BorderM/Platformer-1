extends Timer


var frog = preload("res://Frog.tscn")



func _on_mob_timer_timeout():
	var frogTemp = frog.instantiate()
	var rng = RandomNumberGenerator.new()
	var randintx = rng.randi_range(0, 1918)
	var randinty = rng.randi_range(300, 340)
	frogTemp.position = Vector2(randintx, randinty)
	get_node("Frog Spawns").add_child(frogTemp)
