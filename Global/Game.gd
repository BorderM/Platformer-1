extends Node

var playerHP = 10
var gold = 0
var player_pos = Vector2()
var player_max_hp = 10
var player_level = 1
var xp_to_level = get_xp_to_level(player_level + 1)
var player_total_xp = 0
var player_current_xp = 0
var player_power = 1
var is_climbing = false
var randintx
var randinty
var rng = RandomNumberGenerator.new()

func get_xp_to_level(player_level):
	return round(pow(player_level, 2) + player_level * 4)
	
func gain_experience(amount):
	player_current_xp += amount
	player_total_xp += amount
	var growth_data = []
	while player_current_xp >= xp_to_level:
		player_current_xp = 0
		growth_data.append([xp_to_level, xp_to_level])
		level_up()	
	
	growth_data.append([player_current_xp, get_xp_to_level(player_level + 1)])
	#emit_signal("experience_gained", growth_data)
	
func level_up():
	player_level += 1
	xp_to_level = get_xp_to_level(player_level + 1)
	player_max_hp += 3


	
func rand_pos():
	match randi_range(1, 13):
		1:
			randintx = rng.randi_range(40, 701)
			randinty = rng.randi_range(765, 769)
		2:
			randintx = rng.randi_range(1806, 1885)
			randinty = rng.randi_range(572, 573)
		3:
			randintx = rng.randi_range(1510, 1875)
			randinty = rng.randi_range(403, 408)
		4:
			randintx = rng.randi_range(1204, 1336)
			randinty = rng.randi_range(480, 488)
		5:
			randintx = rng.randi_range(824, 953)
			randinty = rng.randi_range(403, 408)
		6:
			randintx = rng.randi_range(632, 757)
			randinty = rng.randi_range(403, 408)
		7:
			randintx = rng.randi_range(76, 444)
			randinty = rng.randi_range(980, 984)
		8:
			randintx = rng.randi_range(613, 905)
			randinty = rng.randi_range(930, 933)
		9:
			randintx = rng.randi_range(1068, 1893)
			randinty = rng.randi_range(990, 994)
		10:
			randintx = rng.randi_range(1078, 1872)
			randinty = rng.randi_range(830, 840)
		11:
			randintx = rng.randi_range(763, 930)
			randinty = rng.randi_range(770, 774)
		12:
			randintx = rng.randi_range(1048, 1222)
			randinty = rng.randi_range(720, 725)
		13:
			randintx = rng.randi_range(1340, 1569)
			randinty = rng.randi_range(670, 675)	
	

	

