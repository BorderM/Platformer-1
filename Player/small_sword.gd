extends AnimatedSprite2D

class_name SmallSword

var sword_radius = 100
var frog_count = 0
var sword_swing_state = false
var mouse_position = null
var collision_pos = $".".position
var player_position : Vector2



# Called when the node enters the scene tree for the first time.
func _ready():
	sword_idle()
	$SmallSword/SwordCollision.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	#var angle =  player_position.angle_to(mouse_position)
	#var radius = 100
	#var sword_position = player_position + Vector2(cos(angle), sin(angle)) * radius
	#$".".position = sword_position
	change_dir()
	sword_attack()
	

	
func sword_attack():
	if Input.is_action_just_pressed("LeftClick") or Input.is_action_just_pressed("shift"):
		sword_swing_state = !sword_swing_state
		$SmallSword/SwordCollision.disabled = false
		var facing_dir = mouse_position.x - get_node("..").position.x
		if facing_dir >= 1:
			$AnimationPlayer.play("AttackRight")
		elif facing_dir <= -1:
			$AnimationPlayer.play("AttackLeft")
		await $AnimationPlayer.animation_finished
		sword_swing_state = !sword_swing_state
		$SmallSword/SwordCollision.disabled = true
		sword_idle()
	
func sword_idle():
	$AnimationPlayer.play("Idle")
	
	
	
func change_dir():
	if self.flip_h == true:
		$SmallSword/SwordCollision.position.x = -35.296
	elif self.flip_h == false:
		$SmallSword/SwordCollision.position.x = 35.5
	#if self.position.x == 78 and animation_finished:
		#$SwordPlayer.play("IdleRight")
	#elif self.position.x == -61 and animation_finished:
		#$SwordPlayer.play("IdleLeft")
		
#func sword_pos():
	#var angle = mouse_position.angle_to(Vector2.RIGHT)
	#var sword_position = Vector2(cos(angle), sin(angle)) * sword_radius
	#$".".position = sword_position
	#$SwordAttack/CollisionShape2D.position = collision_pos
	#$".".rotation = angle
	#$SwordAttack/CollisionShape2D.rotation = angle
