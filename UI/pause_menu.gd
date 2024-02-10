extends Control

@onready var world_manager : WorldManager = get_node("../..")

# Called when the node enters the scene tree for the first time.

func _ready():
	hide()

#func _process(delta):
	#if not (Input.is_action_just_pressed("ui_cancel")):
		#return
	#elif visible:
		#print(true)
		#world_manager.game_paused = !world_manager.game_paused
		#hide()

	
	

func _on_resume_pressed():
	world_manager.game_paused = !world_manager.game_paused
	hide()
	
func _on_save_pressed():
	Utils.saveGame()
	world_manager.game_paused = !world_manager.game_paused
	get_tree().change_scene_to_file("res://main.tscn")
	

