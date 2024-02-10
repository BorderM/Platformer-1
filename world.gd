extends Node2D

class_name WorldManager

#signal toggle_game_paused(is_paused : bool)

var game_paused : bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		#emit_signal("toggle_game_paused", game_paused)

func _input(event : InputEvent):
	if(event.is_action_pressed("esc")):
		game_paused = !game_paused
		get_node("CanvasLayer/PauseMenu").show()
	


#func _on_area_2d_body_entered(body):
	#if body == "Player":
		#pass
