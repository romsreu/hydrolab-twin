class_name NavBar
extends Panel

signal tab_changed(tab: String)
signal view_changed(view: String)

@onready var inicio_button: NavButton         = $HBoxContainer/InicioButton
@onready var virtualization_button: NavButton = $HBoxContainer/VirtualizationButton
@onready var historico_button: NavButton      = $HBoxContainer/HistoricoButton
@onready var configuracion_button: NavButton  = $HBoxContainer/ConfiguracionButton

var _buttons: Array[NavButton]
var _views: Dictionary  # NavButton -> nombre de vista


func _ready() -> void:
	_buttons = [inicio_button, virtualization_button, historico_button, configuracion_button]
	_views = {
		inicio_button:         "Dashboard",
		virtualization_button: "Virtualization",
		historico_button:      "Historico",
		configuracion_button:  "Configuracion",
	}
	for btn in _buttons:
		btn.nav_pressed.connect(_on_nav_pressed)
	_set_active(inicio_button)


func _on_nav_pressed(button: NavButton) -> void:
	_set_active(button)


func _set_active(active: NavButton) -> void:
	for btn in _buttons:
		btn.set_active(btn == active)
	tab_changed.emit(active.name)
	view_changed.emit(_views[active])
