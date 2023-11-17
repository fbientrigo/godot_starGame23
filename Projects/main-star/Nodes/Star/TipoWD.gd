extends StarState
class_name TipoWD
# tipo WhiteDwarf

# Propiedades específicas para TipoWhiteDwarf
@export var masa := 1.4 #masas solares
@export var temperatura := 70000 #kelvin
@export var abundancia := 5 #porcentaje
@export var tiempo_vida := 99999 # millón de años

@onready var collision_shape = preload("res://Nodes/Star/collision_WD.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("WhiteDwarf")
	# cambiarla por una enana negra
