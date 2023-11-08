# State Machine (Máquina de Estados)
# Este script define una máquina de estados que permite gestionar los estados de un objeto en el juego.
# Puedes agregar nodos de tipo estado a esta máquina para determinar el comportamiento del objeto en diferentes situaciones.

extends Node2D
class_name StateMachine

# Variable que almacena el estado inicial de la máquina.
@export var initial_state : State

# Variables que controlan el estado actual y los estados disponibles.
var current_state : State
@export var states : Dictionary = {}

func _ready():
	load_states()

func load_states():
	# En el evento "ready," se recorren los hijos de la máquina en busca de nodos de tipo "State."
	for child in get_children():
		#print("children:,", child)
		if child is State:
			states[child.name.to_lower()] = child  # Se actualiza el diccionario de estados.
			# Se conecta la señal "Transitioned" de cada estado a la función "on_child_transition."
			child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		# Si se ha definido un estado inicial, se llama al método "Enter" de ese estado.
		initial_state.Enter()
		current_state = initial_state
	#print(states)


func _process(delta):
	if current_state:
		# En cada proceso, se llama al método "Update" del estado actual (si existe).
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		# En cada proceso de física, se llama al método "Physics_Update" del estado actual (si existe).
		current_state.Physics_Update(delta)

# Función que maneja las transiciones entre estados.
func on_child_transition(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		return
	if current_state:
		# Si hay un estado actual, se llama a su método "exit" antes de la transición.
		current_state.Exit()
	new_state.Enter()
	current_state = new_state

# Función para cambiar el estado inicial.
func set_initial_state(new_initial_state: State):
	if new_initial_state in states.values():
		initial_state = new_initial_state
		if current_state:
			current_state.Exit()
		initial_state.Enter()
		current_state = initial_state
	else:
		print("Error en StateMachine.gd")
		var parent_node = get_parent()
		print("	nodo padre es: ", parent_node)
		print("El nuevo estado inicial no está en la lista de estados disponibles.")

# =------ señales:




# Uso de la State Machine (Máquina de Estados):
# 1. Agregar la State Machine a un nodo en tu escena (por ejemplo, un personaje).
# 2. Agregar nodos hijos de tipo "State" a la State Machine.
# 3. Define el estado inicial configurando la variable "initial_state."
# 4. Cada nodo "State" debe tener métodos "Enter," "Update" y "Physics_Update" para gestionar su comportamiento.
# 5. Utiliza señales para indicar transiciones entre estados, por ejemplo, cuando ciertas condiciones se cumplen.
# 6. La State Machine llamará automáticamente los métodos correspondientes en el estado actual.
