extends Node2D

class_name Sword

var frog_count = 0
var sword_sprite = "."
var sword_swing_state = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$SwordPlayer.play("Idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sword_swing()
	
	
func sword_swing():
	if Input.is_action_just_pressed("LeftClick") or Input.is_action_just_pressed("shift"):
		sword_swing_state = true
		$SwordPlayer.play("Swing")
		await $SwordPlayer.animation_finished
	sword_swing_state = false
	$SwordPlayer.play("Idle")	

#func _on_sword_body_entered(body):
		#if body.name == "frogBody" and sword_swing_state == true:
			#get_node("../../Mobs/Frog Spawns/Frog").frog_take_damage()
