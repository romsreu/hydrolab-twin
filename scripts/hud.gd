extends Control

@onready var panels = {
	"luces": $PanelContainer/LucesContainer,
	"ventiladores": $PanelContainer/VentiladoresContainer
}

var active: String = ""
var tween: Tween

func _ready():
	for panel in panels.values():
		panel.hide()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_H:
		visible = !visible

func toggle(id: String):
	if tween:
		tween.kill()

	if active == id:
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		t.tween_property(panels[id], "modulate:a", 0.0, 0.2)
		await t.finished
		panels[id].hide()
		active = ""
		return

	if active != "":
		var prev = panels[active]
		var t = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		t.tween_property(prev, "modulate:a", 0.0, 0.15)
		await t.finished
		prev.hide()

	active = id
	panels[id].modulate.a = 0.0
	panels[id].show()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(panels[id], "modulate:a", 1.0, 0.2)

func _on_luces_button_pressed():
	toggle("luces")

func _on_ventiladores_button_pressed() -> void:
	toggle("ventiladores")
