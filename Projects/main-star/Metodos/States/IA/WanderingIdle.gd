extends State
class_name WanderingIdle

@export var object : CharacterBody2D
@export var move_speed := 10.0
@onready var movement : Movement = $"../../Movement"
var move_direction : Vector2 = Vector2(1,1)
var wander_time : float = 2
var wandering: bool = false
var stars = []

#func _ready():
#	stars = get_tree().get_nodes_in_group("Star")
#	print("Wandering idel stars: ", stars)

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(2,5)
	
func Enter():
	stars = get_tree().get_nodes_in_group("Star")
	print("Wandering idel stars: ", stars)
	movement.setup(object)
	
	# randomize_wander()
	
func Update(delta:float):
	move_direction = - object.global_position.normalized()

func Physics_Update(delta:float):
	if object and is_instance_valid(movement):
		movement.move(move_direction, move_speed)
