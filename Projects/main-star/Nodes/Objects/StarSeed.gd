# Star Seed Interactable Object
extends State


@export var animacion : AnimatedSprite2D
@export var sound : AudioStreamPlayer2D

@export var yellow_weight : float = 10
@export var blue_weight : float = 5
@export var red_weight : float = 1
var total_weight : float = yellow_weight+blue_weight+red_weight
var elements = ["yellow", "blue", "red"]
var weights = [yellow_weight / total_weight, blue_weight / total_weight, red_weight / total_weight]
# Método llamado al entrar en este estado.

# Define el comportamiento y la estrella que entrega
var seed_type : String

# se comunica con el communication bus
@onready var bus = get_tree().get_first_node_in_group("ComBusGroup")


func Enter():
	var star_seed = randf()
	var cumulative_weight = 0.0
	for i in range(weights.size()):
		cumulative_weight += weights[i]
		if star_seed <= cumulative_weight:
			seed_type = elements[i]
			print(elements[i])
			break
	# choose animation and stats
	if seed_type == "yellow":
		animacion.play("starseed_anim_yellow")
	elif seed_type == "blue":
		animacion.play("starseed_anim_blue")
	elif seed_type == "red":
		animacion.play("starseed_anim_red")

# Método llamado al salir de este estado.
func Exit():
	pass

# Método llamado en cada fotograma para actualizar el estado.
# Parámetro "_delta" representa la cantidad de tiempo transcurrido desde el último fotograma.
func Update(_delta: float):
	pass

# Método llamado en cada fotograma de física para actualizar el estado relacionado con física.
# Parámetro "_delta" representa la cantidad de tiempo transcurrido desde el último fotograma.
func Physics_Update(_delta: float):
	pass


func _on_object_body_entered(_body):
	print("took star seed")


func collect(): # que hacer al conseguir eso
	print("collect star seed method")
	if seed_type == "yellow": # "TipoK"
		bus.catch_star_build("TipoK")
	elif seed_type == "blue": # "TipoK"
		bus.catch_star_build("TipoA")
	elif seed_type == "red":
		print("metodo no implementado para red")
		print("tengo considerado usar un metoedo random")
	
