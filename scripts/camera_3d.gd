extends Camera3D

@export var zoom_speed: float = 1.0
@export var min_fov: float = 20.0
@export var max_fov: float = 90.0
@export var zoom_tween_duration: float = 0.2

var zoom_tween: Tween

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_tween_zoom(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_tween_zoom(zoom_speed)

func _tween_zoom(delta_fov: float):
	var target_fov = clamp(fov + delta_fov, min_fov, max_fov)
	if zoom_tween:
		zoom_tween.kill()
	zoom_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	zoom_tween.tween_property(self, "fov", target_fov, zoom_tween_duration)
