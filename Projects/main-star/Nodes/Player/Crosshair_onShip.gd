extends Node2D

# Declare properties
@export var player_spaceship: NodePath
@export var shooting_animation: String
@export var animated_sprite: AnimatedSprite2D

var shooting: bool = false
var shooting_cooldown = 0

func _ready():
	# Get the AnimatedSprite node
	animated_sprite = $AnimatedSprite2D

func _on_equipment_shoot(_direction, _location):
	shooting = true
	shooting_cooldown = 3

	
func _process(_delta):

	# sigue al mouse
	global_position = get_global_mouse_position()
	
	if shooting and (shooting_cooldown > 0):
		animated_sprite.play(shooting_animation)
		shooting_cooldown -= 1
	else:
		animated_sprite.stop()
		

