extends Panel

@onready var slides_container: ScrollContainer = $SlidesContainer
@onready var h_box_container: HBoxContainer = $SlidesContainer/HBoxContainer
@onready var dots_container: HBoxContainer = $DotsContainer
@onready var timer: Timer = $Timer

const AUTO_SCROLL_TIME := 5.0
const TWEEN_DURATION   := 0.4
const COLOR_DOT_ACTIVE   := Color("#4caf50")
const COLOR_DOT_INACTIVE := Color("#444444")
const DOT_SIZE := 10

var _slides: Array[TextureRect]
var _dots: Array[Panel]
var _current: int = 0
var _slide_width: float = 0.0
var _tween: Tween


func _ready() -> void:
	for child in h_box_container.get_children():
		if child is TextureRect:
			_slides.append(child)

	await get_tree().process_frame
	_slide_width = slides_container.size.x

	for slide in _slides:
		slide.custom_minimum_size.x = _slide_width

	_build_dots()

	timer.wait_time = AUTO_SCROLL_TIME
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	_go_to(0)


func _build_dots() -> void:
	for i in _slides.size():
		var dot := Panel.new()
		dot.custom_minimum_size = Vector2(DOT_SIZE, DOT_SIZE)
		dot.add_theme_stylebox_override("panel", _dot_style(COLOR_DOT_INACTIVE))
		dots_container.add_child(dot)
		_dots.append(dot)


func _dot_style(color: Color) -> StyleBoxFlat:
	var sb := StyleBoxFlat.new()
	sb.bg_color = color
	sb.set_corner_radius_all(DOT_SIZE / 2)  # circulo perfecto
	return sb


func _go_to(index: int) -> void:
	_current = index

	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	_tween.tween_property(slides_container, "scroll_horizontal", int(_slide_width * _current), TWEEN_DURATION)

	for i in _dots.size():
		var color := COLOR_DOT_ACTIVE if i == _current else COLOR_DOT_INACTIVE
		_dots[i].add_theme_stylebox_override("panel", _dot_style(color))


func _on_timer_timeout() -> void:
	_go_to((_current + 1) % _slides.size())
