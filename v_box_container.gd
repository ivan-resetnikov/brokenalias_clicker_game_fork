extends VBoxContainer

@onready var popup: TextureRect = $DescriptionPopup

func _ready() -> void:
	for child in get_children():
		if child is TextureButton:
			child.connect("mouse_entered", Callable(self, "_on_button_hovered").bind(child))
			child.connect("mouse_exited", Callable(self, "_on_button_exited").bind(child))



func _on_auto_clicker_mouse_entered(button: TextureButton) -> void:
	if button.has_meta("description"):
		popup.visible = true



func _on_auto_clicker_mouse_exited() -> void:
	popup.visible = false
