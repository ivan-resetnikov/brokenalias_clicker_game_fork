class_name UpgradesColumn
extends Control


@onready var upgrades_column_popup: UpgradesColumn_Popup = $UpgradesColumnPopup
@onready var upgrades_container: VBoxContainer = $VBoxContainer


var is_mouse_hovering_upgrade: bool = false
var hovered_upgrade: UpgradesColumn_Upgrade = null


func _ready() -> void:
	upgrades_column_popup.modulate.a = 0.0 # Hide popup


func _process(delta: float) -> void:
	handle_popup(delta)


func handle_popup(delta: float) -> void:
	# Check every frame if mouse is hovering over any upgrade
	is_mouse_hovering_upgrade = false
	hovered_upgrade = null
	for child: Node in upgrades_container.get_children():
		if not child is UpgradesColumn_Upgrade: continue
		var candidate_upgrade := child as UpgradesColumn_Upgrade
		
		var is_mouse_over_upgrade: bool = \
			candidate_upgrade.get_global_rect().has_point(get_global_mouse_position())
		
		if is_mouse_over_upgrade:
			is_mouse_hovering_upgrade = true
			hovered_upgrade = candidate_upgrade
			break
	
	if is_mouse_hovering_upgrade:
		# Set displayed info
		upgrades_column_popup.set_info(
			hovered_upgrade.title,
			hovered_upgrade.price,
			hovered_upgrade.description,
		)
		
		var target_y_pos: float = hovered_upgrade.global_position.y + hovered_upgrade.size.y * 0.5
		
		# Snap the popup's vertical position to the hovered popup
		upgrades_column_popup.global_position.y = lerpf(
			upgrades_column_popup.global_position.y,
			target_y_pos,
			40.0 * delta
		)
		
		# Polish > Jiggle-physics: Tilt the popup to the target
		upgrades_column_popup.rotation  = lerpf(
			upgrades_column_popup.rotation,
			(target_y_pos - upgrades_column_popup.global_position.y) * 0.001,
			30.0 * delta
		)
	
	# Polish: Fade the popup in or out depending if the mouse is hovering over upgrades
	upgrades_column_popup.modulate.a = lerpf(
		upgrades_column_popup.modulate.a,
		1.0 if is_mouse_hovering_upgrade else 0.0,
		30.0 * delta
	)
	upgrades_column_popup.position.x  = lerpf(
		upgrades_column_popup.position.x,
		0.0 if is_mouse_hovering_upgrade else -20.0,
		30.0 * delta
	)
