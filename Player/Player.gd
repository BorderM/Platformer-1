extends CharacterBody2D

class_name Player

const SAVE_PATH = "res://savegame.bin"
#var utils_ref : Utils = preload("res://Global/Utils.gd").new()

var node_ready = Signal()
var player_data = {
	"playerHP": 10,
	"gold": 0,
	#"player_pos": $Player.global_position,
	"player_max_hp": 10,
	"player_level": 1,
	"player_total_xp": 0,
	"player_current_xp": 0,
	"player_power": 1,
}
var xp_to_level = get_xp_to_level(player_data["player_level"] + 1)
var is_climbing = false
#var rng = RandomNumberGenerator.new()
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var health_bar = $HealthBar
@onready var anim = get_node("AnimationPlayer")	
var mouse_position = null

	
func _ready():
	if FileAccess.file_exists(SAVE_PATH) == true and Game.load == true:
		Utils.loadGame($Player)
	health_bar.init_health(player_data["playerHP"])
		
	
func _physics_process(delta):
	mouse_position = get_global_mouse_position()
	_set_health(player_data["playerHP"])
	health_bar.max_value = player_data["player_max_hp"]
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
	var character_facing = (mouse_position.x - self.position.x)
	if character_facing <= -1:
		get_node("AnimatedSprite2D").flip_h = true
		get_node("Sword").flip_h = true
		$Sword.position.x = -10
	elif character_facing >= 1:
		get_node("AnimatedSprite2D").flip_h = false
		get_node("Sword").flip_h = false
		$Sword.position.x = 28
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and velocity.x == 0:
			anim.play("Idle")
	if velocity.y > 0:
		anim.play("Fall")
		
	move_and_slide()
	
	
	
	
	if player_data["playerHP"] <= 0:
		anim.play("Death")
		#queue_free()
		get_tree().change_scene_to_file("res://game_over.tscn")
		get_node("../../Mobs/MobTimer").stop()
		get_node("../../Coll/CherryTimer").stop()
		DirAccess.remove_absolute(SAVE_PATH)
	
	if is_climbing == true:
		if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("up")):
			$Sword.hide()
			velocity.x = 0
			velocity.y = -200
			anim.play("Climb")
		if $AnimatedSprite2D.animation != "Climb":
			$Sword.show()
	else:
		_on_climb_finished()
		$Sword.show()	

func _on_climb_finished():
	is_climbing = false

	

func get_xp_to_level(player_level):
	return round(pow(player_level, 2) + player_level * 4)
	
func gain_experience(amount):
	player_data["player_current_xp"] += amount
	player_data["player_total_xp"] += amount
	var growth_data = []
	while player_data["player_current_xp"] >= xp_to_level:
		player_data["player_current_xp"] = 0
		growth_data.append([xp_to_level, xp_to_level])
		level_up()	
	growth_data.append([player_data["player_current_xp"], get_xp_to_level(player_data["player_level"] + 1)])
	
func level_up():
	player_data["player_level"] += 1
	xp_to_level = get_xp_to_level(player_data["player_level"] + 1)
	player_data["player_max_hp"] += 3
	health_bar.max_value = player_data["player_max_hp"]
	

func new_game():
	player_data = {
	"playerHP": 10,
	"gold": 0,
	#"player_pos": $Player.global_position,
	"player_max_hp": 10,
	"player_level": 1,
	"player_total_xp": 0,
	"player_current_xp": 0,
	"player_power": 1,
}
	xp_to_level = get_xp_to_level(player_data["player_level"] + 1)

func _take_damage(value):
	player_data["playerHP"] -= value
	_set_health(player_data["playerHP"])
	
func _gain_health(value):
	player_data["playerHP"] += value
	_set_health(player_data["playerHP"])
	
func _set_health(value):
	health_bar.health = player_data["playerHP"]
	
	



