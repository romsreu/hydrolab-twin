class_name ToggleButton
extends Button

@export var is_on: bool = true:
	set(value):
		is_on = value
		if is_node_ready():
			_update_style()

var _style_on: StyleBox
var _style_off: StyleBox


func _ready() -> void:
	button_pressed = is_on
	focus_mode = Control.FOCUS_NONE
	# Guardar los estilos originales del editor ANTES de cualquier override
	_style_on  = get_theme_stylebox("normal").duplicate()
	_style_off = get_theme_stylebox("normal_mirrored").duplicate()
	_update_style()


func set_state(state: bool) -> void:
	is_on = state


func _update_style() -> void:
	text = "ON" if is_on else "OFF"
	var style := _style_on if is_on else _style_off
	add_theme_stylebox_override("normal",  style)
	add_theme_stylebox_override("hover",   style)
	add_theme_stylebox_override("pressed", style)
	add_theme_stylebox_override("focus",   StyleBoxEmpty.new())


func _on_toggled(toggled_on: bool) -> void:
	is_on = toggled_on
