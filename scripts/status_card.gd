class_name StatusCard
extends Panel

signal toggled(card_name: String, is_on: bool)

@export var card_label: String = "CATEGORÍA": #Ventiladores, luces, bombas
	set(value):
		card_label = value
		if is_node_ready():
			category_label.text = value

@export var specific_label_text: String = "ESPECIFICIDAD": #Cuál es de todas
	set(value):
		specific_label_text = value
		if is_node_ready():
			specific_label.text = value

#@export var icon_texture: Texture2D:
	#set(value):
		#icon_texture = value
		#if is_node_ready():
			#icon.texture = value

@onready var icon: TextureRect = $Icon
@onready var category_label: Label = $Icon/CategoryLabel
@onready var specific_label: Label = $Icon/CategoryLabel/SpecificLabel
@onready var toggle_button: ToggleButton = $ToggleButton

const COLOR_TEXT    := Color("#ffffff")
const COLOR_SUBTEXT := Color("#888888")
const COLOR_SHADOW_ON  := Color("#85da8c99")
const COLOR_SHADOW_OFF := Color("#e5393599")


func _ready() -> void:
	category_label.text = card_label
	specific_label.text = specific_label_text
	#icon.texture        = icon_texture
	_update_shadow(toggle_button.is_on)


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	toggled.emit(card_label, toggled_on)
	_update_shadow(toggled_on)


func _update_shadow(is_on: bool) -> void:
	var style := get_theme_stylebox("panel").duplicate()
	style.shadow_color = COLOR_SHADOW_ON if is_on else COLOR_SHADOW_OFF
	add_theme_stylebox_override("panel", style)
