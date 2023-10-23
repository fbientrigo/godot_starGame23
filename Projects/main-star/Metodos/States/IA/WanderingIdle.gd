extends State
class_name WanderingIdle

@export var object : CharacterBody2D
@export var move_speed := 10.0

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	wander_time = randf_range(1,4)
	
func Enter():
	randomize_wander()
	
func Update(delta:float):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func Physics_Update(delta:float):
	if object:
		#object.movement.velocity = move_direction * move_speed
		object.movement.move(move_direction, move_speed)
