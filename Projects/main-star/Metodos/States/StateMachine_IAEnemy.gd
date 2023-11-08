extends StateMachine

# vairables:
# @export var initial_state : State
# var current_state : State
# var states : Dictionary = {}

# IA Thinking variables
var player_area : Area2D

func _ready():
	load_states()
	#on_child_transition(current_state, "EnemyFollow")
	


func _on_sensor_area_entered(area):
	player_area = area
	on_child_transition(current_state, "EnemyFollow")

