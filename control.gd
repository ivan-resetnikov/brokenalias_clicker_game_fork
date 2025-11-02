extends Control


@onready var button: TextureButton = $TextureButton
@onready var scorelabel: Label = $Label
var cash = 0
var cashPerSec = 1

func save_game():
	var file = FileAccess.open("user://save_game.dat", FileAccess.WRITE)
	file.store_line(str(cash))
	file.close()

func load_game():
	if FileAccess.file_exists("user:///save_game.dat"):
		var file = FileAccess.open("user:///save_game.dat", FileAccess.READ)
		var saved_score = file.get_line()
		cash = int(saved_score)
		scorelabel.text = saved_score
		file.close()
 
func _ready() -> void:
	load_game()

	
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()


func _on_texture_button_pressed() -> void:
	cash += 1
	scorelabel.text = str(cash)


func _on_timer_timeout() -> void:
	cash += cashPerSec
	scorelabel.text = str(cash)
