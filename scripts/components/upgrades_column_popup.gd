class_name UpgradesColumn_Popup
extends Control


@onready var label_title: Label = $MarginContainer/HBoxContainer/Header/Title
@onready var label_price: Label = $MarginContainer/HBoxContainer/Header/Price
@onready var label_description: Label = $MarginContainer/HBoxContainer/Description


func set_info(
	title: String,
	price: int,
	description: String,
) -> void:
	label_title.text = title
	label_price.text = "$%s" % [price]
	label_description.text = description
