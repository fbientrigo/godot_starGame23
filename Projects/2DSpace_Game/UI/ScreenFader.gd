# Animates a black screen that covers the entire screen - keeps transitions
# from simply going menu-game or game-menu in an abrupt and jarring way.
extends TextureRect

signal animation_finished

@export var duration_fade_in := 0.5
@export var duration_fade_out := 2.5

var is_playing := false

@onready var tween := get_tree().create_tween()


func _ready() -> void:
	tween.connect("finished",Callable(self,"_on_Tween_tween_completed"))


# Animate from the current modulate color until the node is fully transparent.
func fade_in() -> void:
	tween.tween_property(
		self,
		"modulate",
		Color.TRANSPARENT,
		duration_fade_in
	)
	show()
	tween.start()
	is_playing = true


# Animate from the current modulate color until the node is fully black.
func fade_out(is_delayed: bool = false) -> void:
	tween.interpolate_property(
		self,
		"modulate",
		modulate,
		Color.WHITE,
		duration_fade_out,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT,
		duration_fade_out if is_delayed else 0.0
	)
	show()
	tween.start()
	is_playing = true


func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	emit_signal("animation_finished")
	if modulate == Color.TRANSPARENT:
		hide()
	is_playing = false
