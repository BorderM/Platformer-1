extends CharacterBody2D

class_name frogBody

enum direction {left, right}

var hasBeenHit: bool = false
@export var frogHP = 1
var frogMaxHP = 1
var speed = 100
var player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var facing_dir = direction.left
var rand_gen = RandomNumberGenerator.new()
const JUMP_VELOCITY = -350.0
var given_rewards = false
@onready var healthbar = $HealthBar
signal sword_in_frog

	
func _ready():
	#healthbar.init_health(frogHP)
	healthbar.health = frogHP
	healthbar.max_value = frogMaxHP
	rand_gen.randomize()
	if rand_gen.randf_range(-1, 1) < 0: 
		velocity.x = speed * -1
	else:
		velocity.x = speed
	$AnimatedSprite2D.play("Jump")	
	
func _on_player_ready():
	start_chasing()
	
func start_chasing():
	if is_instance_valid(player):
		chase = true
	
func _physics_process(delta):
	#sets gravity of frog
	velocity.y += gravity * delta
	if frogHP <= 0:
		frogHP = 0
		frog_death()
	
	if $AnimatedSprite2D.animation != "Death":
			#if the raycast is hitting nothing or a wall and the frog is on the floor flip facing side
		if chase == true:
			if !$GroundDetect.is_colliding() and is_on_floor():
				$WallDetect.enabled = false
				velocity.y = JUMP_VELOCITY
				player = get_node("../../../Player/Player")
				var direction = (player.position - self.position).normalized()
				velocity.x = direction.x * speed
			else: 
				$WallDetect.enabled = false
				player = get_node("../../../Player/Player")
				var direction = (player.position - self.position).normalized()
				velocity.x = direction.x * speed
			$WallDetect.enabled = true	
		elif (!$GroundDetect.is_colliding() or $WallDetect.is_colliding()) and is_on_floor():
			if velocity.x <= 0:
				velocity.x = speed
			elif velocity.x >= 0:
				velocity.x = -speed
		else:
			if velocity.x <= 0:
				velocity.x = -speed
			elif velocity.x >= 0:
				velocity.x = speed
				
		
	
	if velocity.x < 0:
		if facing_dir != direction.left:
			facing_dir = direction.left
			change_dir()
			
	elif velocity.x > 0:
		if facing_dir != direction.right:
			facing_dir = direction.right
			change_dir()
			

	
	move_and_slide()


func change_dir():
	$AnimatedSprite2D.flip_h = true if facing_dir == direction.right else false
	$WallDetect.position.x = 13 if facing_dir == direction.right else -13
	$WallDetect.target_position.x = 7 if facing_dir == direction.right else -7
	$GroundDetect.position.x = 16 if facing_dir == direction.right else -16
	$PlayerDetection/CollisionPolygon2D.position.x = 87.5 if facing_dir == direction.right else -87.5
	$PlayerDetection/CollisionPolygon2D.scale.x = -3.361 if facing_dir == direction.right else 3.361
		

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
		$"../../../Player/Player"._take_damage(3)
		frog_take_damage()
		
func frog_take_damage():
	frogHP -= get_node("../../../Player/Player").player_data["player_power"]
	_set_health(frogHP)
	
			

func frog_death():
	$HealthBar.hide()
	chase = false
	velocity.x = 0
	$MobBody/SwordCollision.disabled = true
	$MobSides/CollisionShape2D.disabled = true
	if not given_rewards:
		given_rewards = true
		get_node("../../../Player/Player").player_data["gold"] += 3
		get_node("../../../Player/Player").gain_experience(3)
		$AnimatedSprite2D.play("Death")
		await $AnimatedSprite2D.animation_finished
		self.queue_free()
	
func _on_animation_finished():
	self.queue_free()	
	
func _set_health(value):
	healthbar.value = frogHP
	healthbar.max_value = frogMaxHP

func _on_mob_body_area_entered(area):
	if area.name == "SmallSword":
		if get_node("../../../Player/Player/SmallSword").sword_swing_state == true:
			frog_take_damage()
		
func _on_mob_bottom_body_entered(body):
	if body.name == "frogBody":
		velocity.y = -200
		velocity.x = randi_range(100, -100)
