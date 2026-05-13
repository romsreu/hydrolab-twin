extends Control

@onready var screens := {
	"visualization": $MenuPanel/Visualization,
	"config": $MenuPanel/Configuration,
}

@onready var buttons := {
	"visualization": $BottomNav/VisualizationButton,
	"config": $BottomNav/ConfigButton,
	"dashboard": $BottomNav/DashboardButton,
}

var current := ""

func _ready() -> void:
	for key in buttons:
		buttons[key].pivot_offset = buttons[key].size / 2.0
	_nav_to("visualization")

func _nav_to(name: String) -> void:
	if name == current or not screens.has(name):
		return
	for key in screens:
		screens[key].visible = (key == name)
	for key in buttons:
		_tween_btn(buttons[key], key == name)
	current = name

func _tween_btn(btn: Control, active: bool) -> void:
	var tw := create_tween()
	tw.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tw.tween_property(btn, "scale", Vector2(1.2, 1.2) if active else Vector2.ONE, 0.2)

func _on_config_button_pressed() -> void:
	_nav_to("config")

func _on_visualization_button_pressed() -> void:
	_nav_to("visualization")

func _on_dashboard_button_pressed() -> void:
	_nav_to("dashboard")
