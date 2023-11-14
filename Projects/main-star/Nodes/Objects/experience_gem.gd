#ObjectNode interactable
extends Area2D
class_name InteractionObject

@export var experience = 1

var target = null
var speed = -0.1

@onready var animation = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D
@onready var statemachine : StateMachine = $StateMachine

@export_enum("Pickable","StarSeed","Default") var tipo_obj:String = "Pickable"

func _ready():
	# Sección de busquedo usando enum =============
	var nodo_hijo = statemachine.get_node(tipo_obj)
	#print(nodo_hijo)
	if nodo_hijo:
		#print("nodo hijo encontrado")
		statemachine.initial_state = nodo_hijo
		
		statemachine.set_initial_state(nodo_hijo)
	else:
		print("Nodo hijo no encontrado.")


func collect():
	sound.play()
	collision.call_deferred("set","disabled",true)
	animation.visible = false
	queue_free() #temporal
	return experience



func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2*delta


func _on_snd_collected_finished():
	queue_free()
