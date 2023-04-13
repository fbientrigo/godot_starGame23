extends Node2D

# Declare properties
@export var player_spaceship: NodePath
@export var shooting_animation: String
@export var animated_sprite: AnimatedSprite2D

var shooting: bool = false

func _ready():
	# Get the AnimatedSprite node
	animated_sprite = $AnimatedSprite2D

func _on_equipment_shoot(bullet, direction, location):
	pass

	
func _process(_delta):
	# sigue al mouse
	global_position = get_global_mouse_position()
	
	if Input.is_action_pressed("click"):
		animated_sprite.play(shooting_animation)
	else:
		animated_sprite.stop()
