extends StarState
class_name TipoF

# Propiedades específicas para TipoF
@export var masa := 1.5 #masas solares
@export var temperatura := 6500 #kelvin
@export var abundancia := 2 #porcentaje
@export var tiempo_vida := 3000 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_F.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("F")
