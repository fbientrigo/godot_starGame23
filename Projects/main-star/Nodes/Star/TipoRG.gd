extends StarState
class_name TipoGiganteRoja

# Propiedades específicas para TipoGiganteRoja
@export var masa := 500 #masas solares
@export var temperatura := 40000 #kelvin
@export var abundancia := 0.0001 #porcentaje
@export var tiempo_vida := 10 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_GiganteRojaK.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("GiganteRojaK")
