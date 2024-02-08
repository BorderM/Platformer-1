extends CharacterBody2D

class_name frogBody

var hasBeenHit: bool = false
var frogHP = 1
var speed = 100
var player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var facing_right = false

	#get_node("AnimatedSprite2D").play("Jump")
	#velocity.x = speed * -1
	#velocity.x = 0
	#get_node("AnimatedSprite2D").play("Idle")		
func _ready():
	get_node("AnimatedSprite2D").play("Jump")	
	
func _on_player_ready():
	start_chasing()
	
func start_chasing():
	if is_instance_valid(player):
		chase = true
	
func _physics_process(delta):
	#sets gravity of frog
	velocity.y += gravity * delta

	if get_node("AnimatedSprite2D").animation != "Death":
			#get_node("AnimatedSprite2D").play("Jump")
		if (!$GroundDetect.is_colliding() or $WallDetect.is_colliding()) and is_on_floor():
			if facing_right == false:
				facing_right = true
				scale.x = abs(scale.x) * -1
				#get_node("AnimatedSprite2D").flip_h = true
				velocity.x = speed 
			elif facing_right == true:
				facing_right = false
				scale.x = abs(scale.x) * -1
				#get_node("AnimatedSprite2D").flip_h = false
				velocity.x = speed * -1
		elif chase == true:
			#if get_node("AnimatedSprite2D").animation != "Death":
			#get_node("AnimatedSprite2D").play("Jump")
			player = get_node("../../Player/Player")
			var direction = (player.position - self.position).normalized()
			if direction.x > 0:
				facing_right = true
				scale.x = abs(scale.x) * -1
				velocity.x = direction.x * speed
			elif direction.x < 0:
				facing_right = false
				scale.x = abs(scale.x) * -1
				#flip()
					#get_node("AnimatedSprite2D").flip_h = false
				velocity.x = direction.x * speed
		#velocity.x = direction.x * speed
		else:
			if facing_right == true:
				scale.x = abs(scale.x) * -1
				velocity.x = speed
			elif facing_right == false:
				scale.x = abs(scale.x) * -1
				velocity.x = speed * -1

	
		
		#velocity.x = speed
	
	move_and_slide()#position.x * speed

	#if the raycast is hitting nothing and the frog is on the floor flip facing side
	
		
		
func _on_mob_head_body_entered(body):
	if body.name == "Player":
		frog_take_damage()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player = body
		call_deferred("start_chasing")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_collision_body_entered(body):
	if body.name == "Player" and hasBeenHit == false:
		hasBeenHit = true
		Game.playerHP -= 3
		frog_take_damage()
		
func frog_take_damage():
	frogHP -= Game.player_power
	if frogHP <= 0:
		frog_death()
			

func frog_death():
	Game.gold += 5
	Game.gain_experience(1)
	chase = false
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()

func flip():
	facing_right = !facing_right
	
	
	if facing_right == true:
		speed = speed
	else:
		speed = speed * -1


