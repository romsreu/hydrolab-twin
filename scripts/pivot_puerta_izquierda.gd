extends Node3D

@export var door_open_degree: float =  -84+180
@export var door_closed_degree: float = 19
@export var duration: float = 0.5

var is_open: bool = false
var tween: Tween

func _open_door() -> void:
	var target = deg_to_rad(door_open_degree if !is_open else door_closed_degree)
	is_open = !is_open
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "rotation:x", target, duration)\
		.set_ease(Tween.EASE_IN_OUT)\
		.set_trans(Tween.TRANS_CUBIC)



func _on_input_puerta_izquierda_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_open_door()
