extends Node2D

class_name Main


const SAVE_PATH = "res://savegame.bin"
var utils_ref : Utils = preload("res://Global/Utils.gd").new()
var is_saved : bool = false

signal save_file_found(is_saved : bool)
		
func _ready():
	pass

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	if FileAccess.file_exists(SAVE_PATH):
		is_saved = true
		emit_signal("save_file_found", is_saved)
	else:
		Utils.start_game()

func _on_load_pressed():
	if !FileAccess.file_exists(SAVE_PATH):
		get_node("BG/VBoxContainer/Load/CanvasLayer/Empty save").show()
	else:
		utils_ref.loadGame()
		get_tree().change_scene_to_file("res://world.tscn")

func _on_instructions_pressed():
	get_node("BG/VBoxContainer/Instructions/CanvasLayer/Instructions2").show()
