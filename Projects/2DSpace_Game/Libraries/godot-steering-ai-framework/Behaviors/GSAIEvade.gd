# Calculates acceleration to take an agent away from where a target agent is
# moving.
# category: Individual behaviors
class_name GSAIEvade
extends GSAIPursue


func _init():0).(
	agent, target, predict_time_max
):
	pass


func _get_modified_acceleration() -> float:
	return -agent.linear_acceleration_max
