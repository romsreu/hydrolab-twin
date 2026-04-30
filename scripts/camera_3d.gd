extends Camera3D

@export var target: Node3D
@export var orbit_speed: float = 0.5
@export var zoom_speed: float = 1.0
@export var min_distance: float = 1.0
@export var max_distance: float = 10.0

var distance: float = 5.0
var yaw: float = 0.0
var pitch: float = 20.0
var is_dragging: bool = false

func _ready():
	# distancia inicial desde el target
	distance = global_position.distance_to(target.global_position)

func _input(event):
	# drag
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_dragging = event.pressed

	if event is InputEventMouseMotion and is_dragging:
		yaw -= event.relative.x * orbit_speed
		pitch -= event.relative.y * orbit_speed
		pitch = clamp(pitch, -80, 80)

	# zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			distance = clamp(distance - zoom_speed, min_distance, max_distance)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			distance = clamp(distance + zoom_speed, min_distance, max_distance)

func _process(delta):
	if not target:
		return
	var offset = Vector3(
		sin(deg_to_rad(yaw)) * cos(deg_to_rad(pitch)),
		sin(deg_to_rad(pitch)),
		cos(deg_to_rad(yaw)) * cos(deg_to_rad(pitch))
	) * distance
	global_position = target.global_position + offset
	look_at(target.global_position)
