extends Control

@onready var world_manager : WorldManager = get_node("../..")
# Called when the node enters the scene tree for the first time.

func _ready():
	hide()
	#world_manager.connect("toggle_game_paused", _on_world_manager_toggle_game_paused)
	#starts as hidden and connects to the signal toggle_game_paused from world scene

#func _on_world_manager_toggle_game_paused(is_paused : bool):
	#if(is_paused):
		#show()
	#elif(!is_paused):
		#hide()

func _on_resume_pressed():
	world_manager.game_paused = false
	hide()
	
func _on_save_pressed():
	Utils.saveGame()
	world_manager.game_paused = false
	get_tree().change_scene_to_file("res://main.tscn")
	

