extends Control

@onready var main : Main = get_node("../../../../..")
# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	main.connect("save_file_found", _save_file_found)

func _save_file_found(is_saved : bool):
	if is_saved == true:
		show()
	else:
		hide()
		
func _on_yes_pressed():
	Utils.start_game()

func _on_no_pressed():
	hide()




