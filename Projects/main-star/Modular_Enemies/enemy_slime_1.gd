extends CharacterBody2D

@export var movement_speed : float = 20.0

@onready var aliados_tokill = get_tree().get_nodes_in_group("Aliados")
var objective_tokill : Node2D

func _ready():
	print(aliados_tokill)
	aliados_tokill = get_tree().get_nodes_in_group("Aliados")
	objective_tokill = shortest_path()
	print("got objective ", objective_tokill)


func _physics_process(delta):
	var direction = global_position.direction_to(objective_tokill.global_position)
	print("got objective ", objective_tokill)


func shortest_path():
	var shortest_distance :float = 9999
	var choose_objective : Node2D
	for node in aliados_tokill:
		var direction_objevtive = global_position.direction_to(node.global_position)
		if direction_objevtive.dot(direction_objevtive) < shortest_distance:
			choose_objective = node
	return choose_objective
		

