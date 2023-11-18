extends Node
class_name Movement # es una clase

# Configuración exportada
@export var speed: float = 32.0
@export var max_speed: float = 35.0

var character: CharacterBody2D
func setup(character2D: CharacterBody2D):
	#print("running setup movement on:, ", character2D)
	character = character2D

# mueve tipos characterBody2D
# se eligio esto para los enemigos para calcular menos fuerzas
func move(input_vector: Vector2, _speed:float = speed):
	character.velocity = (input_vector.normalized() * _speed)
	character.look_at(input_vector + character.global_position)
	#character.call_deferred("move_and_slide")
	character.move_and_slide()

func move_to(object_tomove : Node2D, _speed : float = speed):
	var r_ri : Vector2 = object_tomove.position #posición relativa
	character.velocity = r_ri * _speed
	character.move_and_slide()
	
func stop_movement():
	character.velocity = Vector2.ZERO
	
	
	


