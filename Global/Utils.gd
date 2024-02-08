extends Node

@export var player_pos : Vector2
const SAVE_PATH = "res://savegame.bin"


func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerHP": Game.playerHP,
		"gold": Game.gold,
		"playerPos": Game.player_pos,
		"player_current_xp": Game.player_current_xp,
		"player_level": Game.player_level,
		"player_total_xp": Game.player_total_xp,
		"player_max_hp": Game.player_max_hp,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerHP = current_line["playerHP"]
				Game.gold = current_line["gold"]
				Game.player_pos = current_line["playerPos"]
				Game.player_current_xp = current_line["player_current_xp"]
				Game.player_level = current_line["player_level"]
				Game.player_total_xp = current_line["player_total_xp"]
				Game.player_max_hp = current_line["player_max_hp"]
				
				
	
func start_game():
	Game.playerHP = 10
	Game.gold = 0
	Game.player_current_xp = 0
	Game.player_level = 1
	Game.player_total_xp = 0
	Game.player_max_hp = 10
	get_tree().change_scene_to_file("res://world.tscn")

