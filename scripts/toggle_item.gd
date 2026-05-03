extends Button

@export var label_text: String = "Item":
	set(value):
		label_text = value
		if is_node_ready():
			$TypeLabel.text = value

@onready var state_label: Label = $State

func _ready():
	$TypeLabel.text = label_text


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		state_label.text = "ON"
		state_label.add_theme_color_override("font_color", Color.GREEN)
	else:
		state_label.text = "OFF"
		state_label.add_theme_color_override("font_color", Color.RED)
