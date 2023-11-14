extends Node2D

# Declare properties
@export var player_spaceship_path: NodePath
@export var shooting_animation: String
@export var animated_sprite: AnimatedSprite2D
@onready var spaceship = get_node(player_spaceship_path)

var shooting: bool = false
var shooting_cooldown = 0

func _ready():
	# Get the AnimatedSprite node
	animated_sprite = $AnimatedSprite2D

func _on_equipment_shoot(_direction, _location):
	shooting = true
	shooting_cooldown = 3


# control de joystick
func get_joystick_position():
	var vectorjoystick : Vector2 = Input.get_vector("joyx-", "joyx+", "joyy+", "joyy-")
	return vectorjoystick

# legacy usaba eso
# @export var is_joystick: bool = true
var last_joystick = Vector2(0,0)
@export var dead_zone = 0.1
func _process(_delta):
	# sigue al mouse
	#if is_joystick:
	if Input.get_connected_joypads().size() != 0:
	#if Input.is_joy_known(Input.get_connected_joypads()[0]):
		if get_joystick_position().length_squared() > dead_zone:
			last_joystick = get_joystick_position()
			global_position = spaceship.global_position +  100 * last_joystick
		else: 
			global_position = spaceship.global_position + 40 * last_joystick
	else:
		global_position = get_global_mouse_position()
	
	if shooting and (shooting_cooldown > 0):
		animated_sprite.play(shooting_animation)
		shooting_cooldown -= 1
	else:
		animated_sprite.stop()
		



func _on_player_free_crosshair():
	pass # Replace with function body.
