extends ProgressBar


@onready var timer = $Timer
@onready var damage_bar = $DamageBar


var health = 0 : set = _new_health

func _process(delta):
	damage_bar.max_value = max_value


func _new_health(new_health):
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health < prev_health:
		timer.start()
	elif health > prev_health:
		damage_bar.value = health

func init_health(_health):
	health = _health
	value = health
	damage_bar.value = health

func _on_timer_timeout():
	damage_bar.value = health
	
