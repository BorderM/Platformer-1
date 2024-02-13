extends ProgressBar

@export var player: Player

func _ready():
	health_bar()

func health_bar():
	value = player.playerHP
