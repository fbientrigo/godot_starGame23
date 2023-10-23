# codigo de equipamiento
# tiene los objetivos de emitir señales
# indicando que bala a disparar (click izquierdo)
# que truster se tiene (espacio)
# y de entregar las señales pertinentes

# tambien se encarga de tener un Area2D donde hace contacto con items



extends Node2D

signal engine_state_changed(old_value, new_value)


# Define the engine states
enum EngineStates {
	IDLE,
	BASE_THRUST,
	SUPER_THRUST,
	MACHINE_GUN,
	GRAV_GUN,
	PICKAXE_GUN,
	LASER_GUN,
	TP_GUN,
	EXTRA
}

# se usa para conectar con otros elementos
@export var spaceship_1_path: NodePath
@export var engine_anim_path: NodePath
# @export var bullet_path: NodePath

# importar aqui otros tipos de disparos que se implementen


@onready var spaceship_1 = get_node(spaceship_1_path)
@onready var engine_anim = get_node(engine_anim_path)
# @onready var bullet = get_node(bullet_path)

# ======== Sección de Engine
# Estado default de engine
var current_engine_state = EngineStates.IDLE

func _ready():
	pass


func change_engine_state():
	if Input.is_action_just_pressed("i"):
		var _old_state = current_engine_state
		current_engine_state = EngineStates.BASE_THRUST
		engine_state_changed.emit()
		print("")


# ======= Sección de armas
# se define la signal
signal shoot(_rotation, _position)



# Sección de control
func _process(_delta):
	if Input.is_action_pressed("w"):
		# se reproducirá en base al Engine equipado
		# las animaciones tienen acceso a todos los nombres
		engine_anim.play("base_engine_idle")
	else:
		engine_anim.stop()


	if Input.is_action_pressed("click"):
		emit_signal("shoot",  global_rotation, global_position)
		
	
