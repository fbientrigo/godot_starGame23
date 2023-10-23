# StarState (Estado de Estrella)
# Este script define un estado específico para controlar el comportamiento de una estrella en el juego.
# Los estados de estrella se utilizan para gestionar las características de una estrella, como su masa y radio, y permiten su evolución.

extends State
class_name StarState

# Propiedades de la Estrella
#@export var estrella: CharacterBody2D
@export var animacion: AnimatedSprite2D
@export var healthcomponent: Area2D
@export var statemachine: StateMachine

# Método llamado al entrar en este estado.
func Enter():
	pass

# Método de actualización relacionado con la física de la estrella.
# Parámetro "_delta" representa la cantidad de tiempo transcurrido desde el último fotograma.
func Physics_Update(_delta: float):
	pass


# Desactiva todos los hitboxes hijos.
# Desactiva todas las CollisionShape2D en nodos State dentro del nodo StateMachine.
func _disable_all_hitboxes(state_machine: StateMachine):
	for child in state_machine.get_children():
		if child is State:
			for state_child in child.get_children():
				if state_child is CollisionShape2D:
					state_child.set_deferred("disabled", true)


# Activa un hitbox específico basado en el nodo CollisionShape2D proporcionado.
func _set_active_hitbox(hitbox_node: CollisionShape2D):
	if hitbox_node:
		# Usar el nodo CollisionShape2D proporcionado
		hitbox_node.set_deferred("disabled", false)



# Uso del Estado de Estrella:
# 1. Crea un nuevo nodo "StarState" como hijo de una estrella o componente relacionado.
# 2. Personaliza las propiedades "estrella" y "animacion" para que se ajusten a la estrella actual.
# 3. Implementa la lógica específica para ese estado en el método "Enter" y "Physics_Update."
# 4. En el nodo de la estrella, utiliza la máquina de estados para controlar la transición a este estado cuando sea necesario.

# Ejemplo de cómo utilizar el Estado de Estrella:
#
# En el nodo de la estrella:
#
# onready var state_machine = $StateMachine
#
# # Algunas condiciones para cambiar al estado de estrella:
# func _process(delta):
#     if condition2:
#         state_machine.current_state.emit_signal("Transitioned", "StarState")
#
# En el nodo de estado (StarState):
#
# func Enter():
#     # Lógica de entrada para el estado de estrella.
#
# func Physics_Update(_delta):
#     # Lógica de actualización relacionada con la física de la estrella en este estado.
#
