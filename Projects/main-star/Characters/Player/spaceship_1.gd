extends RigidBody2D

@export var velocidad_nave : float = 300

@export var animation_damage_sprites: NodePath
@onready var _animated_sprite = get_node(animation_damage_sprites)

func _ready():
	print("Hello world")

func _on_EngineState_Changed(oldstate, newstate):
	# controla el cambio de señales para dar aviso al padre
	# print(oldstate)
	# print(newstate)
	pass
	



func get_input_actions():
	if Input.is_action_pressed("click"):
		pass
		# llamar funcion de disparo



# Seccion de fuerzas =======================================
@export var torque_strength: float
@export var propulsor_strength: float
func _integrate_forces(state):
	
	# sigue la posicion del mouse, y calcula el torque
	var mouse_position = get_global_mouse_position()
	var difference = mouse_position - global_position
	var angle_to_look = difference.angle_to(transform.y)
	if abs(abs(angle_to_look) - PI) > 0.1:
		# Calculate the torque to apply
		var torque = angle_to_look * torque_strength
		# Apply the torque to the spaceship
		apply_torque(torque)
	apply_force( - transform.y  * Input.get_action_strength("w") * propulsor_strength)
	
	


#func _physics_process(delta):
#	pass
	# get_input_actions()
	# get_input_velocity_and_rotation() 
	# rotation += rotation_direction * rotation_speed * delta
	# move_and_slide()

	
signal shoot_pass_from_equipment(bullet, direction, location)

func _on_equipment_shoot(bullet_, direction_, location_):
	emit_signal("shoot_pass_from_equipment", bullet_, direction_, location_)


