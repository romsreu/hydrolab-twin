extends Node3D

@onready var camera_3d: Camera3D = $Camera3D

# — Zoom —
@export var zoom_speed: float = 1.0
@export var min_fov: float = 20.0
@export var max_fov: float = 90.0
@export var zoom_tween_duration: float = 0.2
@export var pinch_zoom_speed: float = 0.1

# — Órbita —
@export var orbit_speed: float = 0.3

var zoom_tween: Tween
var is_dragging: bool = false
var last_touch_positions: Dictionary = {}
var last_pinch_distance: float = 0.0

func _ready():
	# La cámara ya apunta al origen desde el editor; no hace falta look_at aquí.
	pass

func _input(event):
	# — Desktop: zoom con rueda —
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_tween_zoom(-zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_tween_zoom(zoom_speed)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			is_dragging = event.pressed

	# — Desktop: órbita con click derecho —
	if event is InputEventMouseMotion and is_dragging:
		_orbit(event.relative.x, event.relative.y)

	# — Mobile: touch —
	if event is InputEventScreenTouch:
		if event.pressed:
			last_touch_positions[event.index] = event.position
		else:
			last_touch_positions.erase(event.index)
			last_pinch_distance = 0.0

	if event is InputEventScreenDrag:
		last_touch_positions[event.index] = event.position
		if last_touch_positions.size() == 1:
			_orbit(event.relative.x, event.relative.y)
		elif last_touch_positions.size() == 2:
			var positions = last_touch_positions.values()
			var current_distance = positions[0].distance_to(positions[1])
			if last_pinch_distance > 0.0:
				var delta = current_distance - last_pinch_distance
				_tween_zoom(-delta * pinch_zoom_speed)
			last_pinch_distance = current_distance

func _orbit(dx: float, dy: float):
	# Yaw: rotar el Node3D sobre el eje Y global
	rotate_y(deg_to_rad(-dx * orbit_speed))
	# Pitch: rotar sobre el eje X local del Node3D
	rotate_object_local(Vector3.RIGHT, deg_to_rad(-dy * orbit_speed))

func _tween_zoom(delta_fov: float):
	var target_fov = clamp(camera_3d.fov + delta_fov, min_fov, max_fov)
	if zoom_tween:
		zoom_tween.kill()
	zoom_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	zoom_tween.tween_property(camera_3d, "fov", target_fov, zoom_tween_duration)
