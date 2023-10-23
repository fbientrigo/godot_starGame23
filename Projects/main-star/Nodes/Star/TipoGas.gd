extends StarState
class_name TipoGas
# tipo WhiteDwarf

# Propiedades específicas para TipoWhiteDwarf
@export var masa := 0 #masas solares
@export var temperatura := 0 #kelvin
@export var abundancia := 0 #porcentaje
@export var tiempo_vida := 99999 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_WD.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("WhiteDwarf")
