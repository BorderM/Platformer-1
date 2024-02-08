extends Node2D



func _on_body_entered(body):
	if body.name == "Player":
		Game.is_climbing = true


func _on_body_exited(body):
	if body.name == "Player":
		Game.is_climbing = false
