extends Control


func _ready():
	hide()

var game_paused : bool = false:
	set = set_paused
		
func set_paused(value:bool) -> void:
	game_paused = value
	get_tree().paused = game_paused
	visible = game_paused

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("esc"):
		game_paused = !game_paused
		visible = game_paused

func _on_resume_pressed():
	game_paused = false
	
func _on_save_pressed():
	Utils.saveGame()
	game_paused = false
	get_tree().change_scene_to_file("res://main.tscn")
	

