extends Control


func _ready():
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	get_tree().paused = true
	
	$AnimationPlayer.play("blur")
	
	
func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	if Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()
	


func _on_save_and_quit_pressed():
	Utils.saveGame()
	resume()
	
	get_tree().change_scene_to_file("res://main.tscn")

func _process(delta):
	testEsc()
