extends Node

@export var player_pos : Vector2
const SAVE_PATH = "res://savegame.bin"
var player_ref : Player = preload("res://Player/Player.gd").new()

#func saveGame():
	#var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	#var data: Dictionary = {
		#"playerHP": get_node("/root/world/Player/Player").playerHP,
		#"gold": get_node("/root/world/Player/Player").gold,
		#"playerPos": get_node("/root/world/Player/Player").player_pos,
		#"player_current_xp": get_node("/root/world/Player/Player").player_current_xp,
		#"player_level": get_node("/root/world/Player/Player").player_level,
		#"player_total_xp": get_node("/root/world/Player/Player").player_total_xp,
		#"player_max_hp": get_node("/root/world/Player/Player").player_max_hp,
	#}
	#var jstr = JSON.stringify(data)
	#file.store_line(jstr)
	
	
func saveGame(player: Player) -> void:
	var save_file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)	
	var data = {"player_data": player.player_data}
	var json_string = JSON.stringify(data)
	save_file.store_string(json_string)
	save_file.close()
	
func loadGame(player: Player) -> void:
	if FileAccess.file_exists(SAVE_PATH):
		var save_file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if not save_file.eof_reached():
			var json_string = save_file.get_as_text()
			var data = JSON.parse_string(json_string)
			save_file.close()
			if data.has("player_data"):
				get_node("/root/world/Player/Player").player_data = data["player_data"]
			else:
				print("Player data not found in the save file")
		else:
			print("Failed to open save file for reading")
	else:
		print("Save file does not exist")
	
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

