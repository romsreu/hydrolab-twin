extends Control

@onready var view: Control = $View

const INICIO        = preload("uid://bggf4dc6n0of3")
const VISUALIZATION = preload("uid://b7mogwcny501y")

var _views: Dictionary


func _ready() -> void:
	_views = {
		"Dashboard":      INICIO.instantiate(),
		"Virtualization": VISUALIZATION.instantiate(),
	}

	for v in _views.values():
		v.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		v.visible = false
		view.add_child(v)

	_show_view("Dashboard")


func _show_view(view_name: String) -> void:
	for key in _views:
		_views[key].visible = (key == view_name)


func _on_bottom_navbar_view_changed(view: String) -> void:
	_show_view(view)


func _on_bottom_navbar_tab_changed(tab: String) -> void:
	pass
