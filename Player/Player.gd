extends CharacterBody2D

class_name Player



const SAVE_PATH = "res://savegame.bin"
#var utils_ref : Utils = preload("res://Global/Utils.gd").new()
var node_ready = Signal()
var player
var playerHP = 10
var gold = 0
var player_pos = Vector2()
var player_max_hp = 10
var player_level = 1
var xp_to_level = get_xp_to_level(player_level + 1)
var player_total_xp = 0
var player_current_xp = 0
var player_power = 1
var is_climbing = false
var randintx
var randinty
var rng = RandomNumberGenerator.new()
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")	
	
func _ready():
	if FileAccess.file_exists(SAVE_PATH) == true and Game.load == true and playerHP > 0:
		loadGame()
	
	
func _physics_process(delta):
	health_bar()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	floor_snap_length = 32	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")

	move_and_slide()
	
	player_pos = get_global_position()
	
	if playerHP <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://game_over.tscn")
		get_node("../../Mobs/MobTimer").stop()
		get_node("../../Coll/CherryTimer").stop()
		DirAccess.remove_absolute(SAVE_PATH)
	
	if is_climbing == true:
		if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("up")):
			velocity.x = 0
			velocity.y = -200
			anim.play("Climb")
	else:
		_on_climb_finished()

func _on_climb_finished():
	is_climbing = false
	

func get_xp_to_level(player_level):
	return round(pow(player_level, 2) + player_level * 4)
	
func gain_experience(amount):
	player_current_xp += amount
	player_total_xp += amount
	var growth_data = []
	while player_current_xp >= xp_to_level:
		player_current_xp = 0
		growth_data.append([xp_to_level, xp_to_level])
		level_up()	
	
	growth_data.append([player_current_xp, get_xp_to_level(player_level + 1)])
	#emit_signal("experience_gained", growth_data)
	
func level_up():
	player_level += 1
	xp_to_level = get_xp_to_level(player_level + 1)
	player_max_hp += 3
	

func new_game():
	playerHP = 10
	gold = 0
	player_pos = Vector2()
	player_max_hp = 10
	player_level = 1
	xp_to_level = get_xp_to_level(player_level + 1)
	player_total_xp = 0
	player_current_xp = 0
	player_power = 1

func health_bar():
	$"HealthBar".value = playerHP
	$"HealthBar".max_value = player_max_hp

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				playerHP = current_line["playerHP"]
				gold = current_line["gold"]
				player_pos = current_line["playerPos"]
				player_current_xp = current_line["player_current_xp"]
				player_level = current_line["player_level"]
				player_total_xp = current_line["player_total_xp"]
				player_max_hp = current_line["player_max_hp"]
