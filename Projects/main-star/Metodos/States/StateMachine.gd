extends Node2D
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready(): # StateMachine contiene hijos que son estados
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child # update dictionary
			child.Transitioned.connect(on_child_transition) #señal
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state


func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name): # Transcicion de estados y señales
	if state != current_state:
		return
	var new_state = state.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
		
		
