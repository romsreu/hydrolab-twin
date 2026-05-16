class_name NavButton
extends Button

signal nav_pressed(button: NavButton)
@onready var nav_icon: TextureRect = $NavIcon
@onready var label: Label = $NavIcon/Label

@export var label_text: String = "INICIO":
	set(value):
		label_text = value
		if is_node_ready():
			label.text = value

@export var icon_texture: Texture2D:
	set(value):
		icon_texture = value
		if is_node_ready():
			nav_icon.texture = value

@export var is_active: bool = false:
	set(value):
		is_active = value
		if is_node_ready():
			_update_style()



const COLOR_ACTIVE   := Color("#4caf50")
const COLOR_INACTIVE := Color("#888888")

func _ready() -> void:
	focus_mode = Control.FOCUS_NONE
	for state in ["normal", "hover", "pressed", "focus"]:
		add_theme_stylebox_override(state, StyleBoxEmpty.new())
	# Forzar los setters manualmente
	label.text       = label_text
	nav_icon.texture = icon_texture
	_update_style()

func set_active(value: bool) -> void:
	is_active = value

func _update_style() -> void:
	var color := COLOR_ACTIVE if is_active else COLOR_INACTIVE
	label.add_theme_color_override("font_color", color)
	nav_icon.modulate = color

func _on_pressed() -> void:
	nav_pressed.emit(self)
