extends Node3D

@export var orbit_speed: float = 0.3
@export var zoom_speed: float = 0.01
@export var min_zoom: float = 1.0
@export var max_zoom: float = 20.0

var is_dragging: bool = false
var last_touch_positions: Dictionary = {}
var last_pinch_distance: float = 0.0

func _input(event):
	# — Desktop (mouse) —
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		is_dragging = event.pressed
	if event is InputEventMouseMotion and is_dragging:
		rotate(Vector3.UP, deg_to_rad(event.relative.x * orbit_speed))
		rotate(transform.basis.x.normalized(), deg_to_rad(event.relative.y * orbit_speed))

	# — Mobile (touch) —
	if event is InputEventScreenTouch:
		if event.pressed:
			last_touch_positions[event.index] = event.position
		else:
			last_touch_positions.erase(event.index)
			last_pinch_distance = 0.0

	if event is InputEventScreenDrag:
		last_touch_positions[event.index] = event.position

		if last_touch_positions.size() == 1:
			# Un dedo → rotar
			rotate(Vector3.UP, deg_to_rad(event.relative.x * orbit_speed))
			rotate(transform.basis.x.normalized(), deg_to_rad(event.relative.y * orbit_speed))

		elif last_touch_positions.size() == 2:
			# Dos dedos → pinch zoom
			var positions = last_touch_positions.values()
			var current_distance = positions[0].distance_to(positions[1])

			if last_pinch_distance > 0.0:
				var delta = current_distance - last_pinch_distance
				_apply_zoom(-delta * zoom_speed)

			last_pinch_distance = current_distance

func _apply_zoom(amount: float):
	var forward = -transform.basis.z.normalized()
	var new_pos = position + forward * amount
	# Clamp por distancia al origen
	var dist = new_pos.length()
	if dist >= min_zoom and dist <= max_zoom:
		position = new_pos
