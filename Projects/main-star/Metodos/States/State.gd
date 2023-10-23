# Nodo de Estado (State)
# Este script define una plantilla básica para la creación de nodos de estado en Godot.
# Los nodos de estado se utilizan para controlar el comportamiento de un objeto en diferentes situaciones.

extends Node
class_name State

# Señal emitida cuando se realiza una transición a este estado.
signal Transitioned

# Método llamado al entrar en este estado.
func Enter():
	pass

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

# Uso de un Nodo de Estado:
# 1. Crea un nuevo nodo "State" como hijo de la máquina de estados o componente correspondiente.
# 2. Implementa la lógica específica para ese estado en los métodos "Enter," "Exit," "Update" y "Physics_Update."
# 3. Utiliza la señal "Transitioned" para indicar transiciones entre estados, por ejemplo, cuando se cumplen ciertas condiciones.
# 4. En el nodo de la máquina de estados, configura las transiciones y señales para cambiar entre diferentes estados.

# Ejemplo de transición de estado:
#
# En el nodo de la máquina de estados:
#
# onready var state_machine = $StateMachine
#
# # Algunas condiciones para cambiar de estado
# func _process(delta):
#     if condition1:
#         state_machine.current_state.emit_signal("Transitioned", "NuevoEstado")
#
# En el nodo de estado (NuevoEstado):
#
# func Enter():
#     # Lógica de entrada para el nuevo estado.
#
# func Exit():
#     # Lógica de salida del estado actual.
#
# func Update(_delta):
#     # Lógica de actualización del estado.
#
# func Physics_Update(_delta):
#     # Lógica de actualización relacionada con la física del estado.
#
