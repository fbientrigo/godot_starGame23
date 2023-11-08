extends StateMachine
class_name WeaponStateMachine

# Variables
var state_names : Array = [] # Lista para almacenar los nombres de los estados
var new_state_index : int = 0 # Índice del estado actual

# Función _ready
func _ready():
	super._ready()
	# Obtener los nombres de los estados del diccionario
	state_names = states.keys()
	#print(state_names)

func _process(_delta):
	if Input.is_action_just_pressed("i"):
		# Iterar al siguiente estado en la lista
		new_state_index += 1
		if new_state_index >= state_names.size():
			new_state_index = 0

		# Obtener el nombre del estado actual
		var _state_name = state_names[new_state_index]

		# Hacer algo con el estado actual (por ejemplo, cambiar a ese estado)
		# Aquí debes realizar la implementación específica que deseas
		on_child_transition(current_state,_state_name)

		

func _on_equipment_shoot(_rotation, _location):
	current_state.fire(_rotation, _location)

