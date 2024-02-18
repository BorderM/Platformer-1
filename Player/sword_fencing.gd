extends AnimatedSprite2D

class_name Sword_Fencing

var frog_count = 0
var sword_swing_state = false
var mouse_position = null
# Called when the node enters the scene tree for the first time.
func _ready():
	sword_idle()
	$SwordAttack/CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	sword_attack()
	#sword_idle()
	

	
	
func sword_attack():
	if Input.is_action_just_pressed("LeftClick") or Input.is_action_just_pressed("shift"):
		sword_swing_state = !sword_swing_state
		$SwordAttack/CollisionShape2D.disabled = false
		if self.position.x == 78:
			$SwordPlayer.play("AttackRight")
		elif self.position.x <= -61:
			$SwordPlayer.play("AttackLeft")
		await $SwordPlayer.animation_finished
		sword_swing_state = !sword_swing_state
		$SwordAttack/CollisionShape2D.disabled = true
		sword_idle()
	
func sword_idle():
	if self.position.x == 78 and animation_finished:
			$SwordPlayer.play("IdleRight")
	elif self.position.x == -61 and animation_finished:
		$SwordPlayer.play("IdleLeft")

	
		
		

