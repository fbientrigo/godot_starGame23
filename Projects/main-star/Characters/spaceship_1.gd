extends CharacterBody2D

@export var velocidad_nave : float = 300

@export var animation_damage_sprites: NodePath
@onready var _animated_sprite = get_node(animation_damage_sprites)

func _ready():
	print("Hello world")

func _on_EngineState_Changed(oldstate, newstate):
	# controla el cambio de señales para dar aviso al padre
	print(oldstate)
	print(newstate)
	

@export var rotation_speed = 6

var rotation_direction = 0

func get_input_actions():
	if Input.is_action_pressed("click"):
		pass
		# llamar funcion de disparo
		

#		_animated_sprite.frame += 1


func get_input_velocity_and_rotation():
	"""
	obtiene el input de W, S y la rotacion
	la define con el mouse
	"""
	# rotar controlando el mouse
	look_at(get_global_mouse_position())
	
	# direccion de rotacion con teclas
	# rotation_direction = Input.get_axis("a", "d")
	
	# velocidad controlada con W puede usarse Input.get_axis("s", "w")
	velocity = transform.y * (-1) * Input.get_action_strength("w") * velocidad_nave

func _physics_process(delta):
	get_input_actions()
	get_input_velocity_and_rotation() 
	# rotation += rotation_direction * rotation_speed * delta
	move_and_slide()

	
