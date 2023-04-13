# Changes scenes after fading the screen on `any key` or on the A/B/cross
# buttons on a gamepad.
extends Control

const FADE_IN_TIME := 0.5
const FADE_OUT_TIME := 2.5

@onready var screen_fader: TextureRect = $FadeLayer/ScreenFader
@onready var main_screen := $Background/MainScreen

@onready var menu_sounds: MenuSoundPlayer = $MenuSoundPlayer

func _ready() -> void:
	screen_fader.fade_in()


func _unhandled_input(event: InputEvent) -> void:
	if screen_fader.is_playing:
		return
	if event is InputEventKey or event.is_action_pressed("thrust_forwards"):
		main_screen.animator.play_backwards("intro")
		menu_sounds.play_confirm()
		screen_fader.fade_out()
		await screen_fader.animation_finished
		get_tree().change_scene_to_file("res://Main/Game.tscn")
