extends StarState
class_name TipoG # Cambia el nombre del estado según corresponda

# Propiedades específicas para TipoGas
@export var masa := 1 #masasolares
@export var temperatura := 5700 #kelvin
@export var abundancia := 3.5 #porcentaje
@export var tiempo_vide := 10000 # millon de años


#@onready var collision : CollisionShape2D = $CollisionShape2D

@onready var collision_shape = preload("res://Nodes/Star/collision_G.tres")

func Enter():
	healthcomponent.collision.shape = collision_shape
	animacion.play("G")
