class_name SensorCard
extends Panel

@export var category_label_text: String = "HUMEDAD":
	set(value):
		category_label_text = value
		if is_node_ready():
			category_label.text = value

@export var specific_label_text: String = "":
	set(value):
		specific_label_text = value
		if is_node_ready():
			specific_label.text = value

@export var unidad: String = "%":
	set(value):
		unidad = value
		if is_node_ready():
			unidad_label.text = value

@export var icon_texture: Texture2D:
	set(value):
		icon_texture = value
		if is_node_ready():
			card_icon.texture = value

@export var valor: float = 0.0:
	set(value):
		valor = value
		if is_node_ready():
			_update_valor()

@export var decimales: int = 1:
	set(value):
		decimales = value
		if is_node_ready():
			_update_valor()

@onready var card_icon: TextureRect = $CardIcon
@onready var category_label: Label = $CardIcon/CategoryLabel
@onready var specific_label: Label = $CardIcon/CategoryLabel/SpecificLabel
@onready var numero_label: Label = $NumeroLabel
@onready var unidad_label: Label = $NumeroLabel/UnidadLabel

const COLOR_TEXT    := Color("#ffffff")
const COLOR_SUBTEXT := Color("#888888")
const COLOR_ICON    := Color(0.565, 1.0, 0.565, 1.0)


func _ready() -> void:
	card_icon.texture       = icon_texture
	card_icon.self_modulate = COLOR_ICON
	category_label.text     = category_label_text
	specific_label.text     = specific_label_text
	unidad_label.text       = unidad
	_update_valor()

	category_label.add_theme_color_override("font_color", COLOR_TEXT)
	specific_label.add_theme_color_override("font_color", COLOR_SUBTEXT)
	unidad_label.add_theme_color_override("font_color", COLOR_SUBTEXT)
	numero_label.add_theme_color_override("font_color", COLOR_TEXT)


func set_valor(nuevo: float) -> void:
	valor = nuevo


func _update_valor() -> void:
	numero_label.text = String.num(valor, decimales)
