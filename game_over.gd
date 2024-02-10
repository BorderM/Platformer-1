extends Node2D

var utils_ref : Utils = preload("res://Global/Utils.gd").new()
@onready var anim = get_node("AnimationPlayer")	
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("FadeIn")


func _on_play_again_pressed():
	anim.play("FadeOut")
	await anim.animation_finished
	Utils.start_game()


func _on_quit_pressed():
	anim.play("FadeOut")
	await anim.animation_finished
	get_tree().quit()


func _on_main_menu_pressed():
	anim.play("FadeOut")
	await anim.animation_finished
	get_tree().change_scene_to_file("res://main.tscn")
