extends Node2D

signal engine_state_changed(old_value, new_value)

# Define the engine states
enum EngineStates {
	IDLE,
	BASE_THRUST,
	SUPER_THRUST
}

@export var spaceship_1_path: NodePath
@export var engine_anim_path: NodePath


@onready var spaceship_1 = get_node(spaceship_1_path)
@onready var engine_anim = get_node(engine_anim_path)


var current_engine_state = EngineStates.IDLE

func _ready():
	# Connect the signal for when the state changes
	spaceship_1.connect("engine_state_changed", spaceship_1._on_EngineState_Changed)
	
func change_engine_state():
	if Input.is_action_just_pressed("i"):
		var old_state = current_engine_state
		current_engine_state = EngineStates.BASE_THRUST
		engine_state_changed.emit()




# =======
func _process(_delta):
	if Input.is_action_pressed("space"):
		engine_anim.play("base_engine_idle")
	else:
		engine_anim.stop()

