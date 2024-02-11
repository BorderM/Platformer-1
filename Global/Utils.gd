extends Node

@export var player_pos : Vector2
const SAVE_PATH = "res://savegame.bin"
var player_ref : Player = preload("res://Player/Player.gd").new()

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": get_node("/root/world/Player/Player").playerHP,
		"gold": get_node("/root/world/Player/Player").gold,
		"playerPos": get_node("/root/world/Player/Player").player_pos,
		"player_current_xp": get_node("/root/world/Player/Player").player_current_xp,
		"player_level": get_node("/root/world/Player/Player").player_level,
		"player_total_xp": get_node("/root/world/Player/Player").player_total_xp,
		"player_max_hp": get_node("/root/world/Player/Player").player_max_hp,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
	
#func loadGame():
	#var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	#if FileAccess.file_exists(SAVE_PATH) == true:
		#if not file.eof_reached():
			#var current_line = JSON.parse_string(file.get_line())
			#if current_line:
				#player_ref.playerHP = current_line["playerHP"]
				#player_ref.gold = current_line["gold"]
				#player_ref.player_pos = current_line["playerPos"]
				#player_ref.player_current_xp = current_line["player_current_xp"]
				#player_ref.player_level = current_line["player_level"]
				#player_ref.player_total_xp = current_line["player_total_xp"]
				#player_ref.player_max_hp = current_line["player_max_hp"]
				
				
	
func start_game():
	get_tree().change_scene_to_file("res://world.tscn")
	
#func await_node():
	#if !get_node("/root/world/Player/Player"):
		#print("Anything")
		#await get_tree().create_timer(1).timeout
		#await await_node()

